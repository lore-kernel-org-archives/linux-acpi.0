From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Tue, 02 Oct 2012 13:14:41 +0200
Message-ID: <506ACCA1.6030908@redhat.com>
References: <5069E332.9060109@redhat.com> <506AB25D.7000900@hundeboll.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab2JBLNV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Oct 2012 07:13:21 -0400
In-Reply-To: <506AB25D.7000900@hundeboll.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

On 10/02/2012 11:22 AM, Martin Hundeb=C3=B8ll wrote:
> Hi Hans,
>
> On 2012-10-01 20:38, Hans de Goede wrote:
>> 2) Even with a 3.6 which shows the problematic behavior, I can
>> make things work by adding acpi.ec_delay=3D2000 to the kernel cmdlin=
e,
>> the debug traces show that the EC takes it sweet time to respond
>> (sometime close to 2 seconds) but it does eventually respond in all
>> cases I've seen sofar.
>>
>> This also seems to fix a sporadic occurence of:
>> "ACPI: EC: input buffer is not empty aborting transaction"
>> Which I'm seeing with 3.5 / 3.6 in a non debug build.
>>
>> Martin, can you see if adding that helps you with the E5430 problems
>> too ?
>
> As far as I can tell from the attached dmesg, the errors are gone aft=
er setting acpi.ec_delay=3D2000. Thanks a lot!
>
> The only remaining issue is the fan control, which works as expected =
initially, but then fails to spin down after a few minutes.

Hmm, I'm seeing the same thing, but only when charging my battery, and =
then indeed
does not spin down completely, but it does step down from vacuum cleane=
r mode to
something more pleasant after the machine was loaded for a while and re=
turns back
to idle.

Also it spins up to its slowest speed by jut using the charger, so I th=
ink it is
just bleeding of heat caused by the charging hardware in this case (for=
 me).

 > Is this ACPI related?

That could be the case.

> And if so, please instruct me how to debug further.

I'm afraid I cannot help there, maybe someone else on the list can ...

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
