From: Len Brown <len.brown@intel.com>
Subject: Re: Freeing ACPI tables after parsing
Date: Mon, 21 Aug 2006 17:52:16 -0400
Message-ID: <200608211752.16616.len.brown@intel.com>
References: <200608211146.53379.ak@suse.de>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:24519 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751217AbWHUVu3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 17:50:29 -0400
In-Reply-To: <200608211146.53379.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org, Natalie.Protasevich@unisys.com

On Monday 21 August 2006 05:46, Andi Kleen wrote:
> [repost, this time with correct cc list]
> 
> AFAIK ACPI saves all information found in ACPI tables in memory
> somewhere else (please correct me if I'm wrong on that)
> 
> I also found this comment in e820.h:
> 
> #define E820_ACPI       3 /* usable as RAM once ACPI tables have been read */
> 
> Currently I don't see any code that would free the ACPI tables after they
> are read. 

This is true.

> During SLES10 testing we had some problems with the ACPI 
> tables on some Unisys systems being in a area where the kexec kernel
> wanted to be loaded too. 

Why does the kexec kernel care what physical memory it is loaded into,
and how can it be guaranteed that address is not reserved by the platform firmware?

> Also on other systems the ACPI tables are not 
> exactly at the end but in the middle of the memory map and for some applications
> it might be better to have a lot of physical continuous memory.
> 
> So are there any plans to free the BIOS supplied ACPI tables after parsing
> or is there some obstacle to that that I'm missing?

As Alexey wrote, he and Bob have already deleted the kernel's new copy
of the tables in favor of using them 'in place'.

I guess I'm not clear on the requirement here.
If we were to alter that plan to make a kernel copy -- and release the original BIOS memory --
assuming it is marked such that we can release it -- how do we know that
we are not dropping the new copy someplace that kexec doesn't want it?

-Len
