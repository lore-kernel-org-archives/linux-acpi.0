From: Al Stone <al.stone@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v8 11/21] ARM64 / ACPI: Get PSCI flags in
 FADT for PSCI init
Date: Thu, 05 Feb 2015 10:11:31 -0700
Message-ID: <54D3A443.7050303@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-12-git-send-email-hanjun.guo@linaro.org> <20150204164328.GF22035@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36313 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757686AbbBERLf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 12:11:35 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so14818583igb.5
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 09:11:34 -0800 (PST)
In-Reply-To: <20150204164328.GF22035@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>"Rafael J. Wysocki" <r>

On 02/04/2015 09:43 AM, Lorenzo Pieralisi wrote:
> On Mon, Feb 02, 2015 at 12:45:39PM +0000, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
>> the former signals to the OS that the firmware is PSCI compliant.
>> The latter selects the appropriate conduit for PSCI calls by
>> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
>> (SMC).
>>
>> FADT table contains such information in ACPI 5.1, FADT table was
>> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
>> use the flags in struct acpi_gbl_FADT for PSCI init.
> 
> So you do rely on a global FADT being available, if you use it for PSCI
> detection you can use it for ACPI revision detection too, right ?
> 
> Point is, either we should not use the global FADT table, or we use
> it consistently, or there is something I am unaware of that prevents
> you from using in some code paths and I would like to understand
> why.

The FADT is a required table for arm64, as noted in the documentation
and the SBBR.  While unfortunately the spec does not say it is mandatory,
even x86 systems are pretty useless without it.  So yes, we rely on it
being available, not only for the PSCI info, but other flags such as
HW_REDUCED_ACPI.

I suppose it does not have to be globally scoped.  However, the FADT is
frequently used, especially on x86, so it makes sense to me from an
efficiency standpoint to have a global reference to it.

I'm not sure I understand what is meant by using FADT for ACPI revision
detection; there are fields in the FADT that provide a major and minor
number for the FADT itself, but I don't believe there's any guarantee
those will be the same as the level of the specification that is being
supported by the kernel (chances are they will, but it's not mandatory).

I've probably just missed a part of a thread somewhere; could you point
me to where the inconsistency lies?  I'm just not understanding right this
second....

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
