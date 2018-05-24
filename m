From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
Date: Thu, 24 May 2018 10:54:19 +0200
Message-ID: <9cf4c5f3-f1ee-67c2-967e-07aa568685c4@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
 <20180523182404.11433-2-david@redhat.com>
 <CAJZ5v0jar8TqC5MGRPcAVZfM3LmmoSV3fT3Sgok=r6D9cDG0+w@mail.gmail.com>
 <5342a59c-4ca1-2cf5-a1d4-07a6d6f03587@redhat.com>
 <CAJZ5v0grgYRi24oyFP0xcjip5Z5apLE5ozn8znahdtkqKvD_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0grgYRi24oyFP0xcjip5Z5apLE5ozn8znahdtkqKvD_MA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 24.05.2018 10:47, Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 10:33 AM, David Hildenbrand <david@redhat.com> wrote:
>> On 24.05.2018 10:12, Rafael J. Wysocki wrote:
>>> On Wed, May 23, 2018 at 8:24 PM, David Hildenbrand <david@redhat.com> wrote:
>>>> Will be needed by paravirtualized memory devices.
>>>
>>> That's a little information.
>>>
>>> It would be good to see the entire series at least.
>>
>> It's part of this series (guess you only received the cover letter and
>> this patch). Here a link to the patch using it:
>>
>> https://lkml.org/lkml/2018/5/23/803
> 
> OK, thanks!
> 
> It looks like you have a reason to use it in there, but please note
> that CONFIG_ACPI_NUMA depends on CONFIG_NUMA, so you don't need to use
> the latter directly in the #ifdef.  Also wouldn't IS_ENABLED() work
> there?

Thanks for the tip on CONFIG_ACPI_NUMA. Wouldn't IS_ENABLED() require to
have a dummy implementation of pxm_to_node() in case drivers/acpi/numa.c
is not compiled?

> 
> Moreover, you don't need the local node variable in
> virtio_mem_translate_node_id().
> 

Indeed, thanks!

-- 

Thanks,

David / dhildenb
