From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: enabled and failed flags in acpi_memory_info
Date: Wed, 16 Jan 2013 10:09:35 -0700
Message-ID: <1358356175.14145.163.camel@misato.fc.hp.com>
References: <1357693472.14145.42.camel@misato.fc.hp.com>
	 <1358197617.14145.92.camel@misato.fc.hp.com>
	 <50F6BA29.9020201@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:48711 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab3APRTZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jan 2013 12:19:25 -0500
In-Reply-To: <50F6BA29.9020201@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org

On Wed, 2013-01-16 at 22:33 +0800, Wen Congyang wrote:
> Sorry for late reply.
> 
> At 01/15/2013 05:06 AM, Toshi Kani Wrote:
> > Wen, Yasuaki, any thoughts on this?
> > 
> > Thanks,
> > -Toshi
> > 
> > 
> > On Tue, 2013-01-08 at 18:04 -0700, Toshi Kani wrote:
> >> Hi Wen,
> >>
> >> I have a question about the change you made in commit 65479472 in
> >> acpi_memhotplug.c.  This change seems to require that
> >> acpi_memory_enable_device() calls add_memory() to add all memory ranges
> >> represented by memory device objects at boot-time, and keep the results
> >> be used for hot-remove.  
> >>
> >> If I understand it right, this add_memory() call fails with EEXIST at
> >> boot-time since all memory ranges should have been added from EFI memory
> >> table (or e820) already.  This results all memory ranges be marked as !
> >> enabled & !failed.  I think this means that we cannot hot-delete any
> >> memory ranges presented at boot-time since acpi_memory_remove_memory()
> >> only calls remove_memory() when the enabled flag is set.  Is that
> >> correct?  If so, why do we need such restriction?t 
> 
> Hmm, it means that this memory range is not managed by this driver. I am
> not sure it is safe to remove it, so I restrict it...

Well, let me clarify what I think the role model should be as follows. 
 - The ACPI memory driver enumerates memory device information and
maintains the "HW" information.
 - The mm module manages the "OS use" of enumerated memory ranges. 
 
Therefore, the ACPI memory driver should not attempt to manage how
memory ranges are being used by the OS.  It is solely the mm module's
responsibility.  Hence, it does not matter if the memory ranges managed
by the mm module are initially enumerated from EFI (or e820) as long as
the ACPI memory driver maintains the "current" HW info.

> If it is safe to remove such memory, you can remove this restriction.

It should be safe with the role model above.  The ACPI memory driver
receives a hot-plug request and updates its HW information.  Then, the
mm module decides if a given memory range can be added or deleted based
on the memory usages.

If you see any issues in this model, please let me know.
Thanks,
-Toshi


> Thanks
> Wen Congyang
> >>
> >> In addition, as part of RFC patchset of proposed hotplug framework below
> >> (well, this is why I am wondering this... :), I simply called
> >> add_memory() and remove_memory() for the ranges requested for hot-add /
> >> hot-delete.  It does not call add_memory() at boot-time and set the
> >> enabled & failed flags.  But it does not eject memory when
> >> remove_memory() failed, either.  Do you see any problems with this
> >> approach? 
> >> https://lkml.org/lkml/2012/12/12/457
> >>
> >> Thanks,
> >> -Toshi
> > 
> > 
> > 
> 


