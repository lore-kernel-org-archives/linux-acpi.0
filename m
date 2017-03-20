From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI / APEI: Add missing synchronize_rcu() on NOTIFY_SCI removal.
Date: Mon, 20 Mar 2017 14:10:45 +0800
Message-ID: <878to08om2.fsf@yhuang-dev.intel.com>
References: <20170316143039.375-1-james.morse@arm.com>
        <87inn8wvaz.fsf@yhuang-dev.intel.com> <58CBC081.8060505@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39183 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdCTGLH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 02:11:07 -0400
In-Reply-To: <58CBC081.8060505@arm.com> (James Morse's message of "Fri, 17 Mar
        2017 10:54:57 +0000")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-acpi@vger.kernel.org, Shiju Jose <shiju.jose@huawei.com>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

James Morse <james.morse@arm.com> writes:

> Hi Huang, Ying
>
> On 17/03/17 01:23, Huang, Ying wrote:
>> James Morse <james.morse@arm.com> writes:
>> 
>>> When removing a GHES device notified by SCI, list_del_rcu() is used,
>>> ghes_remove() should call synchronize_rcu() before it goes on to call
>>> kfree(ghes), otherwise concurrent RCU readers may still hold this list
>>> entry after it has been freed.
>
>>> ---
>>> It looks like 81e88fdc432a lifted this into ACPI_HEST_NOTIFY_NMI, missing
>>> that ACPI_HEST_NOTIFY_SCI needed it too.
>>>
>>> If there is only ever one SCI GHES entry this is safe today as
>>> unregister_acpi_hed_notifier() takes a write lock on its semaphore, meaning
>>> any RCU readers will have finished.
>
>
>> In remove path
>> 
>> unregister_acpi_hed_notifier()
>>   blocking_notifier_chain_unregister()
>>     down_write(&nh->rwsem)
>> 
>> While in notifier call path
>> 
>> acpi_hed_notify()
>>   blocking_notifier_call_chain()
>>     __blocking_notifier_call_chain()
>>       down_read(&nh->rwsem)
>> 
>> So when unregister succeeds, the notifier call should have
>> finished.
>
> You are only protected like this if the unregister call is made for every
> list_del_rcu(), which would only be the case if there is only ever one SCI GHES
> entry.
>
> Is this how NOTIFY_SCI is expected to be used?
>
> If so I agree its safe, (but confusing!) today, and we need to take account of
> this behaviour in Shiju Jose's patch.
>
>
> If there can be multiple SCI entries, you only get this unregister protection
> for the last one to be freed, as the list_empty() check skips the unregister for
> all but the last entry.

Yes.  You are right.  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

In your patch.

Best Regards,
Huang, Ying

>>	case ACPI_HEST_NOTIFY_SCI:
>>		mutex_lock(&ghes_list_mutex);
>>		list_del_rcu(&ghes->list);
>>		if (list_empty(&ghes_sci))
>>			unregister_acpi_hed_notifier(&ghes_notifier_sci);
>>		mutex_unlock(&ghes_list_mutex);
>>		break;
>
>
>
> Thanks,
>
> James
