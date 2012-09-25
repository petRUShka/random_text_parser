#coding=utf-8
require "rubygems"
require "bundler/setup"

require 'pp'
require 'parslet'

class Parser < Parslet::Parser
  rule(:lparen)     { str('(') }
  rule(:rparen)     { str(')') }

  rule(:vertical)      { str('|') }

#  rule(:space)      { match('\s').repeat(1) }
#  rule(:space?)     { space.maybe }

  rule(:sentence) { ( match("[()|]").absent? >> any).repeat(1) }
  rule(:body) {  and_sentences.as(:and_sentences)| sentence.as(:sentence)| simple_or_sentences.as(:simple_or_sentences) | or_sentences   }

  rule(:simple_or_sentences)    { (lparen >> sentence.as(:sentence) >> (vertical >> sentence.as(:sentence)).repeat >> rparen).as(:simple_or_sentences) }
  rule(:or_sentences)    { ( lparen >> body() >> (vertical >> body).repeat >> rparen )}
  rule(:and_sentences) {(or_sentences.as(:or_sentences)|sentence.as(:sentence)).repeat(2,nil)}

  root(:and_sentences)
end

class Transform < Parslet::Transform
  rule(:and_sentences => subtree(:x) ) {
    # innermost :m will contain nil
    x.join("")
  }

  rule(:sentence => simple(:x) ) {
    # innermost :m will contain nil
    x
  }

  rule(:or_sentences => subtree(:x) ) {
    # innermost :m will contain nil
    x[rand(x.length)]
  }
end
#!.each do |pexp|
  #begin
    #result = parser.parse(pexp)
    #puts "#{"%20s"%pexp}: #{result.inspect} (#{transform.apply(result)} parens)"
  #rescue Parslet::ParseFailed => m
    #puts "#{"%20s"%pexp}: #{m}"
  #end
  #puts
#end
