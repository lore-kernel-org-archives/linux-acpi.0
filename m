From: "Carda, Chris" <Chris.Carda-WAQBmITiDcc@public.gmane.org>
Subject: What are the two lines?
Date: Thu, 7 Aug 2003 16:32:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D99FFC7D068F90499DD621D7E519BFCB05CC73@MSGMMKCLA2WIN.DMN1.FMR.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-a0721045-6879-43d2-a3a0-d5e583e1b064"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------=_NextPartTM-000-a0721045-6879-43d2-a3a0-d5e583e1b064
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C35D23.035A119B"

------_=_NextPart_001_01C35D23.035A119B
Content-Type: text/plain

Can someone detail what the two lines are to make this DSDT for a Compaq
N410c compile without errors.  Compaq seems to have fixed everything but the
errors listed below in their latest BIOS rev.

Thank you kindly,
-Chris

From: Darren Benham <dbenham-9p2edxGk3WQ@public.gmane.org> 

 Add two lines... I think they are "external" (you can check the specs to
 be sure).  This tells the comiler that those symbols exist in an external
 table (your SSDTs if it's anything like my n600c.  I don't have it booted
 otherwise I'd give the exact lines.
 
 Hugo Haas said:
 > Hi.
 >
 > I have seen people posting DSDT questions here, and found lots of
 > useful pointers in the archive, so I am sending a report on getting ACPI
 > to work on a Compaq Evo N410c.
 >
 > In a nutshell, some things were not detected, such as the fan, which was
 > a problem. After tweaking the DSDT, I got rid of most errors
 > (although one of my fixes is slightly random) and got most things
 > working. It is now usable. The fan is always on though, but I guess that
 > it's better than always off!
 >
 > I noted that the errors I got were _really_ similar to errors that
 > people with N600c got. I would appreciate a pointer to a diff of the
 > DSDT to try and complete my fixes since it seems that there were a few
 > discussions about this one.
 >
 > The errors I have left are about non existing objects that I have no
 > clue about:
 >
 > | dsdt.dsl    53:             If (LEqual (\C001, 0x00))
 > | Error    1022 -       Object does not exist ^  (\C001)
 > |
 > | dsdt.dsl  5602:                 \_PR.C000
 > | Error    1022 -   Object does not exist ^  (\_PR.C000)
 > |
 > | dsdt.dsl  5642:                 \_PR.C000
 > | Error    1022 -   Object does not exist ^  (\_PR.C000)
 > |
 > | dsdt.dsl  5710:                         Notify (\_PR.C000, 0x80) |
 > Error    1022 -                   Object does not exist ^  (\_PR.C000)
 >
 > Since I found it quite hard to find information to get a working ACPI, I
 > have documented what I have done, with the DSDT, the diffs, etc.
 > Hopefully that will be useful to people:
 >
 > 	 http://larve.net/people/hugo/2003/03/acpi-n410c.html
<http://larve.net/people/hugo/2003/03/acpi-n410c.html> 
 >
 > If anybody has insight about how to get the fan not to always be on and
 > how to fix the rest of my errors, in particular Evo N600c owners, I'd be
 > grateful.
 >
 > Regards,
 >
 > Hugo
 >
 > --
 > Hugo Haas - http://larve.net/people/hugo/ <http://larve.net/people/hugo/>

 >
 >
 > -------------------------------------------------------
 > This SF.net email is sponsored by: Etnus, makers of TotalView, The
 > debugger  for complex code. Debugging C/C++ programs can leave you
 > feeling lost and  disoriented. TotalView can help you find your way.
 > Available on major UNIX  and Linux platforms. Try it free.
http://www.etnus.com <http://www.etnus.com> 
 > _______________________________________________
 > Acpi-devel mailing list
 > Acpi-devel-I+uqrFQUvWk@public.gmane.org
 > https://lists.sourceforge.net/lists/listinfo/acpi-devel
<https://lists.sourceforge.net/lists/listinfo/acpi-devel> 
 
 
 -- 
 Darren
 


Thank you kindly,

Christopher J. Carda
Senior Systems Admin
1 Federal Street E30D
o:617-392-1569
c:617-212-6390


------_=_NextPart_001_01C35D23.035A119B
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.19">
<TITLE>What are the two lines?</TITLE>
</HEAD>
<BODY>

<P><FONT FACE=3D"Times New Roman">Can someone detail what the two lines =
are to make this DSDT for a Compaq N410c compile without errors.&nbsp; =
Compaq seems to have fixed everything but the errors listed below in =
their latest BIOS rev.</FONT></P>

<P><FONT FACE=3D"Times New Roman">Thank you kindly,</FONT>
<BR><FONT FACE=3D"Times New Roman">-Chris</FONT>
</P>

<P><FONT FACE=3D"Times New Roman">From: Darren Benham =
&lt;dbenham-9p2edxGk3WQ@public.gmane.org&gt;<BR>
</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;Add two lines... I think =
they are &quot;external&quot; (you can check the specs to</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;be sure).&nbsp; This =
tells the comiler that those symbols exist in an external</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;table (your SSDTs if it's =
anything like my n600c.&nbsp; I don't have it booted</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;otherwise I'd give the =
exact lines.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;Hugo Haas said:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Hi.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; I have seen people =
posting DSDT questions here, and found lots of</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; useful pointers in =
the archive, so I am sending a report on getting ACPI</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; to work on a Compaq =
Evo N410c.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; In a nutshell, some =
things were not detected, such as the fan, which was</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; a problem. After =
tweaking the DSDT, I got rid of most errors</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; (although one of my =
fixes is slightly random) and got most things</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; working. It is now =
usable. The fan is always on though, but I guess that</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; it's better than =
always off!</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; I noted that the =
errors I got were _really_ similar to errors that</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; people with N600c =
got. I would appreciate a pointer to a diff of the</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; DSDT to try and =
complete my fixes since it seems that there were a few</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; discussions about =
this one.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; The errors I have =
left are about non existing objects that I have no</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; clue about:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | =
dsdt.dsl&nbsp;&nbsp;&nbsp; =
53:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; If (LEqual (\C001, 0x00))</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | =
Error&nbsp;&nbsp;&nbsp; 1022 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Object does not exist ^&nbsp; (\C001)</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; |</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | dsdt.dsl&nbsp; =
5602:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \_PR.C000</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | Error&nbsp;&nbsp;&n=
bsp; 1022 -&nbsp;&nbsp; Object does not exist ^&nbsp; =
(\_PR.C000)</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; |</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | dsdt.dsl&nbsp; =
5642:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \_PR.C000</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | =
Error&nbsp;&nbsp;&nbsp; 1022 -&nbsp;&nbsp; Object does not exist =
^&nbsp; (\_PR.C000)</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; |</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; | dsdt.dsl&nbsp; =
5710:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; Notify (\_PR.C000, 0x80) |</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; =
Error&nbsp;&nbsp;&nbsp; 1022 =
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Object does not exist ^&nbsp; =
(\_PR.C000)</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Since I found it =
quite hard to find information to get a working ACPI, I</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; have documented what =
I have done, with the DSDT, the diffs, etc.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Hopefully that will =
be useful to people:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT><A =
HREF=3D"http://larve.net/people/hugo/2003/03/acpi-n410c.html"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://larve.net/people/hugo/2003/03/acpi-n410c.html</FONT></U></A>=

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; If anybody has =
insight about how to get the fan not to always be on and</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; how to fix the rest =
of my errors, in particular Evo N600c owners, I'd be</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; grateful.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Regards,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Hugo</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; --</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Hugo Haas - =
</FONT><A HREF=3D"http://larve.net/people/hugo/"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://larve.net/people/hugo/</FONT></U></A>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; =
-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; This SF.net email is =
sponsored by: Etnus, makers of TotalView, The</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; debugger&nbsp; for =
complex code. Debugging C/C++ programs can leave you</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; feeling lost =
and&nbsp; disoriented. TotalView can help you find your way.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Available on major =
UNIX&nbsp; and Linux platforms. Try it free. </FONT><A =
HREF=3D"http://www.etnus.com"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Courier New">http://www.etnus.com</FONT></U></A>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; Acpi-devel mailing =
list</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; =
Acpi-devel-I+uqrFQUvWk@public.gmane.org</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&gt; </FONT><A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel"><U><FON=
T COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">https://lists.sourceforge.net/lists/listinfo/acpi-devel</FONT></U><=
/A>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;-- </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;Darren</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>
</P>
<BR>

<P><FONT FACE=3D"Bradley Hand ITC">Thank you kindly,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Papyrus">Christopher J. Carda</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Papyrus">Senior Systems Admin</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Papyrus">1 Federal Street E30D</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Papyrus">o:617-392-1569</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Papyrus">c:617-212-6390</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C35D23.035A119B--

------=_NextPartTM-000-a0721045-6879-43d2-a3a0-d5e583e1b064--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
