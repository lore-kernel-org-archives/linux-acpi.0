From: rui wang <ruiv.wang@gmail.com>
Subject: Re: [PATCH v4 27/28] PCI, x86, ACPI: Enable ioapic hotplug support
 with acpi host bridge.
Date: Wed, 28 Aug 2013 09:10:38 +0800
Message-ID: <CANVTcTZQKnS-R7ezxFF+rBRuXzx6chVopqDHno9dMmJKfuLRXQ@mail.gmail.com>
References: <1376189294-32022-1-git-send-email-yinghai@kernel.org>
	<1376189294-32022-28-git-send-email-yinghai@kernel.org>
	<CANVTcTZOQWLHOs5+DpopTDMpMf2dgAzjUGEv4gGd4Z2Le5TM7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CANVTcTZOQWLHOs5+DpopTDMpMf2dgAzjUGEv4gGd4Z2Le5TM7A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

FWIW, I'm using my "I/O Hook" (http://lwn.net/Articles/561359/) as a
tool to test yinghai's IOAPIC patchset. It can be used to test any
kind of hotplug.

For people who don't yet have full hardware support and want to test
the hotplug of IOAPIC, CPU, Memory, IOH, PCIe root, etc., it is an
ideal tool. The latest version (v2) is at:
http://lwn.net/Articles/561779/


Thanks
Rui
