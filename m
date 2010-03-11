From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [Bug 15346] pci card in thinkpad dock is not detected.
Date: Thu, 11 Mar 2010 12:47:37 -0700
Message-ID: <201003111247.39161.bjorn.helgaas@hp.com>
References: <117843.66339.qm@web111810.mail.gq1.yahoo.com> <201003021253.21066.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201003021253.21066.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Lara Michaels <laramichaels1978@yahoo.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org
List-Id: linux-acpi@vger.kernel.org

[Updating this thread with the bugzilla pointer and my current theory]

http://bugzilla.kernel.org/show_bug.cgi?id=15436

I first thought this was an ACPI or dock problem, but I now think
this is a PCI issue after all, since the machine was booted in the
dock and no dock/undock events are involved.

>From this lspci output:

  00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
	Bus: primary=00, secondary=02, subordinate=13, sec-latency=64
	I/O behind bridge: 00004000-00009fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff

  02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge (prog-if 01)
	Bus: primary=02, secondary=0b, subordinate=13, sec-latency=68
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: 84000000-8bffffff
	Prefetchable memory behind bridge: 8c000000-93ffffff

  0b:02.0 CardBus bridge: Texas Instruments PCI1420 PC card Cardbus Controller
	Bus: primary=0b, secondary=0c, subordinate=0f, sec-latency=176

  0b:02.1 CardBus bridge: Texas Instruments PCI1420 PC card Cardbus Controller
	Bus: primary=0b, secondary=10, subordinate=13, sec-latency=176

It looks like the dock PCI slot should appear as 0b:00 (as it does in the
report at http://lkml.indiana.edu/hypermail/linux/kernel/0607.0/1409.html).
We do see the CardBus bridges in the dock.  The fact that we don't see the
video card, which should be on the same bus, makes me suspect that the
dock's PCI slot is bad.
