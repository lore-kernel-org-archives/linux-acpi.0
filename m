From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Fri, 7 Jan 2011 12:41:31 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858BFD9B12E@orsmsx503.amr.corp.intel.com>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>
  <5acdb1af907d5908b4942d425c0983f353dd8fc5.1293403093.git.len.brown@intel.com>
 <201012272116.23678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16008 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab1AGUle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jan 2011 15:41:34 -0500
In-Reply-To: <201012272116.23678.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

Rafael,

Rather than disabling GPE bits one-by-one, I'd like to disable all GPE bits in all GPE registers within the block at the time the block is installed, by clearing/disabling entire registers with a single write. This would cover all the weird hardware and BIOS possibilities in one fell swoop. I believe that this was the original behavior of ACPICA.

Bob


>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>Sent: Monday, December 27, 2010 12:16 PM
>To: Lin, Ming M; Moore, Robert
>Cc: Len Brown; linux-acpi@vger.kernel.org; Brown, Len
>Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
>
>Hi,
>
>The patch below is needed in the ACPICA core.
>
>On Sunday, December 26, 2010, Len Brown wrote:
>> From: Rafael J. Wysocki <rjw@sisk.pl>
>>
>> GPEs with corresponding _Lxx/_Exx control methods need to be disabled
>> during initialization in case they have been enabled by the BIOS, so
>> that they don't fire up until they are enabled by acpi_update_gpes().
>>
>> References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> ---
>>  drivers/acpi/acpica/evgpeinit.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/evgpeinit.c
>b/drivers/acpi/acpica/evgpeinit.c
>> index 2c7def9..4c8dea5 100644
>> --- a/drivers/acpi/acpica/evgpeinit.c
>> +++ b/drivers/acpi/acpica/evgpeinit.c
>> @@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
>>  		return_ACPI_STATUS(AE_OK);
>>  	}
>>
>> +	/* Disable the GPE in case it's been enabled already. */
>> +	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
>> +
>>  	/*
>>  	 * Add the GPE information from above to the gpe_event_info block for
>>  	 * use during dispatch of this GPE.
>>

