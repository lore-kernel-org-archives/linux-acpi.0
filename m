From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot support
Date: Thu, 22 Jan 2015 20:46:43 +0800
Message-ID: <54C0F133.8060901@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org> <54B8F2E3.80306@arm.com> <CACxGe6tBb8L8upS3zenZbrOc_c0E=MA=DqLjkSezEbregaAaaA@mail.gmail.com> <54B92245.6080306@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35542 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbAVMq6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2015 07:46:58 -0500
Received: by mail-pd0-f182.google.com with SMTP id z10so1462025pdj.13
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2015 04:46:57 -0800 (PST)
In-Reply-To: <54B92245.6080306@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Grant Likely <grant.likely@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, linux-acpi@vger

Hi Marc,

We (Tomasz, Suravee and me) are working on supporting stacked domain on
ACPI, and rework GIC ACPI related patch, before we going further, we
need your guidance to see if we are going the right direction.

   - You said that we spread GIC related code every where, so how
     about put all the ACPI related GIC init code in one file under
     drivers/irqchip/ with name irq-gic-acpi.c?

   - ACPI only support one GICD for now, so we assume that there
    only one gicv2/v3 core domain and every device not using MSI
     will refer to that irqdomain in default.

Are we going the right direction?

Thanks
Hanjun
