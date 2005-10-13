From: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest acpica
Date: Wed, 12 Oct 2005 17:00:41 -0700
Message-ID: <c0a09e5c0510121700saa456d6kff2b05b858bc1251@mail.gmail.com>
References: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com>
	 <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f@mail.gmail.com>
	 <20051012215628.GG3658@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20354_18527943.1129161641979"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051012215628.GG3658-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

------=_Part_20354_18527943.1129161641979
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When you cut through the legalese, the ACPICA license, which is what the
acpica-unix release is released under, is BSD-style. (Proof of this is that
FreeBSD uses it ;-) So there shouldn't be any licensing issues.

As for acpisrc, it is a very specialized tool that works in conjunction wit=
h
some shellscripts to Linuxize the code. I don't think it is worth packaging=
,
since only the guy who ports CA releases to Linux (i.e. Len Brown) really
uses it... but it's there for the curious. (a nit: it doesn't attach GPLv2,
it attaches dual BSD/GPLv2.)

Regards -- Andy (no longer working on acpi, I just want a debian iasl pkg
;-)

On 10/12/05, Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org> wrote:
>
> On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:
> > I am using GNU flex 2.5.31. I was able to get it to build (on x86_64
> even)
> > with the attached patch. I have also attached the warnings, in case
> those
> > are of interest.
> >
> > (Any Debian people want to package iasl?)
>
> I submitted the ITP, but I'm wondering which licence it is supposed to
> be. On the Intel site the Linux package is said to be GPLed but
> downloaded files (and the www licence agreement) don't report that as
> this is the Unix version.
>
> I also gave a shot to the acpisrc tool that moves everything into a
> GPLv2 + CodeStyle clean source tree but the generated source doesn't
> build.
>
> Could anybody clarify it?
>
> Thanks a lot
> --
> mattia
> :wq!
>

------=_Part_20354_18527943.1129161641979
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When you cut through the legalese, the ACPICA license, which is what
the acpica-unix release is released under, is BSD-style. (Proof of this
is that FreeBSD uses it ;-) So there shouldn't be any licensing issues.<br>
<br>
As for acpisrc, it is a very specialized tool that works in conjunction
with some shellscripts to Linuxize the code. I don't think it is worth
packaging, since only the guy who ports CA releases to Linux (i.e. Len
Brown) really uses it... but it's there for the curious. (a nit: it
doesn't attach GPLv2, it attaches dual BSD/GPLv2.)<br>
<br>
Regards -- Andy (no longer working on acpi, I just want a debian iasl pkg ;=
-)<br><br><div><span class=3D"gmail_quote">On 10/12/05, <b class=3D"gmail_s=
endername">Mattia Dongili</b> &lt;<a href=3D"mailto:malattia-k2GhghHVRtY@public.gmane.org">mala=
ttia-k2GhghHVRtY@public.gmane.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:<br>&gt;=
 I am using GNU flex=20
2.5.31. I was able to get it to build (on x86_64 even)<br>&gt; with the att=
ached patch. I have also attached the warnings, in case those<br>&gt; are o=
f interest.<br>&gt;<br>&gt; (Any Debian people want to package iasl?)<br>
<br>I submitted the ITP, but I'm wondering which licence it is supposed to<=
br>be. On the Intel site the Linux package is said to be GPLed but<br>downl=
oaded files (and the www licence agreement) don't report that as<br>this is=
 the Unix version.
<br><br>I also gave a shot to the acpisrc tool that moves everything into a=
<br>GPLv2 + CodeStyle clean source tree but the generated source doesn't<br=
>build.<br><br>Could anybody clarify it?<br><br>Thanks a lot<br>--<br>matti=
a
<br>:wq!<br></blockquote></div><br>

------=_Part_20354_18527943.1129161641979--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
