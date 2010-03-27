From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: how to debug a kernel that does not power off?
Date: Fri, 26 Mar 2010 19:47:52 -0600
Message-ID: <4BAD63C8.6070401@gmail.com>
References: <4BA9525E.9000701@maroy.hu> <201003262056.11231.arnout@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:50146 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0C0Br7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Mar 2010 21:47:59 -0400
In-Reply-To: <201003262056.11231.arnout@mind.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnout Vandecappelle <arnout@mind.be>
Cc: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>, Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On 03/26/2010 01:56 PM, Arnout Vandecappelle wrote:
>   Take a look at the pm_power_off functions in arch/x86/kernel/apm_32=
=2Ec
>
>   Regards,
>   Arnout

Any modern machine will be using ACPI functions to power off, not APM..=
=20
CCing the linux-acpi list.

>
> On Wednesday 24 March 2010 00:44:30, =C1kos Mar=F3y wrote:
>> Hi,
>>
>> This might be a lame question, but: how would I debug a kernel that
>> simply does not power off a machine? When powering off, on the conso=
le I
>> get to the message: [...] Poweroff.
>>
>> but then, the machine actually does not power off. This is an HP Env=
y 15
>> laptop using an intel i7 CPU, and kernel 2.6.32.9.
>>
>> I tried to read up on all sorts of documentation, but could not get =
more
>> debug info out of the kernel :(
>>
>> any pointers would be welcome..
>>
>>
>> Akos
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
