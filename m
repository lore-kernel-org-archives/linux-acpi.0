From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= <philippe.gramoulle-2kpEERWQSfTQT0dZR+AlfA@public.gmane.org>
Subject: Can't poweroff Dell Dimension 4100 with latest 2.4 bk but 2.6 is ok
Date: Wed, 31 Mar 2004 15:35:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331153559.10b51985@philou.gramoulle.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


 Hello,

 I have a somewhat old Dell Dimension 4100 XPS-Z PC, with A11 BIOS which i can't poweroff with any recent 2.4 kernels i tried
while i can power it off nicely with either 2.6.4 or 2.6.5-rc2 for example.

I tried the latest 2.4 BK + latest ACPI BK ( bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26 )
and this is still a no go.

I can't use APM either as i have a message that the BIOS is blacklisted
(dmi_scan.c:    { apm_is_horked, "Dell XPS-Z", { /* APM crashes */))

I've been upgrading this from since around 2.4.20 and IIRC, there was at least one kernel during the course
that worked, but i'm not 100% sure.

Any pointer welcome.

Thanks,

Philippe


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
