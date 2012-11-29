From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: ZPODD ACPI _PRW method support
Date: Thu, 29 Nov 2012 09:36:53 +0800
Message-ID: <50B6BC35.4090900@intel.com>
References: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com> <1804754.cgLN50ubYg@vostro.rjw.lan> <CANh5a1xKFp57VQfufUzs3maxt8wHZCVv6gTpyvQr8FzNCJG=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36891 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab2K2Bgf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 20:36:35 -0500
In-Reply-To: <CANh5a1xKFp57VQfufUzs3maxt8wHZCVv6gTpyvQr8FzNCJG=0A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jeff.Wu" <chping@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Shane Huang <shane.huang@amd.com>, Aaron Lu <aaron.lwe@gmail.com>

Move Lin Ming to BCC.
Ming does not support ZPODD anymore, he may be kind to help, but please
direct all ZPODD related questions/problems first to me, thanks.

On 11/29/2012 12:11 AM, Jeff.Wu wrote:
> Hi Rafael
> 
> Thanks,
> 
> I  am testing ZPODD function ,for Linux ZPODD kernel,
> if _PRW method is removed at  BIOS ACPI DSDT codes, ZPODD work normally.
> but, if _PRW method is added at BIOS ACPI DSDT codes,ZPODD can't be
> wakeup when ZPODD state is suspend.
> I'am not sure that Linux ZPODD whether is using _PRW to send wakeup events.

Can you please let me know which version of ZPODD patches you are
testing on? And please show me the DSDT content of the ACPI node for
ZPODD.

Thanks,
Aaron

> 
> Jeff
> 
> 2012/11/28 Rafael J. Wysocki <rjw@sisk.pl>:
>> On Wednesday, November 28, 2012 04:52:17 PM Jeff.Wu wrote:
>>> Hi aaron,ming,linux-acpi
>>>
>>>  Is it  whether need support ACPI _PRW method for ZPODD device ?
>>
>> Yes, it is.
>>
>>>  If BIOS had implemented _PRW method for ZPODD ,
>>> but Linux kernel doesn't support  ZPODD _PRW method,ZPODD will can't
>>> run into suspend state.
>>
>> I'm not sure what you mean.
>>
>> If we don't use _PRW, the device won't be able to signal wakeup events.
>>
>>> Is there any stories for ZPODD Linux _PRW method ?
>>
>> All threads related to ZPODD are about that indirectly.
>>
>> Thanks,
>> Rafael
>>
>>
>> --
>> I speak only for myself.
>> Rafael J. Wysocki, Intel Open Source Technology Center.

