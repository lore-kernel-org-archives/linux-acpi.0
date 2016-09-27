From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: ARM juno R2 board USB Issue (EHCI probe failed)
Date: Tue, 27 Sep 2016 18:01:13 +0100
Message-ID: <1cac4b9b-b096-4592-e3df-94ade8848f07@arm.com>
References: <AT5PR84MB005284C92DEA45ADF67A4F55D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
 <CAGm_ybhc4DKYkDtE8dVzhC3-kJk138Lbm-zAhepQiyUnuqZQHg@mail.gmail.com>
 <22e151c5-fc83-a48c-b130-f633fac8674f@arm.com>
 <AT5PR84MB00524ACD87B9FF61AAB55223D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
 <37a463cb-86d5-e0d7-7e8f-50cec3d65c95@arm.com> <57EA9AAA.5090504@linaro.org>
 <9b231601-2c6a-a5d7-471f-4fc0d8190d83@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936238AbcI0RB2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Sep 2016 13:01:28 -0400
In-Reply-To: <9b231601-2c6a-a5d7-471f-4fc0d8190d83@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>, Vikas Sajjan <sajjan.linux@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>



On 27/09/16 17:23, Robin Murphy wrote:
> On 27/09/16 17:13, Hanjun Guo wrote:
>> On 09/27/2016 05:07 PM, Sudeep Holla wrote:

[...]

>>>>
>>>> As I mentioned in private, I do get the same error if I drop _CCA in
>>>> USB object of ACPI DSDT. Can you give it a spin with latest UEFI ?
>>>>
>>>> Sure, will try with latest UEFI.
>>>>
>>>
>>> I bet that's 8-12 months old. It puts the banner during boot with the
>>> build date. You can try to follow [1] or access it from [2]
>>
>> Agree.
>>
>> D03 is using the same IP (EHCI) and the USB works fine with _CCA
>> in the device node.
>
> _CCA is mandatory on arm64 (see CONFIG_ACPI_CCA_REQUIRED). Any devices
> without it are going to end up with the dummy DMA ops which
> intentionally fail if a driver tries to use them - i.e. the error seen
> above is by design.
>

Yes that was the first thing I thought and gave it try with _CCA removed
in ACPI DSDT on my Juno R2. It so happens that we did ship it some
*custom* UEFI until Linaro 16.02 in which upstream EDK2 was merged :(

Since Vikas was trying boot out of USB, I didn't suggest him to take a
acpidump on Juno and confirm this by looking at the DSDT. Also I could
find a commit from Leif that adds _CCA to USB in OpenPlatformPkg to
confirm this.

-- 
Regards,
Sudeep
