From: "Liu, Jinsong" <jinsong.liu@intel.com>
Subject: RE: [PATCH 1/2] RFC: Prepare PAD for native and xen platform
Date: Thu, 23 Feb 2012 16:58:34 +0000
Message-ID: <DE8DF0795D48FD4CA783C40EC82923350AD9BB@SHSMSX101.ccr.corp.intel.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
 <4F46530B020000780007F751@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27059 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab2BWQ6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Feb 2012 11:58:41 -0500
In-Reply-To: <4F46530B020000780007F751@nat28.tlf.novell.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <jbeulich@suse.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Cc: "keir.xen@gmail.com" <keir.xen@gmail.com>, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jan Beulich wrote:
>>>> "Liu, Jinsong" <jinsong.liu@intel.com> 02/23/12 2:29 PM >>>
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -213,10 +213,11 @@ config ACPI_HOTPLUG_CPU
>>    default y
>  >
>> config ACPI_PROCESSOR_AGGREGATOR
>> -    tristate "Processor Aggregator"
>> +    bool "Processor Aggregator"
> 
> There must be ways to address whatever strange problem you see without
> making this piece of code non-modular.
> 

Yes, another approach is x86_init approach, defining acpi_pad_ops at x86_init.c and overwritten when xen_start_kernel.
This patch is just a RFC patch, to evaluate which approch is more reasonable :-)

>>    depends on ACPI_PROCESSOR
>>    depends on EXPERIMENTAL
>>    depends on X86
>> +    default n
> 
> This is pointless.

Elaborate more? just a little curious why Kconfig has so many default n.

> 
>>    help
>>      ACPI 4.0 defines processor Aggregator, which enables OS to
>>      perform specific processor configuration and control that
>> applies to all 
> 
> Jan

