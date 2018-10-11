# Radio-Button-Checkbox-iOS
Radio Button &amp; Checkbox for iOS implemented in accordance to HIG and WCAG2.1

### Screencast
<table>
  <tr>
    <td><img src="https://thumbs.gfycat.com/ViciousUnluckyCuckoo-size_restricted.gif" width="250" height="375"/></td>
  </tr>
</table>

#### Accessibility
<table>
  <tr>
    <td><img src="https://thumbs.gfycat.com/ScholarlyClearcutFoal-size_restricted.gif" width="250" height="375"/></td>
    <td><img src="https://thumbs.gfycat.com/ThreadbareHilariousBovine-size_restricted.gif" width="250" height="375"/></td>
  </tr>
</table>

[![Voice Over Support](https://i.imgur.com/2gqeRO5l.png)](https://www.youtube.com/embed/MpxU6r5skQw "Voice Over Support - Click to Watch!")


You want to add pod 'Radio_and_Checkbox' similar to the following to your Podfile:

```
target 'MyApp' do
  pod 'Radio_and_Checkbox'
end
````

Then run a pod install inside your terminal, or from CocoaPods.app.

Alternatively to give it a test run, run the command:

```
pod try Radio_and_Checkbox
```

This dependency provide accessibility support using Voice Over, Dynamic Text, Smart Invert, Colour Filters, Baseline Anchor and Zoom.


```

@import Radio_and_Checkbox;

```

Usage Code 

```
 let questions = [ RNQuestion(question: "What is your name?", options: ["Mayank", "Reetika", "Neha", "Jai"], type: .singleChoice),
                                   RNQuestion(question: "What is your age?", options: ["30", "28", "22", "19", "17"], type: .singleChoice),
                                   RNQuestion(question: "What are your hobbies?", options: ["Programming", "Books", "Movies", "Travelling"], type: .multipleChoice)
            
            ] as? [RNQuestion]
        
 questionView.questions = questions
```
