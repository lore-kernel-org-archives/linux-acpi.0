From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Subject: [PATCH] can we compile ACPI without define CONFIG_PM ?
Date: Thu, 29 Apr 2004 23:54:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1083279256.3410.30.camel@darkstar>
Reply-To: sergiomb@netcabo.pt
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dLzTM9Lm4cHmA24HrIeB"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265023AbUD2W52@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, acpi-devel <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org


--=-dLzTM9Lm4cHmA24HrIeB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Kernel mailing list!

IIRC: if I recall correctly=20
we couldn't compile ACPI without Power management option (CONFIG_PM),
but now, this is possible.

If the answer to the subject is no, then consider apply this patch on
kernel 2.4.26.

Accidentally, I compile ACPI without CONFIG_PM on one Dell something
dual Pentium III and power off didn't work.

So I need some confirmation from acpi-devel, but this is one meter of
xconfig of the kernel so ...

For APM Xconfiguration, it's better that, we can choose APM options only
if we select APM ( because if we don't select CONFIG_PM, CONFIG_APM will
be disable and the APM options don't!).
This patch correct also this situation.

Thanks,
--=20
S=E9rgio M. B.

--=-dLzTM9Lm4cHmA24HrIeB
Content-Disposition: attachment; filename=configopti.diff
Content-Type: text/x-patch; name=configopti.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.26s/arch/i386/config.in.orig	2004-04-29 23:38:38.000000000 +0100
+++ linux-2.4.26s/arch/i386/config.in	2004-04-29 23:40:58.000000000 +0100
@@ -360,7 +360,7 @@
 bool 'Power Management support' CONFIG_PM
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
+if [ "$CONFIG_APM" != "n" -a "$CONFIG_PM" = "y" ]; then
    bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
    bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
    bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
@@ -370,7 +370,9 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
-source drivers/acpi/Config.in
+if [ "$CONFIG_PM" = "y" ]; then
+	source drivers/acpi/Config.in
+fi
 
 endmenu
 

--=-dLzTM9Lm4cHmA24HrIeB--
