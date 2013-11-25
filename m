From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Mon, 25 Nov 2013 10:43:27 -0700
Message-ID: <52938C3F.20905@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <528F9C65.7010302@linaro.org> <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com> <4285284.l8TssFvumi@vostro.rjw.lan> <528FF15C.4060300@linaro.org> <20131123163854.GA1817@srcf.ucam.org> <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com> <20131125153016.GA3243@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39317 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab3KYRna (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 12:43:30 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so7262898iec.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 09:43:29 -0800 (PST)
In-Reply-To: <20131125153016.GA3243@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 11/25/2013 08:30 AM, Matthew Garrett wrote:
> On Mon, Nov 25, 2013 at 05:10:46AM +0000, Zheng, Lv wrote:
>>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Matthew Garrett
>>> Ugh. Really? People have been fairly careful about making sure that the
>>> x86 SoC code is selected correctly at runtime, and losing that because
>>> ACPICA is broken would be a shame. I think this is something that needs
>>> to support runtime switching even if there's also support for building
>>> kernels that only implement the reduced hardware profile.
>>
>> If my reading is correct, do you mean x86 SoCs should have already tested the code.
>
> I don't know if anyone has deployed x86 SoCs with reduced hardware yet,
> but it seems like something that might happen.
>
>> So if ARM need ACPI_REDUCED_HARDWARE to be defined, the <include/acpi/platform/aclinux.h> should have lines like:
>> #ifdef CONFIG_ARCH_IS_ACPI_REDUCED_HARDWARE
>> #define ACPI_REDUCED_HARDWARE TRUE
>> #endif
>> And ARCH_IS_ACPI_REDUCED_HARDWARE should only be selected by CONFIG_ARM.
>
> Is ACPI_REDUCED_HARDWARE supposed to indicate support for the reduced
> hardware profile, or that the platform *only* implements the reduced
> hardware profile?
>

 From what I can see in ACPICA, ACPI_REDUCED_HARDWARE indicates the
platform *only* implements the reduced hardware profile.  This *seems*
to be consistent with the specification -- see 3.11.1, second bullet,
for example:

    Boot in ACPI mode only (ACPI Enable, ACPI Disable, SMI_CMD and
    Legacy mode are not supported)

...if by "not supported" one takes that to mean "does not exist when
compiled."  I can look at the ACPICA code again, just the same; perhaps
there is some reasonable way to at least select one or the other at boot
as the first step, and then allow switching between modes as a later
step.

To Lv's point, since hardware reduced mode was added in ACPI 5.0, I
don't think there has been a lot of exposure to it, especially on
working platforms on the Linux side, so I doubt there has been any
significant Linux testing of it until now.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
