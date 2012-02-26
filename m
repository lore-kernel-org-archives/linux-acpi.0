From: "Liu, Jinsong" <jinsong.liu@intel.com>
Subject: RE: [PATCH 1/2] RFC: Prepare PAD for native and xen platform
Date: Sun, 26 Feb 2012 08:25:41 +0000
Message-ID: <DE8DF0795D48FD4CA783C40EC82923350B2013@SHSMSX101.ccr.corp.intel.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
 <4F46530B020000780007F751@nat28.tlf.novell.com>
 <DE8DF0795D48FD4CA783C40EC82923350AD9BB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350AD9BB@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@suse.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Cc: "keir.xen@gmail.com" <keir.xen@gmail.com>, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Liu, Jinsong wrote:
> Jan Beulich wrote:
>>>>> "Liu, Jinsong" <jinsong.liu@intel.com> 02/23/12 2:29 PM >>>
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -213,10 +213,11 @@ config ACPI_HOTPLUG_CPU
>>>    default y
>>  >
>>> config ACPI_PROCESSOR_AGGREGATOR
>>> -    tristate "Processor Aggregator"
>>> +    bool "Processor Aggregator"
>> 
>> There must be ways to address whatever strange problem you see
>> without making this piece of code non-modular.
>> 
> 
> Yes, another approach is x86_init approach, defining acpi_pad_ops at
> x86_init.c and overwritten when xen_start_kernel. This patch is just
> a RFC patch, to evaluate which approch is more reasonable :-) 
> 

Have a more think about it, x86_init approach still need to disable acpi_pad module.
Seems we have to set acpi_pad as bool, as long as it need to hook to native acpi_pad fucs/variables.

Thanks,
Jinsong