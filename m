From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 7/7] Provide the interface to validate the proc_id
 which they give
Date: Wed, 20 Jul 2016 08:55:11 +0800
Message-ID: <438ce500-ec84-9f55-0422-d033a1f4590f@cn.fujitsu.com>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-8-git-send-email-douly.fnst@cn.fujitsu.com>
 <20160719185320.GN3078@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:32937 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752338AbcGTA5F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2016 20:57:05 -0400
In-Reply-To: <20160719185320.GN3078@mtj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org



=E5=9C=A8 2016=E5=B9=B407=E6=9C=8820=E6=97=A5 02:53, Tejun Heo =E5=86=99=
=E9=81=93:
> On Tue, Jul 19, 2016 at 03:28:08PM +0800, Dou Liyang wrote:
>> When we want to identify whether the proc_id is unreasonable or not,=
 we
>> can call the "acpi_processor_validate_proc_id" function. It will sea=
rch
>> in the duplicate IDs. If we find the proc_id in the IDs, we return t=
rue
>> to the call function. Conversely, false represents available.
>>
>> When we establish all possible cpuid <-> nodeid mapping, we will use=
 the
>> proc_id from ACPI table.
>>
>> We do validation when we get the proc_id. If the result is true, we =
will
>> stop the mapping.
> The patch title probably should include "acpi:" header.  I can't tell
> much about the specifics of the acpi changes but I think this is the
> right approach for handling cpu hotplugs.

I will change the title in the next version.

Thanks.
> Thanks.
>



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
