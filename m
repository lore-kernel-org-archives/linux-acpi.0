From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: unofficial acpi20020709-2.4.19rc3
Date: 24 Jul 2002 00:18:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1027447735.1546.4.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I had done acpi20020709 for kernel 2.4.19rc3 and works in my computer,
(merge) patching kernel-rc3 acpi20020709=20
the pci-hsf modem in the moment works!
I gives me a lot of work ,
so I think share with you, what I had done, but at least 2 rejected
files that I am not sure if it right solved, are solved by the 6 sense
of the programmer :).
so it pure compile and logical of programming, which is not good advise
I don't understand, or understand very little about acpi and kernels.
but ... I give my best.
I applied to kernel-2.4.18
	patch-2.4.19-rc3.bz2
	acpi-20020709-2.4.18.diff.gz, this one (of course) have to be merged
	CONFIG_ACPI_SLEEP.patch
	nocorruption.2.acpi.diff.txt

of this result I will call, with your permission, patch
acpi20020709-2.4.19.rc3 this pacth can be applied also in 2.4.19rc2.

This are the two rejected files are the ones that concerned me more=20
linux-2.4.19/arch/i386/kernel/setup.c.rej
linux-2.4.19/arch/i386/kernel/pci-pc.c.rej

I just tested in My laptop, one compaq pressario 706ea,
the kacpid.patch is not apllied in patch above, but if you want you can
apply it.   =20
on=20
http://codecs.home.sapo.pt/acpi

S=E9rgioBasto=20




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
