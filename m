From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: 2.6.9 S4: clock not updated after resume
Date: Fri, 22 Oct 2004 10:10:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4178C072.1020905@pca.it>
References: <4177A9DC.7060503@pca.it> <20041021202051.GA21624@elf.ucw.cz>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030905000608060403020109"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041021202051.GA21624-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905000608060403020109
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Pavel,

on 10/21/04 22:20, Pavel Machek wrote:
> It is a bug, here's the fix.
actually, your fix doesn't work, as you can see from the attached
syslog: I still need to synchronise the clock via NTP.

BTW, I'm sure I applied your patch and the kernel is the right one:
=====
luca@gismo:~$ ls -l /lib/modules/2.6.9/
total 200
drwxr-xr-x  2 root root  4096 Oct 22 09:03 bcm
lrwxr-xr-x  1 root root    34 Oct 22 09:03 build ->
/usr/src/linux-2.6.9-battery-clock
drwxr-xr-x  9 root root  4096 Oct 21 02:03 kernel
- -rw-r--r--  1 root root 37325 Oct 22 09:03 modules.alias
- -rw-r--r--  1 root root    69 Oct 22 09:03 modules.ccwmap
- -rw-r--r--  1 root root 18819 Oct 22 09:03 modules.dep
- -rw-r--r--  1 root root   443 Oct 22 09:03 modules.ieee1394map
- -rw-r--r--  1 root root   700 Oct 22 09:03 modules.inputmap
- -rw-r--r--  1 root root   235 Oct 22 09:03 modules.isapnpmap
- -rw-r--r--  1 root root 43506 Oct 22 09:03 modules.pcimap
- -rw-r--r--  1 root root 37599 Oct 22 09:03 modules.symbols
- -rw-r--r--  1 root root 26434 Oct 22 09:03 modules.usbmap
lrwxr-xr-x  1 root root    34 Oct 22 09:03 source ->
/usr/src/linux-2.6.9-battery-clock
drwxr-xr-x  3 root root  4096 Oct 21 02:03 updates

luca@gismo:~$ cd /usr/src
luca@gismo:/usr/src$ diff linux-2.6.9-battery/arch/i386/kernel/time.c
linux-2.6.9-battery-clock/arch/i386/kernel/time.c
- --- linux-2.6.9-battery/arch/i386/kernel/time.c 2004-10-18 23:54:08 +0200
+++ linux-2.6.9-battery-clock/arch/i386/kernel/time.c   2004-10-22
00:33:44 +0200
@@ -319,7 +319,7 @@
        return retval;
 }

- -static long clock_cmos_diff;
+static long clock_cmos_diff, sleep_start;

 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,6 +328,7 @@
         */
        clock_cmos_diff = -get_cmos_time();
        clock_cmos_diff += get_seconds();
+       sleep_start = get_cmos_time();
        return 0;
 }

@@ -335,10 +336,13 @@
 {
        unsigned long flags;
        unsigned long sec = get_cmos_time() + clock_cmos_diff;
+       unsigned long sleep_length = get_cmos_time() - sleep_start;
+
        write_seqlock_irqsave(&xtime_lock, flags);
        xtime.tv_sec = sec;
        xtime.tv_nsec = 0;
        write_sequnlock_irqrestore(&xtime_lock, flags);
+       jiffies += sleep_length * HZ;
        return 0;
 }

luca@gismo:/usr/src$
=====

I'm here for other tests :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBeMBwVAp7Xm10JmkRAipNAKCCUt5346gWnXg7Y8UDP1BvQ5c2cACaAvMV
ywsbUI6EmXZ9qe0Jz8z9y3M=
=rSh4
-----END PGP SIGNATURE-----

--------------030905000608060403020109
Content-Type: application/x-gzip;
 name="syslog_20041022.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="syslog_20041022.gz"

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
9SBEO5bljljn/wB27NQ1HCMBAA==
--------------030905000608060403020109--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
