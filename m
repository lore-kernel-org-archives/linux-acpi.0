From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: ACPI Compaq Presario
Date: Mon, 29 Jul 2002 17:21:46 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207292121.RAA17223@cathedral-seven.mit.edu>
References: <000001c23742$9e9ec650$9865fea9@AMAINSLT>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Mon, 29 Jul 2002 16:57:50 EDT."
             <000001c23742$9e9ec650$9865fea9-9tCyY70DaME@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "A.MAINS" <armains-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Hi,

I have the Presario 2800, which is the sister machine to
the Evo N800.  A quick search on the archives will show
my messages on getting things to work, and similar 
experiences for other Compaq Presario users.

A synopsis of my functionality as relating to ACPI
(I'm using 2.4.18+acpi-20020709+nocorruption.2+swsusp9):

* No battery entry in /proc/acpi, so I'm 
flying blind.  Another user notes that fan policy
is handled at the machine level, so no ACPI 
interface for the fan, either.

* Suspend to disk and sleep on lid-closing works, 
provided X has only run w/o DRI since the last 
power up; once you fire up X w/ DRI enabled, neither
will work unless you reboot.

* Haven't played with setting CPU throttling policy,
but the /proc/acpi/processor tree seems complete, and
the speed stepping from 1.6GHz to 1.2GHz happens 
automatically.

* Device hot swap works, sort of.  I can monkey around
with the floppy, but the CDRW/DVD has to be present at
boot for Linux to appreciate its existence.  Not sure
about the battery since the entry for the primary
battery has yet to work ...

Only the first of these issues is a show stopper.

The one thing I'll try tonight is to deactivate 
ACPI debugging in the kernel config, to see if that
has any effect.  Other than that, I'm out of ideas
beyond waiting for new patches and patching the DSDT.


Regards,

Sourav



> This is a multi-part message in MIME format.
> 
> ------=_NextPart_000_0001_01C23721.178D2650
> Content-Type: text/plain;
> 	charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> 
> Hello
>  
> I am new to this list and I have had a problem in which has been bugging
> me for the longest time. I am running linux on a Compaq Presario 2700US
> Laptop with Kernel 2.4.18 with ACPI Patch 20020726 along with
> kacpid.patch (which I am not sure does anything for my system). This
> machine in very similar to the newer Evo Laptops as well as the Presario
> 1700 and 700 Line of notebooks in terms of the BIOS and hardware
> configurations.  
>  
> Anyway, ACPI compiled well into my system. Unfortunately after doing a
> lot of research, it is almost useless to me. I know ACPI is under
> development but also understand that Battery Status and Power Status is
> fairly well implemented. I can not get either to work. Does anyone have
> experience with these types of machines in linux? I would be very
> interested in hearing about some experiences.  Seeing the remaining
> battery as well as if the system is on AC or battery is my goal.
>  
> I do cats to /proc/acpi/battery/BAT1/Status and info, yielding "battery
> not present". 
>  
> Thanks in advance for any help!
> 
> ------=_NextPart_000_0001_01C23721.178D2650
> Content-Type: text/html;
> 	charset="us-ascii"
> Content-Transfer-Encoding: quoted-printable
> 
> <html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
> xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
> xmlns=3D"http://www.w3.org/TR/REC-html40">
> 
> <head>
> <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
> charset=3Dus-ascii">
> 
> 
> <meta name=3DProgId content=3DWord.Document>
> <meta name=3DGenerator content=3D"Microsoft Word 10">
> <meta name=3DOriginator content=3D"Microsoft Word 10">
> <link rel=3DFile-List href=3D"cid:filelist.xml-jcRblH2VmAR02dXU2D/HNzRmByFHzeGd@public.gmane.org">
> <!--[if gte mso 9]><xml>
>  <o:OfficeDocumentSettings>
>   <o:DoNotRelyOnCSS/>
>  </o:OfficeDocumentSettings>
> </xml><![endif]--><!--[if gte mso 9]><xml>
>  <w:WordDocument>
>   <w:SpellingState>Clean</w:SpellingState>
>   <w:GrammarState>Clean</w:GrammarState>
>   <w:DocumentKind>DocumentEmail</w:DocumentKind>
>   <w:EnvelopeVis/>
>   <w:Compatibility>
>    <w:BreakWrappedTables/>
>    <w:SnapToGridInCell/>
>    <w:WrapTextWithPunct/>
>    <w:UseAsianBreakRules/>
>   </w:Compatibility>
>   <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
>  </w:WordDocument>
> </xml><![endif]-->
> <style>
> <!--
>  /* Style Definitions */
>  p.MsoNormal, li.MsoNormal, div.MsoNormal
> 	{mso-style-parent:"";
> 	margin:0in;
> 	margin-bottom:.0001pt;
> 	mso-pagination:widow-orphan;
> 	font-size:12.0pt;
> 	font-family:"Times New Roman";
> 	mso-fareast-font-family:"Times New Roman";}
> a:link, span.MsoHyperlink
> 	{color:blue;
> 	text-decoration:underline;
> 	text-underline:single;}
> a:visited, span.MsoHyperlinkFollowed
> 	{color:purple;
> 	text-decoration:underline;
> 	text-underline:single;}
> span.EmailStyle17
> 	{mso-style-type:personal-compose;
> 	mso-style-noshow:yes;
> 	mso-ansi-font-size:10.0pt;
> 	mso-bidi-font-size:10.0pt;
> 	font-family:Arial;
> 	mso-ascii-font-family:Arial;
> 	mso-hansi-font-family:Arial;
> 	mso-bidi-font-family:Arial;
> 	color:windowtext;}
> span.SpellE
> 	{mso-style-name:"";
> 	mso-spl-e:yes;}
> span.GramE
> 	{mso-style-name:"";
> 	mso-gram-e:yes;}
> @page Section1
> 	{size:8.5in 11.0in;
> 	margin:1.0in 1.25in 1.0in 1.25in;
> 	mso-header-margin:.5in;
> 	mso-footer-margin:.5in;
> 	mso-paper-source:0;}
> div.Section1
> 	{page:Section1;}
> -->
> </style>
> <!--[if gte mso 10]>
> <style>
>  /* Style Definitions */=20
>  table.MsoNormalTable
> 	{mso-style-name:"Table Normal";
> 	mso-tstyle-rowband-size:0;
> 	mso-tstyle-colband-size:0;
> 	mso-style-noshow:yes;
> 	mso-style-parent:"";
> 	mso-padding-alt:0in 5.4pt 0in 5.4pt;
> 	mso-para-margin:0in;
> 	mso-para-margin-bottom:.0001pt;
> 	mso-pagination:widow-orphan;
> 	font-size:10.0pt;
> 	font-family:"Times New Roman";}
> </style>
> <![endif]-->
> </head>
> 
> <body lang=3DEN-US link=3Dblue vlink=3Dpurple =
> style=3D'tab-interval:.5in'>
> 
> <div class=3DSection1>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'>Hello<o:p></o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'>I am new to this list and I have had a problem in =
> which has
> been bugging me for the longest time. I am running <span =
> class=3DSpellE>linux</span>
> on a Compaq Presario 2700US Laptop with Kernel 2.4.18 with ACPI Patch =
> 20020726
> along with <span class=3DSpellE>kacpid.patch</span> (which I am not sure =
> does
> anything for my system). <span class=3DGramE>This machine in very =
> similar to the
> newer <span class=3DSpellE>Evo</span> Laptops as well as the Presario =
> 1700 and
> 700 Line of notebooks in terms of the BIOS and hardware =
> configurations.</span> <span
> style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>
> 
> <p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
> face=3DArial><span
> style=3D'font-size:10.0pt;font-family:Arial'>Anyway, ACPI compiled well =
> into my
> system.</span></font></span><font size=3D2 face=3DArial><span =
> style=3D'font-size:
> 10.0pt;font-family:Arial'> Unfortunately after doing a lot of research, =
> it is
> almost useless to me. I know ACPI is under development but also =
> understand that
> Battery Status and Power Status is fairly well implemented. I can not =
> get either
> to work. Does anyone have experience with these types of machines in =
> <span
> class=3DSpellE>linux</span>? I would be very interested in hearing about =
> some experiences.
> <span style=3D'mso-spacerun:yes'>&nbsp;</span>Seeing the remaining =
> battery as
> well as if the system is on AC or battery is my =
> goal.<o:p></o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'>I do cats to /proc/acpi/battery/BAT1/Status and info,
> yielding &#8220;battery not present&#8221;. =
> <o:p></o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>
> 
> <p class=3DMsoNormal><font size=3D2 face=3DArial><span =
> style=3D'font-size:10.0pt;
> font-family:Arial'>Thanks in advance for any =
> help!<o:p></o:p></span></font></p>
> 
> </div>
> 
> </body>
> 
> </html>
> 
> ------=_NextPart_000_0001_01C23721.178D2650--
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=3D31
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
