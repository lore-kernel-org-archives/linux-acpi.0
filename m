From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI spam
Date: Wed, 17 Mar 2010 05:21:57 +0300
Message-ID: <4BA03CC5.6000104@gmail.com>
References: <a36005b51003160819p21871af4t48a08a502afb67b5@mail.gmail.com> <201003162248.53820.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:42250 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab0CQCWA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2010 22:22:00 -0400
In-Reply-To: <201003162248.53820.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ulrich Drepper <drepper@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Ulrich,

Please check if EC is disabled in BIOS. If it does, enable it.
It could be masked by enable ACPI 2.0 or something like that.

Regards,
Alex

Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [CCing linux-acpi]
>
> On Tuesday 16 March 2010, Ulrich Drepper wrote:
>  =20
>> On one machine I've used using a recent kernel I see tons of message=
s like
>>
>> Mar 16 10:54:52 intel-d3cf1-01 kernel: ACPI Exception: AE_NOT_EXIST,
>> while evaluating GPE method [_L01] (20090903/evgpe-568)
>> Mar 16 10:54:53 intel-d3cf1-01 kernel: ACPI Error: No handler for
>> Region [ECF2] (ffff88013b69c978) [EmbeddedControl]
>> (20090903/evregion-319)
>> Mar 16 10:54:53 intel-d3cf1-01 kernel: ACPI Error: Region
>> EmbeddedControl(3) has no handler (20090903/exfldio-295)
>>
>> This is reported hundreds of times.
>>
>> Shouldn't these messages be rate-limited?  Aside from the reason bei=
ng fixed.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>    =20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
