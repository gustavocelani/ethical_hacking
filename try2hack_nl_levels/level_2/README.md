# Level 2

## URL

```
http://www.try2hack.nl/levels/level2-xfdgnh.xhtml
```

## Solution

* At first, open the source code to get the flash file included there.

```
view-source:http://www.try2hack.nl/levels/level2-xfdgnh.xhtml
```

Flash file: level2.swf

```
  <object type="application/x-shockwave-flash" data="level2.swf" width="300" height="200">
    <param name="movie" value="level2.swf" />
    <param name="bgcolor" value="#FFFFFF" />
  </object>
```

* Now let's see the level2.swf source code

```
view-source:http://try2hack.nl/levels/level2.swf
```

In there, some keywords can be found:

```
txtUsername        try2hack
txtPassword        irtehh4x0r!
```

## Answer

```
Username: try2hack
Password: irtehh4x0r!
```

