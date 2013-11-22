From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Fri, 22 Nov 2013 10:53:09 -0800
Message-ID: <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
	<1385080915-23430-5-git-send-email-al.stone@linaro.org>
	<CAL_JsqKbL2Zhpbg8wp4qZekZwJO20njUO4nCzzz1KZexmK9tLQ@mail.gmail.com>
	<528F9C65.7010302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:37627 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab3KVSxK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 13:53:10 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so750278qac.13
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 10:53:10 -0800 (PST)
In-Reply-To: <528F9C65.7010302@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On Fri, Nov 22, 2013 at 10:03 AM, Al Stone <al.stone@linaro.org> wrote:
> On 11/22/2013 06:25 AM, Rob Herring wrote:
>>
>> On Thu, Nov 21, 2013 at 6:41 PM,  <al.stone@linaro.org> wrote:
>>>
>>> From: Al Stone <al.stone@linaro.org>
>>>
>>> Modified #ifdef so that DMI is not used on ARM platforms which
>>> are currently implementing ACPI reduced HW mode.
>>
>>
>> It is really not allowed or is optional? There are various people that
>> want DMI tables on ARM.
>>
>> Rob
>
>
> True.  DMI is optional.  I see it as orthogonal to
> reduced HW mode; I have to hope that when DMI patches
> are forthcoming they'll do the right thing here.
>
> Is there a better way to do this in the #if ?


Doing all of these things at compile time seems odd, shouldn't it be
handled at runtime? What happens when someone wants to build a kernel
that boots both on the reduced hw mode platforms and regular ones?


-Olof
