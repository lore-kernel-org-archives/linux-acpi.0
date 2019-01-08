From: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for
 x86_64
Date: Tue, 8 Jan 2019 07:37:19 +0100
Message-ID: <bf696c7a-e0d2-2e1e-e177-6e260c7129c2@suse.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-5-git-send-email-kernelfans@gmail.com>
 <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
 <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>, Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/01/2019 07:13, Pingfan Liu wrote:
> On Tue, Jan 8, 2019 at 1:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 1/7/19 12:24 AM, Pingfan Liu wrote:
>>> There are two acheivements by this patch.
>>> -1st. keep the subtree of pgtable away from movable node.
>>> Background about the defect of the current bottom-up allocation style, take
>>> the following scenario:
>>>   |  unmovable node |     movable node                           |
>>>      | kaslr-kernel |subtree of pgtable for phy<->virt |
>>
>>
>>
>>> Although kaslr-kernel can avoid to stain the movable node. [1] But the
>>> pgtable can still stain the movable node. That is a probability problem,
>>> with low probability, but still exist. This patch tries to eliminate the
>>> probability. With the previous patch, at the point of init_mem_mapping(),
>>> memblock allocator can work with the knowledge of acpi memory hotmovable
>>> info, and avoid to stain the movable node. As a result,
>>> memory_map_bottom_up() is not needed any more.
>>>
>>> -2nd. simplify the logic of memory_map_top_down()
>>> Thanks to the help of early_make_pgtable(), x86_64 can directly set up the
>>> subtree of pgtable at any place, hence the careful iteration in
>>> memory_map_top_down() can be discard.
>>
>>>  void __init init_mem_mapping(void)
>>>  {
>>>       unsigned long end;
>>> @@ -663,6 +540,7 @@ void __init init_mem_mapping(void)
>>>
>>>  #ifdef CONFIG_X86_64
>>>       end = max_pfn << PAGE_SHIFT;
>>> +     set_alloc_range(0x100000, end);
>>>  #else
>>
>> Why is this 0x100000 open-coded?  Why is this needed *now*?
>>
> 
> Memory under 1MB should be used by BIOS. For x86_64, after

Xen PV- and PVH-guests don't have that BIOS restriction.


Juergen
