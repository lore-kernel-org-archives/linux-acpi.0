From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-problem with samsung x10 1700
Date: Tue, 23 Dec 2003 11:34:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C49@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "D. S." <silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I just port it to Linux. And filed it at
http://bugzilla.kernel.org/show_bug.cgi?id=3D1729

Nate,=20
 I'm interested in workarounds you have that could help linux too.

--Luming

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nate Lawson
Sent: Saturday, December 20, 2003 4:59 AM
To: Brown, Len
Cc: D. S.; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] acpi-problem with samsung x10 1700

FreeBSD does have a workaround for this.  We use an implicit return
value:
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/contrib/dev/acpica/psparse
.c.diff?r1=3D1.20&r2=3D1.21&f=3Dh

-Nate

On Fri, 19 Dec 2003, Brown, Len wrote:
> AML is like C -- if there is no return statement from a routine
(method)
> then nothing gets returned.
>
> Unfortunately the microsoft implementation of the AML interpreter
> behaves as if there is a return statement, and so bugs in AML get
> through windows validation.
>
> For this to work on the ACPICA AML interpreter, you need to insert the
> missing return statements in the AML -- we don't have a workaround for
> this type of BIOS bug.
>
> -Len
>
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of D. S.
> > Sent: Friday, December 19, 2003 10:10 AM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] acpi-problem with samsung x10 1700
> >
> >
> > hi folks,
> > maybe you folks could help me out.
> > i fixed the dsdt.aml so far that iasl compiles without an error.
> > so far so good.
> >
> > now dmesg gives me the following:
> >
> > acpi-1121: error:method execution failed [\SB_.ADP1._STA] (Node
> > c1613920), AE_AML_NO_RETURN_VALUE
> > acpi-1121: error:method execution failed [\SB_.BAT1._STA] (Node
> > c1613a20), AE_AML_NO_RETURN_VALUE
> >
> > this means, if i'm correct, that the stats for battery and
ac-adapter
> > can't be read.
> > i am not sure where to correct this and how.
> >
> > so you maybe need some info on the machine/dist.
> > samsung x10 xtc1700
> > bios 06ye (samsung orginal shipped)
> > suse 9.0 (wich is patched already for reading dsdt)
> >
> > help would be great!
> >
> > regards
> > d.
> >
> > Some programming languages manage to absorb change, but withstand
> > progress. -- Epigrams in Programming, ACM SIGPLAN Sept. 1982
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: IBM Linux Tutorials.
> > Become an expert in LINUX or just sharpen your skills.  Sign
> > up for IBM's
> > Free Linux Tutorials.  Learn everything from the bash shell
> > to sys admin.
> > Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_i


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for
IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys
admin.
Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
