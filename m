Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28664;
	Fri, 21 Aug 2026 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349621; cv=none; b=N3cSV/2yKM+Z3Ja7IQkV/nGMHMXGOY64QPU/OhOqVhVQiZfZOA+8ty01W4nFio53ealCQehy276c6db+QKpE0/kVo2kl66YLDTVANL02gItkbrUAw9kWDfgPOzMDGO/nWMqxLz0YwipPmQfQdhFqwp2N6/QrFPignh4gWUSosns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349621; c=relaxed/simple;
	bh=C9lyqQL2gR8JG0O76COff55Wax7NXCLXnnFi3u4A26w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv/Db9yjzYy5PfL2++IAZAaqBTAxU2kRiU8o9rfRyJ6XEM7idEBeodnRKxxTS3Es6IpjQCyxBASjU7p2bZYTL3qJbf2snEbzrlZJkFBLlhQF+UioeIffeZ5Hl4AJpLnH7sYo5jDmK235UQ28N6vpkEm9WFov+FYhghix7kc/xMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHpodfAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHpodfAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79B81F00A3A;
	Fri, 21 Aug 2026 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349619;
	bh=t2AJLr3PEYZ4xN2XziYZu5Jr67vAyQ7rQz3dghKzCow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cHpodfAz+Uyi9kLTKbJrD8UGbQkY6kmkAJJlgJ5Y2nle6VKX8ohLnrGvc+fzujACt
	 K+/oAmI4ZV1vBR7Y4vTRbEaXD+fZhwmmLnyHX4oOsMau0ppHNd3YIrTnnv5EHKS171
	 dR58xZriodNoSMovQNSIjMb0JCh3zMCIAsOo4De6JHpzp2T/tERbtnqbWQc4RyXm+T
	 3Y79Bqcl9i95niPG9ZFntpulLBcYwvp/0ae01BX+7Xopb6ESoQPC1W6c21YgbwJGkZ
	 2/Vb6yON330b8mUsLjRALkywRJnQTCMiM1i4FJ/kEU7FrWFRmUjKigxYBhuZmrC+Or
	 QodW/ZHBHvaPg==
Message-ID: <0f5e0efc-b856-4fb8-8b1a-e98f3061192e@kernel.org>
Date: Fri, 21 Aug 2026 17:00:17 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook
 UX425UA_UM425UA
Content-Language: en-US
To: Aviv <vaknins33@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821070651.39763-1-vaknins33@gmail.com>
 <52e55283-f628-4a85-851b-fe33dcdd9c47@amd.com>
 <CAMpL-YwbRe7A+wLxi9gi=q7VuufHtaoLDiLTm1fe_jK7J3D8Ww@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAMpL-YwbRe7A+wLxi9gi=q7VuufHtaoLDiLTm1fe_jK7J3D8Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/21/26 16:46, Aviv wrote:
> Hi Mario,
> 
> Nothing is physically connected to GPP3. The bridge (00:02.1 /
> \_SB.PCI0.GPP3) is unpopulated on this board (the ZenBook UX425UA has
> no Ethernet or secondary PCIe devices there).
> 
> The DSDT seems to have leftover definitions for RTL8/RUSB on GPP3 from
> a shared BIOS base, and routes GPIO pin 24 to it in _EVT, causing
> phantom wake events during s2idle.
> 
> Here is the acpidump:
> https://gist.github.com/vaknin/142f5cbad15958e9025cd81960114f6e
> 
> Thanks,
> Kivan

Thanks.  The dump agrees with your assessment.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>>
> 
> On Fri, Aug 21, 2026 at 11:49 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> What is connected to this GPP3?
>>
>> Can you please share your acpidump somewhere?
>>
>> On 8/21/26 02:06, Kivan wrote:
>>> The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
>>> to stay suspended in s2idle (Modern Standby), prematurely waking
>>> after 1-3 seconds with 0% hardware sleep achieved.
>>>
>>> In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
>>> defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
>>> \_SB.PCI0.GPP3:
>>>
>>>       GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
>>>                "\\_SB.GPIO", ...) { 0x0018 }
>>>
>>> When the SoC powers down PCIe root ports into low-power states during
>>> s2idle, an electrical edge transition triggers a spurious wake interrupt
>>> on GPIO Pin 24. This signals the AMD GPIO controller (AMDI0030:00 / IRQ 7
>>> via pinctrl_amd), aborting sleep across the system.
>>>
>>> Booting with kernel parameter "gpiolib_acpi.ignore_wake=AMDI0030:00@24"
>>> completely resolves the issue: amd_gpio reports ignoring the wakeup on
>>> pin 24, and interrupt counts in /proc/interrupts remain at 0 during sleep
>>> cycles, allowing uninterrupted s2idle until intentionally woken by the
>>> user.
>>>
>>> Add a DMI quirk entry to ignore wake events on AMDI0030:00@24 for this
>>> system.
>>>
>>> Signed-off-by: Kivan <vaknins33@gmail.com>
>>> ---
>>>    drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
>>> index a0116f0..dd4db58 100644
>>> --- a/drivers/gpio/gpiolib-acpi-quirks.c
>>> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
>>> @@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>>>                        .ignore_wake = "VEN_0488:00@355",
>>>                },
>>>        },
>>> +     {
>>> +             /*
>>> +              * Spurious wakeups from GPP3 PCIe bridge interrupt
>>> +              * Found in BIOS UX425UA.301
>>> +              */
>>> +             .matches = {
>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA_UM425UA"),
>>> +             },
>>> +             .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>> +                     .ignore_wake = "AMDI0030:00@24",
>>> +             },
>>> +     },
>>>        {} /* Terminating entry */
>>>    };
>>>
>>

