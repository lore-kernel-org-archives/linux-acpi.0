From: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest acpica
Date: Tue, 18 Oct 2005 20:38:26 -0700
Message-ID: <c0a09e5c0510182038t392d360fl994264fe90e53894@mail.gmail.com>
References: <971FCB6690CD0E4898387DBF7552B90E031CC3AC@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19771_4097339.1129693106428"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E031CC3AC-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_Part_19771_4097339.1129693106428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Debian may be OK using flex-old but distros less concerned with backwards
compatibility, such as Red Hat Fedora, no longer ship it. "flex -l" got it
compiling but produced compilation errors (see Mattia's email), so I'd thin=
k
it probably just needs a few more nudges to start working.

Once it compiles, then we can package it and get it added to the Fedora
Extras repo. Then FC users can type "yum install iasl" and have it
automatically installed and ready to go, which I think would make getting
started with iasl a lot easier.

Regards -- Andy

On 10/18/05, Moore, Robert <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
>  It is my understanding that only flex-old will work to build iASL,
> because the new flex is not compatible with lex in some important areas.
>
> I don't know any more than this.
>
> Bob
> ----Original Message-----
>
> *From:* acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:
> acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] *On Behalf Of *Andrew Grover
> *Sent:* Tuesday, October 18, 2005 1:24 PM
> *To:* acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Moore, Robert
> *Subject:* Re: [ACPI] Latest acpica
>
>  Yeah I wish I knew enough flex to fix it, too. How hard can it be? :) --
> Andy
>
> On 10/18/05, *Mattia Dongili* <malattia-k2GhghHVRtY@public.gmane.org > wrote:
>
> On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:
> > I am using GNU flex 2.5.31. I was able to get it to build (on x86_64
> even)
> > with the attached patch. I have also attached the warnings, in case
> those
> > are of interest.
>
> I tried building my DSDT with a patched iasl built with the latest flex
> available in debian (2.5.31) but it seems the -l flag is doing more bad
> than good. I get a bunch of (meaningless) errors:
>
> DSDT.dsl 34: Scope (\_GPE)
> Error 1094 - ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ')'
>
> DSDT.dsl 38: Notify (\_SB.PCI0.USB1, 0x02)
> Error 1094 - ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ','
>
> DSDT.dsl 38: Notify (\_SB.PCI0.USB1, 0x02)
> Error 1094 - ^ Invalid character (0x2E), expecting ASL keyword or name
>
> DSDT.dsl 43: Notify (\_SB.PCI0.USB2, 0x02)
> Error 1094 - ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ','
> ...
> ...
> ASL Input: DSDT.dsl - 3597 lines, 124899 bytes, 20 keywords
> Compilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 Optimizations
>
> while building with flex-old I only get:
>
> DSDT.dsl 1347: Field (ECR, AnyAcc, Lock, Preserve)
> Error 1073 - ^ Host Operation Region requires ByteAcc access
>
> ASL Input: DSDT.dsl - 3896 lines, 131852 bytes, 1959 keywords
> Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 388 Optimizations
>
> So I'll probably simply build-depend on flex-old by now and I'll try to
> learn
> more of flex soon :)
>
> --
> mattia
> :wq!
>
>

