From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Problem with ACPI on an AMD Athlon 64 X2 motherboard - freeze on boot
Date: Fri, 17 Mar 2006 11:29:02 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B37ADC6@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39564 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964925AbWCQD34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Mar 2006 22:29:56 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin Verduijn <verdujin.acpi@gmail.com>, linux-acpi@vger.kernel.org

 Hi,

Please file a bug on bugzilla.kernel.org.
Otherwise, it is hard to track.

Thanks,
Luming=20

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org=20
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Robin Verduijn
>Sent: 2006=C4=EA3=D4=C217=C8=D5 8:58
>To: linux-acpi@vger.kernel.org
>Subject: Problem with ACPI on an AMD Athlon 64 X2 motherboard=20
>- freeze on boot
>
>Hi,
>
>I have recently bought an Alienware Aurora m7700 notebook, which comes
>with an AMD Athlon 64 X2 4400+ dual core processor (wow, that's a
>mouth full). Since it came set up with a RAID-0 VIA adapter I need
>dmraid in order to recognize my drives, which means that I cannot boot
>directly into Linux. Thus, I am forced to use Loadlin and a
>vmlinuz/initrd combination which initializes dmraid and boots up the
>rest of the system. I am only mentioning all this in case the fact
>that I am booting from Loadlin has anything to do with my problem.
>
>My problem is that, with an SMP kernel, I am unable to get both
>processors recognized. I currently suspect that the reason for this is
>that the system freezes very early on in the boot cycle if ACPI is
>turned on. When I specify "acpi=3Doff" the system boots successfully b=
ut
>it fails to detect the motherboard as multi-processor and only
>initializes the first processor.
>
>When I boot from a Knoppix 4.0.2 cd, ACPI is turned on successfully
>and IO-APIC/Local APIC is turned on so that both of my processors get
>recognized. In fact, if I try to boot Knoppix with "acpi=3Doff" it
>freezes immediately on startup. This puzzles me somewhat since I have
>tried using the very same kernel from the Knoppix cd to boot from my
>harddisk and got the same problem there.
>
>The reason I am asking for help on this list is that I am now
>labouring under the assumption that the problem with recognizing my
>processors is due to the fact that ACPI cannot be turned on (at least,
>not when booting from my hard drive), which I think must be because my
>BIOS has a faulty ACPI namespace. I read up on
>http://acpi.sourceforge.net/dsdt and obtained the DSDT for my system,
>which turns out to have quite a lot of compilation errors. Some of
>these I could correct but almost two dozen remain, and I was wondering
>if someone on this list could nudge me along in the right
>direction[1].
>
>Kernel: 2.6.15.6 from kernel.org
>Running Debian Sarge with a bare minimum of packages installed.
>
>Attached:
>	AuroraAMD64.dsl		The DSDT file I am trying to=20
>get compiled
>	AuroraAMD64.diff	The changes I was able to make=20
>to it so far
>	config-2.6.15.6		The changes I was able to make=20
>to it so far
>	cpuinfo.txt.knoppix	The output of /proc/cpuinfo=20
>when booted using Knoppix
>	dmesg.knoppix		The output of 'dmesg' when run=20
>under Knoppix
>	dmesg.txt		The output of 'dmesg' when I=20
>have to boot with acpi=3Doff
>	dmidecode.txt		The output of 'dmidecode'
>	dmidecode.knoppix.txt	The output of 'dmidecode' under Knoppix
>	lspci.txt		The output of 'lspci -v -v'
>	stdout-stderr.iasl.log	The iasl compiler errors when trying to
>compile AuroraAMD64.dsl
>
>If there is any other information I could give that might help with
>this, please let me know. I am really eager to get this 100% working
>under Linux...
>
>Thanks in advance,
>- robin
>
>[1] Of course, if trying to make the DSDT compile correctly is just a
>red herring, I would still appreciate any suggestions as to what the
>real root cause is :-)
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
