From: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest acpica
Date: Tue, 18 Oct 2005 13:23:38 -0700
Message-ID: <c0a09e5c0510181323w56e96b02y354bb04e13bcb278@mail.gmail.com>
References: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com>
	 <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f@mail.gmail.com>
	 <20051018201407.GB3945@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14910_20695189.1129667018606"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051018201407.GB3945-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

------=_Part_14910_20695189.1129667018606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Yeah I wish I knew enough flex to fix it, too. How hard can it be? :) --
Andy

On 10/18/05, Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org> wrote:
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

------=_Part_14910_20695189.1129667018606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Yeah I wish I knew enough flex to fix it, too. How hard can it be? :) -- An=
dy<br><br><div><span class=3D"gmail_quote">On 10/18/05, <b class=3D"gmail_s=
endername">Mattia Dongili</b> &lt;<a href=3D"mailto:malattia-k2GhghHVRtY@public.gmane.org">mala=
ttia-k2GhghHVRtY@public.gmane.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:<br>&gt;=
 I am using GNU flex=20
2.5.31. I was able to get it to build (on x86_64 even)<br>&gt; with the att=
ached patch. I have also attached the warnings, in case those<br>&gt; are o=
f interest.<br><br>I tried building my DSDT with a patched iasl built with =
the latest flex
<br>available in debian (2.5.31) but it seems the -l flag is doing more bad=
<br>than good. I get a bunch of (meaningless) errors:<br><br>DSDT.dsl&nbsp;=
&nbsp;&nbsp;&nbsp;34:&nbsp;&nbsp;&nbsp;&nbsp; Scope (\_GPE)<br>Error&nbsp;&=
nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ')'<br><br>DSDT.dsl&nbs=
p;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br><br>DSDT.dsl&nbs=
p;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
^ Invalid character (0x2E), expecting ASL keyword or name<br><br>DSDT.dsl&n=
bsp;&nbsp;&nbsp;&nbsp;43:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB2, 0x02)<br>Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br>...<br>...<br>AS=
L Input:&nbsp;&nbsp;DSDT.dsl - 3597 lines, 124899 bytes, 20 keywords<br>Com=
pilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 Optimizations<br><br=
>while building with flex-old I only get:
<br><br>DSDT.dsl&nbsp;&nbsp;1347:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
Field (ECR, AnyAcc, Lock, Preserve)<br>Error&nbsp;&nbsp;&nbsp;&nbsp;1073
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
Host Operation Region requires ByteAcc access<br><br>ASL Input:&nbsp;&nbsp;=
DSDT.dsl - 3896 lines, 131852 bytes, 1959 keywords<br>Compilation complete.=
 1 Errors, 0 Warnings, 0 Remarks, 388 Optimizations<br><br>So I'll probably=
 simply build-depend on flex-old by now and I'll try to learn
<br>more of flex soon :)<br><br>--<br>mattia<br>:wq!<br></blockquote></div>=
<br>

------=_Part_14910_20695189.1129667018606--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
