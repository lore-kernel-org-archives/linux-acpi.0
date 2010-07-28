From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PCI / PCIe: Ask BIOS for control of all native services simultaneously
Date: Wed, 28 Jul 2010 12:49:56 +0200
Message-ID: <201007281249.56722.rjw@sisk.pl>
References: <201007250105.23610.rjw@sisk.pl> <4C4FA663.9090204@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38631 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab0G1Kvo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 06:51:44 -0400
In-Reply-To: <4C4FA663.9090204@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wednesday, July 28, 2010, Hidetoshi Seto wrote:
> Hi,
> 
> (2010/07/25 8:05), Rafael J. Wysocki wrote:
> > It turns out that asking ACPI BIOS, through _OSC, for control of each
> > PCIe port native service individually sometimes confuses the BIOS if
> > one sevice is requested while the others are not (eg. requesting
> > control of the native PCIe PME without requesting control of the
> > native PCIe hot-plug at the same time leads to interrupt storms on
> > some systems).
> 
> Then why not invent quirks or something for such systems?
> 
> IMHO it sounds like a BIOS bug since it should grant PME control to
> OS only when both of PME and pciehp (plus PCIe caps) are requested
> at same time.
> 
> Did you confirm that the system also confuses when pciehp is requested
> without requesting PME?
> e.g. assume that some BIOS might behave:
>   _OSC(pciehp)         =>  OK
>   _OSC(PME)            =>  NG (bugs on shared interrupt?)
>   _OSC(pciehp|PME)     =>  OK
>   _OSC(SHPC)           =>  OK
>   _OSC(pciehp|SHPC)    =>  NG (must choose one, not both)
>   _OSC(AER|SHPC)       =>  OK

The problem is the PCIe capability structure that is requested by each of
them (except for SHPC).  After granting it, the BIOS can't legitimately write
to the PCIe standard config registers, so it's reasonable to assume the kernel
will configure them from its perspective.

> I don't doubt that handling of _OSC needs some improvement...

Good. :-)

Rafael
