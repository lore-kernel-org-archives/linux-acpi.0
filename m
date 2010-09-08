From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Fan runs full speed after S3 sometimes (regression)
Date: Wed, 08 Sep 2010 15:27:00 +0200
Message-ID: <4C878F24.9010004@gmail.com>
References: <4C613619.30309@gmail.com> <4C619CF0.30609@gmail.com> <20100820063107.GB1607@ucw.cz> <4C6E233A.5000209@gmail.com> <20100821170551.GA27159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56545 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0IHN1F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Sep 2010 09:27:05 -0400
In-Reply-To: <20100821170551.GA27159@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Hi.

On 08/21/2010 07:05 PM, Pavel Machek wrote:
>>>>> I don't know how to debug that. Bisection is out of question -- it
>>>>> happens once in 10 or 20 cases. There are no fan entries in /sys.
>>>
>>> Well, doing 20 suspends in a row from a script should not be too bad.
>>
>> 20 is just a guess. I haven't seen it for pretty few days until the day
>> before yesterday. And it looks like CPU1 is brought up a half way. When
>> the fan was at full speed I tried:
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> and whole system freezed. Otherwise this commands succeeds.
> 
> Ok, so this looks like the kernel problem, on the other hand. Two
> different problems?

Actually, I haven't seen it after an upgrade to the next -mm kernel.
Consider it as closed as WORKSFORME for now.

thanks anyway,
-- 
js
