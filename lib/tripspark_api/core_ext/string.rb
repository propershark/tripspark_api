class String
  def underscore
    self.dup.underscore!
  end unless method_defined? :underscore

  def underscore!
    self.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    self.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    self.tr_s!('- ', '_')
    self.downcase!
  end unless method_defined? :underscore!

  def titleize
    self.tr_s('- ', '_').split('_').map(&:capitalize).join(' ')
  end unless method_defined? :titleize

  def constantize
    self.tr_s('- ', '_').split('_').map(&:capitalize).join
  end unless method_defined? :constantize
end
