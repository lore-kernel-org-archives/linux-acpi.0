From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH] ACPI, cpu hotplug: move try_offline_node() after acpi_unmap_lsapic()
Date: Fri, 09 Aug 2013 15:28:46 +0800
Message-ID: <52049A2E.8080101@cn.fujitsu.com>
References: <5200CBBF.1090904@jp.fujitsu.com> <1375808178.10300.181.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:9175 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030401Ab3HIHaL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Aug 2013 03:30:11 -0400
In-Reply-To: <1375808178.10300.181.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Wen Congyang <wency@cn.fujitsu.com>

On 08/07/2013 12:56 AM, Toshi Kani wrote:
> On Tue, 2013-08-06 at 19:11 +0900, Yasuaki Ishimatsu wrote:
>> try_offline_node() checks that all cpus related with removed node have been
>> removed by using cpu_present_bits. If all cpus related with removed node have
>> been removed, try_offline_node() clears the node information.
>>
>> But try_offline_node() called from acpi_processor_remove() never clears
>> the node information. For disabling cpu_present_bits, acpi_unmap_lsapic()
>> need be called. But acpi_unmap_lsapic() is called after try_offline_node()
>> runs. So when try_offline_node() runs, the cpu's cpu_present_bits is always
>> set.
>>
>> This patch moves try_offline_node() after acpi_unmap_lsapic().
>>
>> Signed-off-by: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
>
> The change looks good to me.
>
> Acked-by: Toshi Kani<toshi.kani@hp.com>
>
> BTW, do you know why try_offline_node() has to use stop_machine()?

try_offline_node() is used to check if the node could be hot-removed
after each memory or cpu hot-remove operation.

In memory hot-remove path, we have lock_memory_hotplug() to series all
the memory hot-remove options.

But when doing cpu hot-remove,

acpi_processor_remove()
  |->try_offline_node()

There is no lock to protect it. I think, when we are going to hot-remove
a node, others should not do any memory or cpu hotplug operation. In memory
hotplug path, we have lock_memory_hotplug(). But in cpu hotplug path, I
didn't find any lock. So we used stop_machine() to call check_cpu_on_node().
If we find any cpu still present, we return and do not remove the node.

Thanks.

