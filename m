From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Freeing ACPI tables after parsing
Date: Mon, 21 Aug 2006 20:59:57 +0400
Message-ID: <44E9E68D.2020505@linux.intel.com>
References: <200608211146.53379.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:14714 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422704AbWHURAD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 13:00:03 -0400
In-Reply-To: <200608211146.53379.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, Natalie.Protasevich@unisys.com

Andy,
We are about to release new table code, which will not allocate memory for any tables,
but just map them from their physical location, does it solve the problem you describe?

Regards,
	Alex.

Andi Kleen wrote:
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
> are read. During SLES10 testing we had some problems with the ACPI
> tables on some Unisys systems being in a area where the kexec kernel
> wanted to be loaded too. Also on other systems the ACPI tables are not
> exactly at the end but in the middle of the memory map and for some applications
> it might be better to have a lot of physical continuous memory.
> 
> So are there any plans to free the BIOS supplied ACPI tables after parsing
> or is there some obstacle to that that I'm missing?
> 
> Thanks,
> -Andi
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
