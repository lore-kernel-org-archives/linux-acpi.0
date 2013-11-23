From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Fri, 22 Nov 2013 17:05:48 -0700
Message-ID: <528FF15C.4060300@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <528F9C65.7010302@linaro.org> <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com> <4285284.l8TssFvumi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37382 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab3KWAFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 19:05:50 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so3240434ieb.22
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 16:05:50 -0800 (PST)
In-Reply-To: <4285284.l8TssFvumi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robherring2@gmail.com>, linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On 11/22/2013 04:15 PM, Rafael J. Wysocki wrote:
> On Friday, November 22, 2013 10:53:09 AM Olof Johansson wrote:
>> On Fri, Nov 22, 2013 at 10:03 AM, Al Stone <al.stone@linaro.org> wrote:
>>> On 11/22/2013 06:25 AM, Rob Herring wrote:
>>>>
>>>> On Thu, Nov 21, 2013 at 6:41 PM,  <al.stone@linaro.org> wrote:
>>>>>
>>>>> From: Al Stone <al.stone@linaro.org>
>>>>>
>>>>> Modified #ifdef so that DMI is not used on ARM platforms which
>>>>> are currently implementing ACPI reduced HW mode.
>>>>
>>>>
>>>> It is really not allowed or is optional? There are various people that
>>>> want DMI tables on ARM.
>>>>
>>>> Rob
>>>
>>>
>>> True.  DMI is optional.  I see it as orthogonal to
>>> reduced HW mode; I have to hope that when DMI patches
>>> are forthcoming they'll do the right thing here.
>>>
>>> Is there a better way to do this in the #if ?
>>
>>
>> Doing all of these things at compile time seems odd, shouldn't it be
>> handled at runtime? What happens when someone wants to build a kernel
>> that boots both on the reduced hw mode platforms and regular ones?
>
> I agree.
>
> My suggestion would be to harden dmi_check_system() so that it works
> if DMI is not present (if it doesn't already).
>
> Thanks!
>

I agree -- runtime would be better.  For dmi_check_system(), that
can be done and I'll look into that.  I'll also go double check the
rest of my #ifdefs and see if I can remove any more of them from the
Linux side of the ACPI code.

For reduced hardware mode, however, I have to rely on the underlying
ACPICA reference implementation to behave properly.  Right now, ACPICA
relies on compile time changes to implement either reduced HW mode or
legacy mode so I have to follow suit.  When I looked at making ACPICA
change behavior at runtime, the changes became more and more invasive.
Since x86/ia64 depend on ACPICA to behave also, that seemed a far more 
dangerous approach to me.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
