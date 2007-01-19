From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Fri, 19 Jan 2007 17:23:16 +0300
Message-ID: <45B0D454.5000808@linux.intel.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:44546 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964934AbXASOXX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 09:23:23 -0500
In-Reply-To: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pieter De Wit <Pieter.DeWit@vodacom.co.za>
Cc: linux-acpi@vger.kernel.org

Did you try patches from #5534 and #7122?

Pieter De Wit wrote:
> Hi Luming,
>
> This module was build into the kernel. After make it a module and mak=
ing
> sure it's not loaded, I still see the problem. Here is a more detaile=
d
> problem:
>
> If I leave ACPI to manage the system, thermal zone TZ4 stays around 8=
0
> C. The moment I turn on fan C318, this zone *shoots* up to 100 C and
> stays there, no matter what. This fan I can't turn off again.
>
> Here is a cat of fans, thermal_zone status and temp.
>
> status:                  on
> status:                  off
> status:                  on
> status:                  on
> status:                  on
> status:                  on
> status:                  on
> state:                   active[2]
> state:                   ok
> state:                   ok
> state:                   ok
> state:                   ok
> temperature:             65 C
> temperature:             61 C
> temperature:             54 C
> temperature:             30 C
> temperature:             100 C
>
> This was taken during the compile of gcc. While not doing anything, t=
he
> second zone drops to 54 C (currently at 61)
>
> Thanks for the time,
>
> Pieter
>
> -----Original Message-----
> From: Luming Yu [mailto:luming.yu@gmail.com]=20
> Sent: 2007/01/19 10:14
> To: Pieter De Wit
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: Fan speeds on HP nc6400 and nc8430
>
> Do you have psmouse module loaded ?
> (i.e. CONFIG_MOUSE_PS2=3Dm)
> If yes, Please try remove it, and re-test it.
>
> Thanks,
> Luming
>
> On 1/19/07, Pieter De Wit <Pieter.DeWit@vodacom.co.za> wrote:
>  =20
>> Hello List,
>>
>> I have noted that the fan speed on "idle" is much higher in Linux=20
>> compared to XP. I have also noted that once fans are turned on, they=
=20
>> never seem to return to the off state. I am currently using the 2.6.=
18
>>    =20
>
>  =20
>> kernel from Gentoo (gentoo-sources-r6). I was wondering if there is =
a=20
>> way I can lower the fan speed, or even assist the devs to get info=20
>> regarding these notebooks (if any is needed).
>>
>> Thanks,
>>
>> Pieter
>> "This e-mail is sent on the Terms and Conditions that can be accesse=
d
>>    =20
> by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
>  =20
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>    =20
> =93This e-mail is sent on the Terms and Conditions that can be access=
ed by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
