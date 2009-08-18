From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/3] Add rfkill support to compal-laptop
Date: Tue, 18 Aug 2009 13:22:33 +0100
Message-ID: <9b2b86520908180522o1da2c821jf803f66264424fe@mail.gmail.com>
References: <4A89E768.7010207@dell.com>
	 <9b2b86520908180119m40b6c4b0se8ff7cea7776085b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:59404 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbZHRMWd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 08:22:33 -0400
In-Reply-To: <9b2b86520908180119m40b6c4b0se8ff7cea7776085b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, cezary.jackiewicz@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/18/09, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
> On 8/18/09, Mario Limonciello <mario_limonciello@dell.com> wrote:
>> In order to be useful in modern kernels and standard interfaces,
>> compal-laptop should have rfkill support.  This patch adds it.
>> --
>> Mario Limonciello
>> *Dell | Linux Engineering*
>> mario_limonciello@dell.com
>>
>
> I have some comments of my own as well, so here goes.
>
>> +static void compal_rfkill_query(struct rfkill *rfkill, void *data)
>> +{
>> +	unsigned long radio = (unsigned long) data;
>> +	u8 result;
>> +	bool blocked;
>> +
>> +	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>> +
>> +	if ((result & KILLSWITCH_MASK) == 0)
>> +		blocked = 1;
>
>> +        else if (radio == WLAN_MASK)
>> +		blocked = !(result & WLAN_MASK);
>> +	else
>> +		blocked = !((result & BT_MASK) >> 1);
>
> Ick, this is overdone.  You should just be able to do
>
> +	else
> +		blocked = !(result & radio);
>
>> +	rfkill_set_sw_state(rfkill,blocked);
>> +	rfkill_set_hw_state(rfkill,0);
>
> This last line is redundant.  The HW state will default to "unblocked"
> if you never set it.
>
>> +static int compal_rfkill_set(void *data, bool blocked)
>> +{
>> +	unsigned long radio = (unsigned long) data;
>> +	u8 result, value;
>> +
>> +	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>> +
>> +	if ((result & KILLSWITCH_MASK) == 0)
>> +		return -EINVAL;
>> +	else {
>> +		if (!blocked)
>> +			value = (u8) (result | radio);
>> +		else
>> +			value = (u8) (result & ~radio);
>> +		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
>> +	}
>> +
>> +	return 0;
>> +}
>
> Note that the return value of rfkill_set is not propagated to
> userspace through the /dev/rfkill interface.
>
> The way you use "KILLSWITCH_MASK", it looks like a hard rfkill bit
> that covers all radios.  Why don't you report it as a hard block on
> each rfkill device?

P.S.  If you do this, you probably also want to set up polling.  I
think you should be able to reuse the query() function for the poll()
method (but you should check yourself whether that makes sense).

Thanks again
Alan
