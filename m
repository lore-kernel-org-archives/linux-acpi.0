From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: Re: [PATCH 4/4] [Patch-next] ACPI, APEI, HEST Fix the unsuitable
 usage of platform_data.
Date: Tue, 17 Aug 2010 18:18:31 +0900
Message-ID: <4C6A53E7.3090301@np.css.fujitsu.com>
References: <4C69DEA5.1020902@np.css.fujitsu.com>	 <1282009188.2744.1498.camel@yhuang-dev>	 <4C69FB32.4000802@np.css.fujitsu.com> <1282018698.2744.1508.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42609 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab0HQJSR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2010 05:18:17 -0400
In-Reply-To: <1282018698.2744.1508.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <andi@firstfloor.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ACPI <linux-acpi@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>

(2010/08/17 13:18), Huang Ying wrote:
> On Tue, 2010-08-17 at 11:00 +0800, Jin Dongming wrote:
>>> Why not use platform_device_add_data?
>> Here what should be done is to transport the pointer of hest_hdr to platform_data,
>> so I think that it could be done successfully by allocating 8byte of memory.
>> If the platform_device_add_data() is used, the more memory will be allocated. 
>>
>> So I think this method is better than using platform_device_add_data().
> 
> You can specify allocation size for platform_device_add_data(), so no
> more memory will be allocated.
> 
> Best Regards,
> Huang Ying

I am sorry for replying late.
I will modify my patch and resend it again.

Best Regards,
Jin Dongming
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


