From: Thomas Renninger <trenn@suse.de>
Subject: Re: how CPU hot-plug is suppose to work on Linux?
Date: Fri, 8 Oct 2010 14:28:18 +0200
Message-ID: <201010081428.18846.trenn@suse.de>
References: <20100921134109.GC11145@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49761 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878Ab0JHM2U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 08:28:20 -0400
In-Reply-To: <20100921134109.GC11145@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gleb Natapov <gleb@redhat.com>
Cc: linux-acpi@vger.kernel.org, kvm@vger.kernel.org

On Tuesday 21 September 2010 15:41:09 Gleb Natapov wrote:
> Hello,
> 
> We are trying to add CPU hot-plug/unplug capability to KVM. We want to
> be able to initiate hot-plug/unplug from a host. Our current schema
> works like this:
> 
> We have Processor object in DSDT for each potentially available CPU.
> Each Processor object has _MAD, _STA, _EJ0. _MAD of present CPU
> returns enabled LAPIC structure. _STA of present CPU return 0xf. _MADT
> of non present CPU returns disabled LAPIC. _STA returns 0x0. _EJ0 does
> nothing.
> 
> When CPU is hot plugged:
> 
>  1. Bit is set in sts register of gpe
>  2. acpi interrupt is sent
>  3. Linux ACPI evaluates corespondent gpe's _L() method
>  4. _L() method determines which CPU's status is changed
>  5. For each CPU that changed status from not present to present
>     call Notify(1) to corespondent Processor() object.
> 
> When CPU is hot unplugged:
> 
>  1. Bit is set in sts register of gpe
>  2. acpi interrupt is sent
>  3. Linux ACPI evaluates corespondent gpe's _L() method
>  4. _L() method determines which CPU's status is changed
>  5. For each CPU that changed status from present to non present
>     call Notify(3)
That does not work.

>     to corespondent Processor() object.
> 
> Now, CPU hot plug appears to be working. But CPU hot unplug does
> nothing. I expect that Linux will offline CPU and eject it after
> evaluating Notify(3) and seeing that _STA of ejected CPU returns
> 0x0 now.
> 
> Any ideas how it is suppose to work?
Put a container device, e.g. ACPI0004 above the CPU objects.
and call notify (on remove and add) on it instead of the CPU
object itself with e.g.:
#define ACPI_NOTIFY_BUS_CHECK           (u8) 0x00
#define ACPI_NOTIFY_DEVICE_CHECK        (u8) 0x01

acpi core should go through the devices and call add()/probe()
on devices which appear and remove() on devices which _STA
method does not return active anymore.

    Thomas
