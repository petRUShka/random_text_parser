#coding=utf-8
require 'rspec'
require 'parslet/rig/rspec'
require './parser'


describe Parser  do
#  let(:parser) { Parser.new }
#  let(:transform) { Transform.new }

    its(:sentence) {should parse('меньше')}
    its(:sentence) {should parse('меньше часа')}
    its(:sentence) {should_not parse('час|меньше часа')}
    its(:sentence) {should_not parse('(меньше часа)')}

#    its(:or_sentences) {should parse('меньше') }
    its(:simple_or_sentences) {should parse('(час|меньше часа)') }
    its(:simple_or_sentences) {should_not parse('час|меньше часа') }
    its(:simple_or_sentences) {should_not parse('(час|(два часа|три часа))') }

    its(:or_sentences) {should parse('(цифра|(слово|буква))') }
#    its(:or_sentences) {should_not parse('Осталось (меньше|(меньше|часа))') }

    its(:and_sentences) {should parse('Осталось (один час|два часа)') }
    its(:and_sentences) {should parse('(один час|два часа) впереди') }
    its(:and_sentences) {should parse('цифра (четная|нечетная)') }


    its(:or_sentences) {should parse('(цифра (четная|нечетная)|буква)') }
    its(:or_sentences) {should parse('(до заказа осталось (меньше часа|совсем немного)|заказ уже (совсем|очень) скоро)') }

    it {should parse(<<-TEMPLATE
       (Уважаемые коллеги | Коллеги), (до полуночи осталось (меньше часа|совсем немного)|полночь уже (совсем|очень) скоро). ((Убедительная просьба|Прошу) надеть форму | подскажите, почему форма ещё не надета|наденьте, пожалуйста, форму): http://link

  С уважением.
  (Илья Квашин|Петя Иванов|Ещё кто-то).
   TEMPLATE
    )}
end

describe Transform do
  let(:parser) { Parser.new }
  let(:transform) { Transform.new }

  it "should transform properly" do
    pending
    result = (parser.parse(<<-TEMPLATE
       (Уважаемые коллеги | Коллеги), (до полуночи осталось (меньше часа|совсем немного)|полночь уже (совсем|очень) скоро). ((Убедительная просьба|Прошу) надеть форму | подскажите, почему форма ещё не надета|наденьте, пожалуйста, форму): http://link

  С уважением.
  (Илья Квашин|Петя Иванов|Ещё кто-то).
TEMPLATE
                          ))
                          transform.apply(result).join.strip.should == (<<RESULT
Уважаемые коллеги , до полуночи осталось совсем немного. Прошу надеть форму : http://link

  С уважением.
  Петя Иванов.
RESULT
                                                                       )

  end
end

#RSpec::Core::Runner.run([])
