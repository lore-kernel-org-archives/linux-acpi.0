From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Date: Sun, 25 Jan 2004 00:40:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040125003935.EB71.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Uniwill N258SA0 (http://www.uniwill.com/Product/N258SA0/N258SA0.html)
aka Hypersonic Aviator NX6, Fujitsu-Siemens AMILO D 1840 Widescreen, etc.).
SiS 648FX chipset, SiS 900 Ethercard, AMI BIOS, ATI  AV350/M10 128Mb.
My machine: Hyperthreaded P4 2.8GHz, .5Gb PC3200 RAM.

Installed Fedora. Upgraded to 2.6.2-rc1 per
http://thomer.com/linux/migrate-to-2.6.html.

Applied kernel patches:
- SiS AGP (http://lkml.org/lkml/2004/1/20/233)
  (needed to run ATI's 3.7 fglrx drivers on the SiS/M10 combo)
- ACPI 20031203 (http://acpi.sourceforge.net/)

All good, but ACPI sleep doesn't work and neither does userland IRQ
balancing with Arjan's irqbalance (http://people.redhat.com/arjanv/irqbalan=
ce/),
a standard part of the Fedora install.

irqbalance just locks up the machine totally, hard power-off needed, no
traces in the logs. Probably some issue (race?) with it writing to
/proc/irq/X/smp_affinity. And how is irqbalance supposed to play with
kirqd anyway? Grepping this list and others doesn't give any kind of an
answer. But disabling it gives all interrupts to cpu0 (looking at
/proc/interrupts). kirqd apparently only balances between CPU packages,
not between HT siblings (info gleaned from this list).

Anyway, sleep/suspend/standby functionality (important to most laptop
users, need to close the lid and go): This checkin to
kernel/power/main.c seems to disable suspend with SMP (!?):

--- 1.3/kernel/power/main.c	Sat Jan 24 20:44:47 2004
+++ 1.4/kernel/power/main.c	Sat Jan 24 20:44:47 2004
@@ -172,6 +172,12 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
=20
+	/* Suspend is hard to get right on SMP. */
+	if (num_online_cpus() !=3D 1) {
+		error =3D -EPERM;
+		goto Unlock;
+	}
+
 	if ((error =3D suspend_prepare(state)))
 		goto Unlock;

=2E.. which, given the prevalence of hyperthreaded CPUs on laptops, is
fighting a trend. I backed out the above with a #if 0 then tried echo -n
1>/proc/acpi/sleep again. This time I got:

Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, kirqd not stopped
 done

kirqd just wouldn't stop.

Tried booting with acpi=3Doff and apm=3Dsmp to force APM, then ran
apm --suspend, but it put the machine into a LCD blanked state it
couldn't get out of without another hard power cycle.

Questions: Why does irqbalance lock up the machine and how is it
supposed to collaborate with kirqd? How is ACPI suspend supposed to work
on any recent laptop if SMP is barred? Why doesn't kirqd stop when asked
to by ACPI suspend once that restriction is bypassed?

A lot of effort is going into swsusp/pmdisk - but a lot of laptop users
prefer S1 to S4, as it's faster and more reliable. It'd be nice to see a
simpler "spin down the hard drive, reduce CPU clock speed to a minimum,
and power down display/ether/wireless/usb/PCMCIA" working ahead of
hibernation.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
