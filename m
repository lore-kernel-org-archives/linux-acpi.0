From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Fri, 30 Jun 2006 10:03:57 -0600
Message-ID: <200606301003.58107.bjorn.helgaas@hp.com>
References: <8BF50482CE9EE245902340E0724784D59B95F2@pdsmsx411.ccr.corp.intel.com> <20060630090451.89100@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:54930 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932523AbWF3QED (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 12:04:03 -0400
In-Reply-To: <20060630090451.89100@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, castet.matthieu@free.fr, ambx1@neo.rr.com, akpm@osdl.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Friday 30 June 2006 03:04, Uwe Bugla wrote:
> First of all, what is a root bridge please? I know what a PCI-ISA
> bridge is, but I stumbled across the expression "root bridge."

A PCI root bridge is a device that sits between the processor and
a PCI bus.  On the upstream side (closer to the processor), it has
some platform-specific interface.  The downstream side is a standard
PCI bus.

Most PNP devices have some registers that control them.  For example,
a UART has a receive buffer, a transmit buffer, an interrupt enable
register, etc.  These appear at specific I/O port or MMIO addresses.
Those addresses are the resources consumed by the UART.  If you access
those resources, the UART responds by doing something.

Bridges are different.  They also consume I/O port and/or MMIO address
space.  But some of that address space is passed through to the other
side of the bridge, to the devices on the downstream bus.  In ACPI,
the resources that are passed to the downstream side are "consumed"
by the bridge and also "produced" on the downstream side.

The UART has no downstream side.  It "consumes" resources but
doesn't produce any.  (It does produce RS-232 signals on the
other side, but that's a completely different protocol and outside
the scope of ACPI.)

> As a consequence I do not understand in how far this "root bridge"
> should be blacklisted.  As far as I have received the issue the
> decision of blacklisting or rejecting ACPI_PRODUCER is a EITHER-OR
> one, but NOT a ALSO-THIS and ALSO-THAT one.

My opinion is that we must change PNPACPI to either understand or
ignore the producer resources.  Matthieu posted a patch to ignore
them.  If we don't do this, we will have the maintenance burden of
updating a blacklist whenever anybody invents a new device with
producer resources.

We could blacklist PNP0A03 in addition to changing PNPACPI.  For the
specific bug you tripped over, there's no reason to do both, but I
think Shaohua is worried about other problems.  For example, if the
BIOS reported that the PNP0A03 device consumed I/O port 0x3f8, which
is really consumed by the COM1 UART, that conflict might prevent the
serial driver from using the UART.

Or, somebody could make a PNP driver that claimed PNP0A03 PCI root
bridges, which would conflict with the existing ACPI driver that
claims PNP0A03 devices.  Blacklisting PNP0A03 in PNPACPI would prevent
a PNP driver from claiming it.

Bjorn
