From: Vladislav Yasevich <vladislav.yasevich-VXdhtT5mjnY@public.gmane.org>
Subject: Re: HOWTO dump a DSDT
Date: Wed, 18 Feb 2004 09:58:33 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40337D99.9030704@hp.com>
References: <4033622E.8070902@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4033622E.8070902-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I've been able to successfully use:
	# cat /proc/acpi/dsdt > my_dsdt
	# iasl -d my_dsdt

acpidump has some usefull features, but if simply what
the raw dsdt, 'cat' works just as well.

-vlad

Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> as I have to modify my ASUS M6800N DSDT in order to have support for
> battery and other things, I started to work with 'iasl-20030918' from
> Intel site.
> 
> On the other hand:
> 
> - - on the DSDT-HOWTO linked from ACPI site
> 	http://www.cpqlinux.com/acpi-howto.html
> it is suggested to use 'acpidump' (which doesn't compile on my box).
> 
> - - on the ACPI site's first page there's a link to 'acpidmp', which can
> grab DSDT, and the DSDT dumped with 'acpidmp' is the same as the DSDT
> copied via 'cat /proc/acpi/dsdt'
> 
> My question: which tool should I use to dump my DSDT? And then to
> disassemble it?
> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFAM2ItVAp7Xm10JmkRAr5DAJ92xtUL9tE1dY7wOJhI/2J2yAYPAACfVulR
> 2uxB5Da31dWqj721S+7vFxM=
> =03jQ
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

-- 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Vladislav Yasevich		Linux and Open Source Lab
Hewlett Packard 		Tel: (603) 884-1079
Nashua, NH 03062		ZKO3-3/T07


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
