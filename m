From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: acpi exception with current -mm lineup (HPET)
Date: Thu, 31 May 2007 16:07:52 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F5F5AAF4@scsmsx415.amr.corp.intel.com>
References: <200705310202.18124.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63947 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbXEaXHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 19:07:55 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200705310202.18124.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org] 
>Sent: Wednesday, May 30, 2007 11:02 PM
>To: Andrew Morton; Pallipadi, Venkatesh
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: acpi exception with current -mm lineup (HPET)
>
>
>> I put a copy of /proc/acpi/dsdt at 
>http://userweb.kernel.org/~akpm/dsdt
>> if that's any help.
>> 
>> Full dmesg at http://userweb.kernel.org/~akpm/dmesg-x.txt
>
>Okay, this BIOS actually has a real HPET table:
>
>ACPI: HPET 7FFD7460, 0038 (r1 A M I  OEMHPET   5000427 MSFT       97)
>
>and the hpet is actually found:
>
>Calling initcall 0xffffffff80652488: late_hpet_init+0x0/0xd1()
>hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>hpet0: 3 64-bit timers, 14318180 Hz
>initcall 0xffffffff80652488: late_hpet_init+0x0/0xd1() returned 0.
>initcall 0xffffffff80652488 ran for 0 msecs: late_hpet_init+0x0/0xd1()
>...
>
>Perhaps Venki can comment on if the resource conflict is expected
>to be fatal or not.
>


The issue seems to be HPET at two different places in BIOS/ACPI.
One listing is in MADT which is used to set up kernel timer and
which reserves this resource earlier

hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0

And later hpet character driver is finding HPET listed in _CRS
And finds it is the same HPET as the one looked at before
Causing this conflict. Totally nonfatal.
Just correcting the return type of hpet_resources should be fine here.

Thanks,
Venki 
