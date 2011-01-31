From: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Mon, 31 Jan 2011 11:29:51 +0100
Message-ID: <4D468F1F.8030704@t-online.de>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311050.49722.rjw@sisk.pl> <4D468CF0.9040103@t-online.de> <201101311123.14704.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout08.t-online.de ([194.25.134.20]:43965 "EHLO
	mailout08.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab1AaKaD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 05:30:03 -0500
In-Reply-To: <201101311123.14704.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

>>>> I'll compile a kernel with CONFIG_NO_HZ to see what happens but ho=
w do I
>>>> disable cpuidle during boot? I've checked the kernel-parameters.tx=
t but
>>>> there's no cpuidle related boot parameter there.
>>>
>>> Booting with intel_idle.max_cstate=3D0 should do the trick.
>>
>> intel_idle.max_cstate=3D0 causes a fallback to the acpi_idle driver.=
 So it
>> does not disable the C-states directly.
>
> What about not building the acpi_idle driver, then?

Or just use the processor.max_cstate parameter then.

--=20
Regards,
Richard Sch=C3=BCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
