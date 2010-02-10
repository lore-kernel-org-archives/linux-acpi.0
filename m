From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Recent GPE patches - some questions.
Date: Wed, 10 Feb 2010 13:36:30 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085855DD7F24@orsmsx503.amr.corp.intel.com>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
 <20100201223619.GB15766@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D83085855BBDA89@orsmsx503.amr.corp.intel.com>
 <201002070031.54680.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27318 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab0BJVgc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2010 16:36:32 -0500
In-Reply-To: <201002070031.54680.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>



>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>Sent: Saturday, February 06, 2010 3:32 PM
>To: Moore, Robert
>Cc: Matthew Garrett; linux-acpi@vger.kernel.org; Len Brown
>Subject: Re: Recent GPE patches - some questions.
>
>Hi,
>
>On Wednesday 03 February 2010, Moore, Robert wrote:
>> Matthew,
>>
>> Thanks for your response to my questions.
>>
>> I've been thinking about these interfaces:
>>
>> acpi_ref_runtime_gpe
>> acpi_ref_wakeup_gpe
>> acpi_unref_runtime_gpe
>> acpi_unref_wakeup_gpe
>>
>> While I understand the need for the reference counting mechanism, it is a
>> good idea to support the shared GPEs, I think it may be simpler and
>cleaner
>> to simply not directly expose this mechanism to GPE users.
>
>Well, it already is exposed to the users and in a way that doesn't look
>very
>clean to me.  Namely, to enable a wakeup GPE for run time, the caller needs
>to
>set its type to ACPI_GPE_TYPE_WAKE_RUN before calling acpi_enable_gpe(),
>while with the Matthew's interface the only thing the caller would need to
>do
>would be calling acpi_ref_runtime_gpe().
>
>> I'm suggesting that we add the reference counting mechanism to the
>existing
>> AcpiEnableGpe and AcpiDisableGpe interfaces and update their
>descriptions.
>> We already hide the differences between wake, run, and wake-run GPEs
>behind
>> these interfaces.
>
>Not really, as I said above.
>
>Moreover, we need two reference counters, because there are cases when a
>GPE should be enabled for wakeup and not enabled for run time and vice
>versa.
>
>> Adding the reference count semantic to these interfaces changes their
>> behavior in a fairly simple way:
>>
>> Support for shared GPEs:
>> AcpiEnableGpe: For a given GPE, it is actually enabled only on the first
>call.
>> AcpiDisableGpe: For a given GPE, it is actually disabled only on the last
>call.
>
>I suppose you mean acpi_enable_gpe() and acpi_disable_gpe().
>
>That wouldn't work, because sometimes we need to actually hardware-disable
>GPEs and hardware-enable them regardless of the refcount mechanism, like
>for example in the EC suspend and resume routines.

Yes, this makes sense, even if the EC GPE is shared.


>
>That said, if you are afraid that the new interface may be cumbersome for
>the
>callers, I think we can introduce just two callbacks,
>
>acpi_get_gpe()
>acpi_put_gpe()
>
>taking 3 arguments each, where the two first arguments are like for the
>Matthew's callbacks and the third argument is a mask of two bits:
>
>ACPI_GPE_TYPE_WAKE
>ACPI_GPE_TYPE_RUNTIME
>
>that will tell the callback whether to use the wakeup or runtime counter
>for
>reference counting (if called with ACPI_GPE_TYPE_WAKE_RUN, both
>reference counters will be modified at the same time).
>
>Please tell me what you think.
>
>Rafael



Good, I like having the two interfaces better than the original four.

However, I'm having some trouble with the naming. I think I would like to keep acpi_enable_gpe and acpi_disable_gpe as the high-level enable/disable interfaces that may or may not actually touch the hardware depending on reference count, run vs. wake, etc. Thus, enable_gpe and disable_gpe remain similar to today (with addition of new reference count mechanisms) and would correspond to put_gpe and get_gpe above. I think this also has the advantage of reducing changes to existing drivers across all operating systems supported by ACPICA.

Then, we have the special case where a driver must absolutely (H/W) enable/disable a GPE, regardless of sharing. Probably only the EC driver needs this. I would like to see new interfaces for these. Actually, one new interface would probably suffice. Something like:

acpi_set_gpe (ENABLE | DISABLE)


Bob



