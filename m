From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Tue, 24 Mar 2009 13:45:07 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl>
 <49C7DDDC.2050103@goop.org> <200903232127.40683.rjw@sisk.pl>
 <49C86C41.1060803@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877A@pdsmsx502.ccr.corp.intel.com>
 <49C872D1.8060403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28018 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbZCXFrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 01:47:20 -0400
In-Reply-To: <49C872D1.8060403@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Jeremy Fitzhardinge' <jeremy@goop.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

>From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
>Sent: Tuesday, March 24, 2009 1:43 PM
>
>Tian, Kevin wrote:
>> The reason why those useless code are prevented, is in case of
>> clobberring 0-1M area which if contains valid Xen content. in
>> acpi_save_state_mem, dom0's wakeup code is copied to area
>> allocated in acpi_reserve_bootmem. If every Xen's usage on 0-1M
>> is based on copy-on-use style, such as trampoline code for AP
>> boot, it's ok. But I'm not sure whether Xen puts some persistent
>> content there. IIRC, that boot time allocation usually returns sth
>> like 0x90000 since wakeup stub is first run in real mode. But if
>> for dom0 alloc_bootmem_low never gives <1M page, then this
>> prevention could be skipped as your thought.
>>   
>
>Yes, but the memory allocated is only in 0-1M in dom0's 
>pseudo-physical 
>space, not in Xen's machine space.  It allocates the memory and does a 
>virt_to_phys on it, but there's no special effort to remap it 
>as mfns or 
>anything.  There should be no possible conflict with Xen's use of the 
>real 0-1M region.

OK, then it's safe to avoid that change. I had thought that dom0's 0-1M
is identity-mapped to machine 0-1M... :-)

Thanks,
Kevin

>
>Not that I've actually tried to execute that patch yet, so I 
>could well 
>be overlooking something...
>
>    J
>
