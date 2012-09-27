#coding=utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'parslet/rig/rspec'
require 'random_text_parser'

describe RandomTextParser  do

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

    it {should parse("(A|Б) В")}
end

describe RandomTextTransform do
  let(:parser) { RandomTextParser.new }
  let(:transform) { RandomTextTransform.new }

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

describe ArrayTextTransform do
  let(:parser) { RandomTextParser.new }
  let(:transform) { ArrayTextTransform.new }

  it "should transform properly" do
    result = (parser.parse(<<-TEMPLATE
       (Уважаемые коллеги | Коллеги), (до полуночи осталось (меньше часа|совсем немного)|полночь уже (совсем|очень) скоро)
TEMPLATE
                          ))
    transform.apply(result).join.should == (<<RESULT
       [Уважаемые коллеги , Коллеги], [до полуночи осталось [меньше часа,совсем немного],полночь уже [совсем,очень] скоро]
RESULT
                                      )
  end
end

#RSpec::Core::Runner.run([])
