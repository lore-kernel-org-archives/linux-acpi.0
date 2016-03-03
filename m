From: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Subject: Re: [RESEND PATCH v5 0/5] Make cpuid <-> nodeid mapping persistent
Date: Thu, 3 Mar 2016 10:15:17 +0800
Message-ID: <56D79E35.7030000@cn.fujitsu.com>
References: <1456969327-20011-1-git-send-email-zhugh.fnst@cn.fujitsu.com> <CAJZ5v0j1WMi5qMYoUeto8EbV2XnhZQ1j7eQ3jJtoC7h5dOxxkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:34386 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbcCCCRy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2016 21:17:54 -0500
In-Reply-To: <CAJZ5v0j1WMi5qMYoUeto8EbV2XnhZQ1j7eQ3jJtoC7h5dOxxkw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: cl@linux.com, Tejun Heo <tj@kernel.org>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, chen.tang@easystack.cn, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>

Hi,

On 03/03/2016 10:08 AM, Rafael J. Wysocki wrote:
> Hi,
>
> On Thu, Mar 3, 2016 at 2:42 AM, Zhu Guihua <zhugh.fnst@cn.fujitsu.com> wrote:
>> [Problem]
>>
>> cpuid <-> nodeid mapping is firstly established at boot time. And workqueue caches
>> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot time.
>>
>> When doing node online/offline, cpuid <-> nodeid mapping is established/destroyed,
>> which means, cpuid <-> nodeid mapping will change if node hotplug happens. But
>> workqueue does not update wq_numa_possible_cpumask.
>>
> Are there any changes in this version relative to the previous one?
No, there are no changes in this version.

Thanks,
Zhu

>
> Thanks,
> Rafael
>
>
> .
>



