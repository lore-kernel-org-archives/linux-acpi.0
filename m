From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 1/6] mm/memory_hotplug: make remove_memory() take
 the device_hotplug_lock
Date: Fri, 31 Aug 2018 15:12:05 +0200
Message-ID: <5b1f79cd-553b-4f9d-2690-8d7fb553278e@redhat.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-2-david@redhat.com>
 <46a0119b-da16-0203-a8c2-d127738517f4@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46a0119b-da16-0203-a8c2-d127738517f4@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pasha Tatashin <Pavel.Tatashin@microsoft.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rashmica Gupta <rashmica.g@gmail.com>, Michael Neuling <mikey@neuling.org>, Balbir Singh <bsingharora@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>A
List-Id: linux-acpi@vger.kernel.org

On 30.08.2018 21:35, Pasha Tatashin wrote:
>> +
>> +void __ref remove_memory(int nid, u64 start, u64 size)
> 
> Remove __ref, otherwise looks good:

Indeed, will do.

Thanks for the review. Will resend in two weeks when I'm back from vacation.

Cheers!

> 
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 
>> +{
>> +	lock_device_hotplug();
>> +	__remove_memory(nid, start, size);
>> +	unlock_device_hotplug();
>> +}
>>  EXPORT_SYMBOL_GPL(remove_memory);
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */


-- 

Thanks,

David / dhildenb
