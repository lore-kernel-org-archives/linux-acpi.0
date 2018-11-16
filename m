From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Fri, 16 Nov 2018 12:37:00 +0000
Message-ID: <ab363e80d45e4c3d91770c1b1010d1ce@AcuMS.aculab.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Alexandru Gagniuc' <mr.nuke.me@gmail.com>
Cc: "austin_bolen@dell.com" <austin_bolen@dell.com>, "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>, "keith.busch@intel.com" <keith.busch@intel.com>, "Shyam_Iyer@Dell.com" <Shyam_Iyer@Dell.com>, "lukas@wunner.de" <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-acpi@vger.kernel.org

From: Alexandru Gagniuc
> Sent: 15 November 2018 23:16
...
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER.

This is all very well, but we have systems (they might be Dell ones)
where failure of a PCIe link (even when all the drivers are removed)
causes an NMI - and crashes the kernel.

There are other systems which have AER registers available for
some of the PCIe devices, but the BIOS ignores them and _OSC
doesn't let the kernel take control.
In this case the AER registers can contain useful information
after a read returns ~0u.
It would be useful to be able to get this information without
having to grovel through all the PCIe config space.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
