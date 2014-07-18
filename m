From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 1/3] ACPI: ARM64 does not have a BIOS add config for
 BIOS table scan.
Date: Fri, 18 Jul 2014 17:22:27 +0800
Message-ID: <53C8E753.4070509@linaro.org>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org> <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org> <53C70CCC.2080109@zytor.com> <3908561D78D1C84285E8C5FCA982C28F3285FB3C@ORSMSX114.amr.corp.intel.com> <53C70F78.40206@zytor.com> <53C7406E.40902@linaro.org> <3908561D78D1C84285E8C5FCA982C28F32866139@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63592 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbaGRJXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jul 2014 05:23:30 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so4673109pdj.7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jul 2014 02:23:30 -0700 (PDT)
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32866139@ORSMSX113.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 2014-7-18 0:58, Luck, Tony wrote:
>> Tony, if it is ok with you, I will modify the patch and will not select
>> ACPI_LEGACY_TABLES_LOOKUP on IA64, I'm waiting for your final confirmation.
> 
> Confirmed.  Thanks Peter for catching this.

Great, I will update the patch and send out soon.

Thanks
Hanjun

