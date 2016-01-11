From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3] memory-hotplug: add automatic onlining policy for the newly added memory
Date: Mon, 11 Jan 2016 12:59:48 +0100
Message-ID: <871t9ojphn.fsf@vitty.brq.redhat.com>
References: <1452187421-15747-1-git-send-email-vkuznets@redhat.com>
	<56938B7E.3060902@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbcAKL7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jan 2016 06:59:54 -0500
In-Reply-To: <56938B7E.3060902@citrix.com> (David Vrabel's message of "Mon, 11
	Jan 2016 11:01:18 +0000")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Kiper <daniel.kiper@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Tang Chen <tangchen@cn.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Xishi Qiu <qiuxishi@huawei.com>, Mel Gorman <mgorman@techsingularity.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Igor Mammedov <imammedo@redhat.com>, Kay Sievers <kay@vrfy.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

David Vrabel <david.vrabel@citrix.com> writes:

> On 07/01/16 17:23, Vitaly Kuznetsov wrote:
>> 
>> - Changes since 'v1':
>>   Add 'online' parameter to add_memory_resource() as it is being used by
>>   xen ballon driver and it adds "empty" memory pages [David Vrabel].
>>   (I don't completely understand what prevents manual onlining in this
>>    case as we still have all newly added blocks in sysfs ... this is the
>>    discussion point.)
>

(there is a discussion with Daniel on the same topic in a parallel
thread)

> I'm not sure what you're not understanding here?
>
> Memory added by the Xen balloon driver (whether populated with real
> memory or not) does need to be onlined by udev or similar.


Yes, same as all other memory hotplug mechanisms (hyper-v's balloon
driver and acpi memory hotplug). My patch adds an option to make this
happen automatically. Xen driver is currently excluded because of a
deadlock. If this deadlock is the only problem we can easily change
taking the lock to checking that the lock was taken (and taking in case
it wasn't) or something similar and everything is going to work. From
briefly looking at the code it seems to me it's going to work.

What I wasn't sure about is 'empty pages' you were mentioning. In case
there are some pages we can't online there should be a protection
mechanism actively preventing them from going online (similar to
hv_online_page() in Hyper-V driver) as this patch does nothing
'special' compared to udev onlining newly added blocks. 

-- 
  Vitaly
