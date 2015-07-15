From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 3/5] x86, acpi, cpu-hotplug: Introduce apicid_to_cpuid[]
 array to store persistent cpuid <-> apicid mapping.
Date: Wed, 15 Jul 2015 14:26:12 +0800
Message-ID: <55A5FD04.1090003@cn.fujitsu.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com>	<1436261425-29881-4-git-send-email-tangchen@cn.fujitsu.com> <CAChTCPw6ZLs7XgApfN1exeB6TVcQji6ryq+HrK-admp=FGfiTA@mail.gmail.com> <55A5D4A5.8040806@cn.fujitsu.com> <55A5F109.3020705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:48894 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750772AbbGOGZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2015 02:25:31 -0400
In-Reply-To: <55A5F109.3020705@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.j.penttila@gmail.com>
Cc: rjw@rjwysocki.net, gongzhaogang@inspur.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org


On 07/15/2015 01:35 PM, Jiang Liu wrote:
> On 2015/7/15 11:33, Tang Chen wrote:
>> Hi Mika,
>>
>> On 07/07/2015 07:14 PM, Mika Penttil=C3=A4 wrote:
>>> I think you forgot to reserve CPU 0 for BSP in cpuid mask.
>> Sorry for the late reply.
>>
>> I'm not familiar with BSP.  Do you mean in get_cpuid(),
>> I should reserve 0 for physical cpu0 in BSP ?
>>
>> Would you please share more detail ?
> BSP stands for "Bootstrapping Processor". In other word,
> BSP is CPU0.
> .
>

Ha, how foolish I am.

And yes, cpu0 is not reserved when apicid =3D=3D boot_cpu_physical_apic=
id
comes true.

Will update the patch.

Thanks. :)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
