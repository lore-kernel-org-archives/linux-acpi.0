From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for
 x86_64
Date: Tue, 8 Jan 2019 09:32:59 -0800
Message-ID: <7706aaac-c00b-8a11-a7a1-cb95b5a01581@intel.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-5-git-send-email-kernelfans@gmail.com>
 <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
 <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 1/7/19 10:13 PM, Pingfan Liu wrote:
> On Tue, Jan 8, 2019 at 1:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> Why is this 0x100000 open-coded?  Why is this needed *now*?
>>
> 
> Memory under 1MB should be used by BIOS. For x86_64, after
> e820__memblock_setup(), the memblock allocator has already been ready
> to work. But there are two factors to in order to
> set_alloc_range(0x100000, end). The major one is to be compatible with
> x86_32, please refer to alloc_low_pages->memblock_find_in_range() uses
> [min_pfn_mapped, max_pfn_mapped] to limit the range, which is ready to
> be allocated from. The minor one is to prevent unexpected allocation
> from memblock allocator through allow_low_pages() at very early stage.

Wow, that's a ton of critical information which was neither commented
upon or referenced in the changelog.  Can you fix this up in the next
version, please?
