From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Button events lost after S3 on Thinkpad R32
Date: Tue, 9 Dec 2003 09:26:33 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C0B@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Where to find  - Dmitry's input suspend / resume support patches =
--Luming

-----Original Message-----
From: Karol Kozimor [mailto:sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org]
Sent: 2003?12?9? 9:16
To: Yu, Luming
Cc: Li, Shaohua; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brian Perkins
Subject: Re: [ACPI] Button events lost after S3 on Thinkpad R32


Thus wrote Yu, Luming:
> >Just to let you know: my system is fine after S3, i.e. ACPI =
interrupts are
> >not lost (it's an ASUS L3C laptop, FYI).
> What version of kernel you are using?  Did you apply any other =
patches? --Luming

test11, with quite a lot of patches actually:
- http://bugme.osdl.org/attachment.cgi?id=3D1208&action=3Dview
- http://bugme.osdl.org/attachment.cgi?id=3D1029&action=3Dview
- http://bugme.osdl.org/attachment.cgi?id=3D1257&action=3Dview
- Dmitry's input suspend / resume support patches
- possibly others, less relevant

Though as far as I remember, I never had problems with ACPI interrupts
after S3 resume, only after S1.
Best regards,

--=20
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
