From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: No network after S3
Date: Mon, 16 Feb 2004 01:10:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
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
To: Peter.Zeipelt-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>I tried pci=3Dnoacpi. No diference.
>If I understand you right, I should wait a little bit before dealing
>with this powersaving stuff.

If the NIC were now working before attempting suspend/resume, then we'd
need to get that fixed first.  However, I think you're saying that the
NIC _does_ work under normal conditions, and the failure is only after
returning from S3. yes?

So this seems suspend/resume specific, and your use of pci=3Dnoacpi
further suggests it has nothing to do with the initial interrupt
assignments.

We've got a number of post-resume failures, and this issue is rising on
the priority list -- so I expect we'll spend some time looking at it
soon.

Here's a bugzilla query of component=3DACPI with the word "suspend".  I
apologize in advance if outlook wraps this url on you...

http://bugzilla.kernel.org/buglist.cgi?short_desc_type=3Dallwordssubstr&s=
h
ort_desc=3D&component=3DACPI&long_desc_type=3Dallwordssubstr&long_desc=3D=
suspend
&kernel_version_type=3Dallwordssubstr&kernel_version=3D&bug_status=3DNEW&=
bug_s
tatus=3DASSIGNED&bug_status=3DRESOLVED&emailassigned_to1=3D1&emailtype1=3D=
substr
ing&email1=3D&emailassigned_to2=3D1&emailreporter2=3D1&emailcc2=3D1&email=
type2=3Ds
ubstring&email2=3D&bugidtype=3Dinclude&bug_id=3D&changedin=3D&chfieldfrom=
=3D&chfie
ldto=3DNow&chfieldvalue=3D&cmdtype=3Ddoit&namedcmd=3Dcomponent%3DACPI&new=
queryna
me=3D&order=3DReuse+same+sort+as+last+time&field0-0-0=3Dnoop&type0-0-0=3D=
noop&va
lue0-0-0=3D


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
