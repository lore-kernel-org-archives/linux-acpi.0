From: mihn leigh <mihnsk@gmail.com>
Subject: Re: cpu voltage change question
Date: Thu, 27 Jan 2011 10:39:39 -0800
Message-ID: <AANLkTimrrD+mgwMMcqBNoZgOXfipG+XoCDGKVWOxYbRC@mail.gmail.com>
References: <1296119453.4653.1.camel@genix>
	<4D41996C.1060600@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56696 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1A0Sjl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2011 13:39:41 -0500
Received: by wwa36 with SMTP id 36so2485172wwa.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2011 10:39:39 -0800 (PST)
In-Reply-To: <4D41996C.1060600@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

Yes, you're right. As you said, MSR register contains the frequency
and voltage information of cpu. By writing the register, we can change
voltage as well (it's the information from intel datasheet). But, i
cannot find the detail of this register.

BTW, what's the reason that MSR register can not be changed in OS
level? is it only possible to change in BIOS?

Thanks.

2011/1/27 Phillip Susi <psusi@cfl.rr.com>:
> On 1/27/2011 4:10 AM, mihn wrote:
>> Hi,
>>
>> I want to change voltage and frequency seperately.
>> With cpu-freq, i can change frequency, but cannot change voltage AFA=
IK.
>
> The voltage is controlled by the platform and should already be set t=
o a
> level appropriate for that frequency. =A0AFAIK, recent intel cpus hav=
e
> MSRs that configure the voltage for each P-state, but these are set u=
p
> by the bios and shouldn't need changed.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