------=_Part_19771_4097339.1129693106428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Debian may be OK using flex-old but distros less concerned with
backwards compatibility, such as Red Hat Fedora, no longer ship it.
&quot;flex -l&quot; got it compiling but produced compilation errors (see
Mattia's email), so I'd think it probably just needs a few more nudges
to start working.<br>
<br>
Once it compiles, then we can package it and get it added to the Fedora
Extras repo. Then FC users can type &quot;yum install iasl&quot; and have i=
t
automatically installed and ready to go, which I think would make
getting started with iasl a lot easier.<br>
<br>
Regards -- Andy<br><br><div><span class=3D"gmail_quote">On 10/18/05, <b cla=
ss=3D"gmail_sendername">Moore, Robert</b> &lt;<a href=3D"mailto:robert.moor=
e@intel.com">robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">














<div>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">It is my understanding that only f=
lex-old
will work to build iASL, because the new flex is not compatible with lex in
some important areas.</span></font></p>



<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">I don't know any more than this.</=
span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">Bob</span></font></p><font color=
=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-fa=
mily: Arial; color: navy;">
</span></font> ----Original Message-----<br>
<div style=3D"border-style: none none none solid; border-color: -moz-use-te=
xt-color -moz-use-text-color -moz-use-text-color blue; border-width: medium=
 medium medium 1.5pt; padding: 0in 0in 0in 4pt;"><span class=3D"q"><p><font=
 face=3D"Tahoma" size=3D"2">
<span style=3D"font-size: 10pt; font-family: Tahoma;">
<b><span style=3D"font-weight: bold;">From:</span></b>
<a href=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" target=3D"_blank"=
 onclick=3D"return top.js.OpenExtLink(window,event,this)">acpi-devel-admin@=
lists.sourceforge.net</a>
[mailto:<a href=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" target=3D=
"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">acpi-deve=
l-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>] <b><span style=3D"font-weight: bold;">On=
 Behalf Of=20
</span></b>Andrew Grover<br>
<b><span style=3D"font-weight: bold;">Sent:</span></b> Tuesday, October 18,=
 2005
1:24 PM<br>
<b><span style=3D"font-weight: bold;">To:</span></b>
<a href=3D"mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">acpi-devel-5NWGOfrQmncRDUWM+popnw@public.gmane.org=
forge.net</a>; Moore, Robert<br>
<b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [ACPI] Latest=
 acpica</span></font></p>

<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size: 12pt=
;">&nbsp;</span></font></p></span><div><span class=3D"e" id=3D"q_107056de70=
f0b738_2">

<p style=3D"margin-bottom: 12pt;"><font face=3D"Times New Roman" size=3D"3"=
><span style=3D"font-size: 12pt;">Yeah I wish I knew enough
flex to fix it, too. How hard can it be? :) -- Andy</span></font></p>

<div>

<p><span><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size=
: 12pt;">On 10/18/05, <b><span style=3D"font-weight: bold;">Mattia
Dongili</span></b> &lt;<a href=3D"mailto:malattia-k2GhghHVRtY@public.gmane.org" target=3D"_blan=
k" onclick=3D"return top.js.OpenExtLink(window,event,this)">malattia@linux.=
it </a>&gt;
wrote:</span></font></span></p>

<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size: 12pt=
;">On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:<br>
&gt; I am using GNU flex 2.5.31. I was able to get it to build (on x86_64 e=
ven)<br>
&gt; with the attached patch. I have also attached the warnings, in case th=
ose<br>
&gt; are of interest.<br>
<br>
I tried building my DSDT with a patched iasl built with the latest flex <br=
>
available in debian (2.5.31) but it seems the -l flag is doing more bad<br>
than good. I get a bunch of (meaningless) errors:<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;34:&nbsp;&nbsp;&nbsp;&nbsp; Scope (\_GPE)<b=
r>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ')'<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
^ Invalid character (0x2E), expecting ASL keyword or name<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;43:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB2, 0x02)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br>
...<br>
...<br>
ASL Input:&nbsp;&nbsp;DSDT.dsl - 3597 lines, 124899 bytes, 20 keywords<br>
Compilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 Optimizations<br>
<br>
while building with flex-old I only get: <br>
<br>
DSDT.dsl&nbsp;&nbsp;1347:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Field (ECR, AnyAcc, Lock, Preserve)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1073
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
Host Operation Region requires ByteAcc access<br>
<br>
ASL Input:&nbsp;&nbsp;DSDT.dsl - 3896 lines, 131852 bytes, 1959 keywords<br=
>
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 388 Optimizations<br=
>
<br>
So I'll probably simply build-depend on flex-old by now and I'll try to lea=
rn <br>
more of flex soon :)<br>
<br>
--<br>
mattia<br>
:wq!</span></font></p>

</div>

<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size: 12pt=
;">&nbsp;</span></font></p>

</span></div></div>

</div>





</blockquote></div><br>

------=_Part_19771_4097339.1129693106428--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
