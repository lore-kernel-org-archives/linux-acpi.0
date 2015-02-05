From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 11/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
Date: Thu, 05 Feb 2015 17:48:37 +0800
Message-ID: <54D33C75.8030405@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-12-git-send-email-hanjun.guo@linaro.org> <20150204164328.GF22035@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48590 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808AbbBEJsr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 04:48:47 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so9019468pad.4
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 01:48:47 -0800 (PST)
In-Reply-To: <20150204164328.GF22035@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>

On 2015=E5=B9=B402=E6=9C=8805=E6=97=A5 00:43, Lorenzo Pieralisi wrote:
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
> So you do rely on a global FADT being available, if you use it for PS=
CI
> detection you can use it for ACPI revision detection too, right ?

Yes, I think so.

>
> Point is, either we should not use the global FADT table, or we use
> it consistently, or there is something I am unaware of that prevents
> you from using in some code paths and I would like to understand
> why.

global FADT table is initialized when parsing the tables from RSDP in
ACPICA core, and it should be work on ARM64 too.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
