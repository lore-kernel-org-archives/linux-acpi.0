From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Possible bug in ACPI
Date: Wed, 06 Dec 2006 19:07:06 +0300
Message-ID: <4576EAAA.6000408@linux.intel.com>
References: <20060919214724.GB2073@panelnet.cz>	<20061109140416.db12bcbe.akpm@osdl.org>	<20061202205140.GA12447@panelnet.cz>	<20061202192632.d1815e5f.akpm@osdl.org>	<457293AE.2060701@linux.intel.com>	<20061203021216.e15b1d5d.akpm@osdl.org>	<4572994C.6020603@linux.intel.com>	<20061203122731.c9a514aa.akpm@osdl.org>	<45734070.6040305@linux.intel.com>	<4576E364.3090800@linux.intel.com> <20061206075449.22a1ded4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7893 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936312AbWLFQJY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Dec 2006 11:09:24 -0500
In-Reply-To: <20061206075449.22a1ded4.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

Andrew,

Full description was sent to you and linux-acpi mail-list. I received 
copy from mail-list, so if you didn't, you can browse linux-acpi archive 
of Dec 4.
Also patch in #5534 was updated with the full description.
If you know, why my mails don't reach you, please advise...

Thanks,
    Alex.

Andrew Morton wrote:
> On Wed, 06 Dec 2006 18:36:04 +0300
> Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
>
>   
>> Would it be better to replace sys_sched_yield() with cond_resched()?
>>     
>
> I don't know, because I don't understand the dynamics of the proposed
> change at all.
>
> Again:
>
> - How does it relate to http://lkml.org/lkml/2006/8/8/336
>
> - Can we please have a *full* description of the problem and of the proposed
>   solution?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
