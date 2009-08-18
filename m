From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/3] Add rfkill support to compal-laptop
Date: Tue, 18 Aug 2009 09:33:03 +0100
Message-ID: <9b2b86520908180133r3f5ddd7ev8a345832f2785abc@mail.gmail.com>
References: <4A89E768.7010207@dell.com>
	 <1250558643.30166.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:36253 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbZHRIdD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 04:33:03 -0400
In-Reply-To: <1250558643.30166.109.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, cezary.jackiewicz@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/18/09, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mario,

...

>> +static void compal_rfkill_query(struct rfkill *rfkill, void *data)
>> +{
>> +       unsigned long radio = (unsigned long) data;
>> +       u8 result;
>> +       bool blocked;
>> +
>> +       ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>> +
>> +       if ((result & KILLSWITCH_MASK) == 0)
>> +               blocked = 1;
>> +        else if (radio == WLAN_MASK)
>> +               blocked = !(result & WLAN_MASK);
>
> You are using spaces instead of tabs here.

Btw Mario, scripts/checkpatch.pl is a good way to check for whitespace
errors and a bunch of other trivia.  So human patch review can
concentrate on the important stuff :-).

Thanks
Alan
