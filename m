From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
Date: Mon, 11 Oct 2004 02:44:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58L.0410110132170.4217@blysk.ds.pg.gda.pl>
References: <1097429707.30734.21.camel@d845pe>  <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
  <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl> <1097443183.26647.31.camel@darkstar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268594AbUJKBpH@vger.kernel.org>
In-Reply-To: <1097443183.26647.31.camel@darkstar>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Sun, 10 Oct 2004, [ISO-8859-1] S=E9rgio Monteiro Basto wrote:

> The problem is: trying enable some local apic's (for example on via
> mother boards on my laptop), cause many problem, like hang on boot (w=
ith
> ACPI), hang on Fn-F3 (video switch), power-off fails, etc. and no one
> knows how resolved the problem. =20

 Ah, laptops seem to be inherently insane...  Your symptoms suggest you=
r=20
firmware/BIOS is buggy, doing probably something under the OS, which=20
cannot be controlled and without taking proper care of the state of=20
hardware.  That's the infamous SMM code.

 How about only disabling the APIC if power-management is in use?  And=20
announcing it so that a user sees the APIC has been kept deliberately=20
disabled, as opposed to be unable to be enabled?  Like below -- for ACP=
I=20
only, as I assume APM gives no trouble or the change would have been=20
proposed much earlier.  Untested.

> So keep it disable if BIOS vendors say so, can be reasonable idea.

 BIOS vendors usually say so, because they have no clue, or in other=20
words, they do not really mean to say anything with this.  They just do=
n't=20
enable the APIC as they see no use for it, but the same can be true of=20
plenty of other hardware that has no use for the firmware.

 I don't like the idea of "punishing" good hardware, because something=20
behaves ill out there.

  Maciej

patch-mips-2.6.9-rc2-20040920-lapic-0
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arc=
h/i386/kernel/acpi/boot.c linux-mips-2.6.9-rc2-20040920/arch/i386/kerne=
l/acpi/boot.c
--- linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/acpi/boot.c	20=
04-08-25 03:57:43.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/acpi/boot.c	2004-10-=
11 01:42:34.000000000 +0000
@@ -835,6 +835,19 @@ acpi_boot_init (void)
 	}
=20
 	/*
+	 * Don't override BIOS and enable the local APIC
+	 * unless "lapic" specified.
+	 */
+	if (!acpi_disabled && enable_local_apic =3D=3D 0) {
+		printk(KERN_NOTICE PREFIX
+		       "Local APIC won't be reenabled, "
+		       "because of frequent BIOS bugs\n");
+		printk(KERN_NOTICE PREFIX
+		       "You can enable it with \"lapic\"\n");
+		enable_local_apic =3D -1;
+	}
+
+	/*
 	 * set sci_int and PM timer address
 	 */
 	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arc=
h/i386/kernel/apic.c linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/api=
c.c
--- linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/apic.c	2004-09=
-20 03:57:43.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/apic.c	2004-10-11 01=
:37:13.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
=20
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by DMI scan, ACPI or kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
=20
