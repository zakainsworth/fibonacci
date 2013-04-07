#!/usr/bin/env jruby

include Java

import javax.swing.JButton
import javax.swing.JFrame
import javax.swing.JOptionPane
import javax.swing.JPanel
import javax.swing.JTextField
import javax.swing.SwingUtilities

class Fibonacci < JFrame
  def initialize
    super "Fibonacci"  
    self.ui
  end
    
  def ui
    self.set_default_close_operation JFrame::EXIT_ON_CLOSE
    self.set_size 180, 130
    self.set_location_relative_to nil
    
    panel = JPanel.new
    panel.set_layout nil
    self.get_content_pane.add panel

    input = JTextField.new
    input.set_bounds 10, 10, 160, 30
    panel.add input

    button = JButton.new "Calculate"
    button.set_bounds 10, 40, 160, 30
    panel.add button

    output = JTextField.new
    output.set_bounds 10, 70, 160, 30
    output.set_editable false
    panel.add output

    button.add_action_listener do |e|
      output.set_text "Calculating..."
      input.set_enabled false
      button.set_enabled false
      Thread.new do
        output.set_text(self.fib(input.get_text.to_i).to_s)
        input.set_enabled true
        button.set_enabled true
      end
    end

    self.set_visible true
  end

  def fib(n)
    n < 2 ? n : fib(n-1) + fib(n-2)
  end
end

Fibonacci.new
event_thread = nil
SwingUtilities.invokeAndWait { event_thread = java.lang.Thread.currentThread }
event_thread.join