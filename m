From: Len Brown <len.brown@intel.com>
Subject: Re: Kernel 2.6.13 repeated ACPI events?
Date: Thu, 08 Sep 2005 02:39:18 -0400
Message-ID: <1126161558.21723.9.camel@toshiba>
References: <20050905130643.GA30428@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932180AbVIHGhj@vger.kernel.org>
In-Reply-To: <20050905130643.GA30428@roarinelk.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: acpi-devel@lists.sourceforge.net, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-09-05 at 09:06 -0400, Manuel Lauss wrote:
> On Mon, Sep 05, 2005 at 08:54:59AM -0400, Justin Piszcz wrote:
> > I have a box where I keep getting this in dmesg:
> >
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5

> 
> > 01:00.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> [Cyclone]

This is from the driver repeatedly calling pci_enable_device().
Can you instrument the driver to find out why?

cheers,
-Len
