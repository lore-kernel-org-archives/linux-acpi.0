From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 27 Jul 2004 20:24:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F036BCD7C@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-BSDwwRMYa8dh2yIolo3vgti2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
does a patch like below help your system? Please manually add it and
try.=20

Thanks,
Shaohua

static int i8259A_resume(struct sys_device *dev)
 {
+	unsigned long flags;
 	init_8259A(0);
+=20
+	spin_lock_irqsave(&i8259A_lock, flags);
	restore_ELCR(irq_trigger);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
	return 0;
}

>-----Original Message-----
>From: Georg C. F. Greve [mailto:greve-1r/uNngapc3YtjvyW6yDsg@public.gmane.org] On Behalf Of Georg C.
F.
>Greve
>Sent: Tuesday, July 27, 2004 7:14 PM
>To: Matthew Garrett
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Li, Shaohua
>Subject: Re: [ACPI] acpi-20040715: functional regression on ASUS M2N
>
>Hi all,
>
>okay, I did some more checks on the problems I experienced with
>acpi-20040715 on Intel Centrino 855GM notebook ASUS M2N.
>
>Background: As of kernel 2.6.7 suspend to RAM (s3_bios) actually
>worked and even with DRI/DRM and AGP compiled in and the X server
>running, things are working nicely.
>
>When restarting from suspend to RAM, I briefly see a yellow "inu" in
>the uppermost row for a second, then the screen flickers once and X11
>is back.
>
>Only disadvantage: network cards (both wired & ipw2100 wireless) are
>dead after suspend to ram, I need a suspend to disk (swsusp2 version
>2.0.0.100) to bring them back to life. (referred to as "fine" below)
>
>When upgrading to acpi-20040715 I discovered that resume from suspend
>to RAM was broken. Contrary to what I wrote in my previous mail, it
>seems that there is the yellow "inu" in the uppermost row and then the
>machine is dead. (referred to as "dead" below)
>
>I need a forced poweroff plus "needle-pushed reset button" to bring it
>back to life.
>
>
>Having had some time to let the machine compile in the background, I
>narrowed down the code that broke the resume from suspend to RAM on my
>machine. Apparently it was the patch that is supposed to fix the
>network card problems.
>
>When starting from a patched 2.6.7 with suspend to ram and resume
>working fine as described above (=3Dbase), I have applied two patches
>
> (a) acpi-20040715
>
> (b) Fix ACPI after S3 patch of David Shaohua:


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
