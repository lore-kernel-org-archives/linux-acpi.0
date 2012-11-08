From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] ACPI: fix missing unlock on error in acpi_memory_remove_memory()
Date: Thu, 8 Nov 2012 12:31:12 +0800
Message-ID: <CAPgLHd8a45+GfNFwox6M-QLbLmZNZHHz1a2BZjGV4Po1a0b6gg@mail.gmail.com>
References: <CAPgLHd_=OTwu-3tVXT0o8+x=N_9dZOkQ4A7HFr0SNdUiyAy_yw@mail.gmail.com>
	<509B0B7F.3030308@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40800 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2KHEbN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2012 23:31:13 -0500
In-Reply-To: <509B0B7F.3030308@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wency@cn.fujitsu.com
Cc: lenb@kernel.org, rjw@sisk.pl, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

Hi Wen,

On 11/08/2012 09:31 AM, Wen Congyang wrote:
> Hi, wei
>
> At 11/07/2012 08:38 PM, Wei Yongjun Wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Add the missing mutex_unlock() before return from function
>> acpi_memory_remove_memory() in the error handling case.
>>
>> Introduce by commit 85fcb3758c10e063a2a30dfad75017097999deed
>> 'ACPI / memory-hotplug: introduce a mutex lock to protect the list in acpi_memory_device'
>>
>> dpatch engine is used to auto generate this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> Thanks for your patch.
>
> Dan Carpenter has told me this problem. I fix it, but don't
> resend it because it is in test now.

I saw your patchset has already applied to linux-pm.git tree:
http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=shortlog;h=refs/heads/linux-next

So I think what need is to send a new patch to fix it, not
resend the full patchset.

Regards,
Yongjun Wei

