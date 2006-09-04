From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Problem with resuming ATI SATA on HPC nx6325
Date: Mon, 4 Sep 2006 13:32:19 +0200
Message-ID: <200609041332.19780.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49132 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964804AbWIDL3M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Sep 2006 07:29:12 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

I've just installed SUSE 10.1 on a HPC 6325 notebook (x86_64, dual_core) with
an ATI chipset.  It generally works just fine (well, except for some minor
glitches), but I'm having problems with suspending it which seem to be ACPI
related.

Namely, on the 2.6.18-rc5-mm1 kernel the hard drive is not accessible after
a resume of device drivers (eg. in the resume-during-suspend phase of swsusp).
On 2.6.18-rc5 swsusp works with the following drivers loaded:

cpufreq_ondemand
powernow_k8
freq_table
af_packet
ip6t_REJECT
xt_tcpudp
ipt_REJECT
xt_state
iptable_filter
ip_conntrack
nfnetlink
ip_tables
ip6table_filter
ip6_tables
x_tables
ipv6
ext3
jbd
fan
thermal
processor
sg
atiixp
sata_sil
libata
ide_disk
ide_core

but if ohci_hcd and ehci_hcd are loaded additionally, the SATA thing doesn't
resume properly (if only one of ehci_hcd or ohci_hcd is loaded, it works).

The SATA controller is:
00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (rev 80)

If you need any additional information, please let me know.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: U 0.5
