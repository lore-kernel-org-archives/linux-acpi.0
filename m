From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Recent GPE patches - some questions.
Date: Tue, 2 Feb 2010 15:02:26 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085855BBDA89@orsmsx503.amr.corp.intel.com>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
 <20100201223619.GB15766@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37560 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546Ab0BBXCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 18:02:46 -0500
In-Reply-To: <20100201223619.GB15766@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>

Matthew, 

Thanks for your response to my questions.

I've been thinking about these interfaces:

acpi_ref_runtime_gpe
acpi_ref_wakeup_gpe
acpi_unref_runtime_gpe
acpi_unref_wakeup_gpe

While I understand the need for the reference counting mechanism, it is a good idea to support the shared GPEs, I think it may be simpler and cleaner to simply not directly expose this mechanism to GPE users.

I'm suggesting that we add the reference counting mechanism to the existing AcpiEnableGpe and AcpiDisableGpe interfaces and update their descriptions. We already hide the differences between wake, run, and wake-run GPEs behind these interfaces. Adding the reference count semantic to these interfaces changes their behavior in a fairly simple way:

Support for shared GPEs:
AcpiEnableGpe: For a given GPE, it is actually enabled only on the first call.
AcpiDisableGpe: For a given GPE, it is actually disabled only on the last call.

Bob

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg@redhat.com]
>Sent: Monday, February 01, 2010 2:36 PM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org; rjw@sisk.pl
>Subject: Re: Recent GPE patches - some questions.
>
>On Fri, Jan 29, 2010 at 12:30:25PM -0800, Moore, Robert wrote:
>
>> [PATCH 0/3] acpica: Rewrite GPE handling
>>
>> Overall, can we say that this change to the GPE code is primarily
>> intended to add better support for shared GPEs?
>
>Yes, that's probably the easiest way to look at it.
>
>> [PATCH 1/3] ACPI: Add infrastructure for refcounting GPE consumers:
>>
>> >Add an API to allow devices to indicate whether or not
>> >they want their device's GPE to be enabled for both runtime
>> >and wakeup events.
>>
>> I'm not sure which interface you are referring to, please explain
>
>This is simply the ref/unref functions.
>
>
>> [PATCH 2/3] ACPI: Add support for new refcounted GPE API to drivers:
>>
>> Reference count mechanism is meant to:
>>     1) Enable GPE only on the first added reference
>>     2) Disable GPE only on the last removed reference
>>
>> Then I don't understand why the code below needs to call acpi_enable_gpe:
>>
>> 		acpi_enable_gpe(dev->wakeup.gpe_device,
>>  				dev->wakeup.gpe_number);
>> +		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
>> +				    dev->wakeup.gpe_number);
>>
>> Because the GPE will be "enabled" (mask bit set for wakeup GPE) by
>> acpi_ref_wakeup_gpe. There are several examples of this type of code.
>> If it is true that the call to acpi_enable_gpe is unnecessary, then is
>> acpi_enable_gpe interface needed at all? (same with disable_gpe).
>
>That's simply to make it easier to bisect through the changes - 3/3
>removes the explicit enable_gpe call.
>
>> [PATCH 1/3] acpi: Provide default GPE handler if the firmware doesn't
>>
>> >Firmware may support using GPEs for system wakeup without
>> >providing any runtime GPE handlers.
>>
>> Do you mean by "runtime GPE handlers" to mean the _Lxx/_Exx GPE methods?
>If so, this should be clarified in the comments.
>
>Ok. I'm not sure that we'll be pushing this aspect of it yet, we'll have
>to wait and see what the hardware support situation ends up being.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
