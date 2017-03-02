From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/4] Revert"x86/acpi: Enable MADT APIs to return
 disabled apicids"
Date: Thu, 2 Mar 2017 16:02:38 +0800
Message-ID: <af90b512-b771-d1e5-08e6-7589f6dfca17@cn.fujitsu.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1487580471-17665-3-git-send-email-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.20.1703011151090.4005@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:47308 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750771AbdCBIRh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2017 03:17:37 -0500
In-Reply-To: <alpine.DEB.2.20.1703011151090.4005@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi tglx,

At 03/01/2017 06:52 PM, Thomas Gleixner wrote:
> On Mon, 20 Feb 2017, Dou Liyang wrote:
>
>> After we never do the last mapping of "cpuid <-> nodeid" at booting time. we
>> also no need to enable MADT APIs to return disabled apicid.
>>
>> So, The patch work for reverting the commit 8ad893faf2:
>> "x86/acpi: Enable MADT APIs to return disabled apicids"
>
> Again, this changelog is confusing. A simple:
>
>   Remove the leftovers of the boot time 'cpuid <-> nodeid' mapping approach.
>
> would be sufficient and entirely clear.
>

Yes, I see, I will rewrite it in next version.

Thanks.

	Liyang.

> Thanks,
>
> 	tglx
>
>
>
>


