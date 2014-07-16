From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/3] Clean up ACPI core to prepare for running ACPI
 on ARM64
Date: Wed, 16 Jul 2014 16:39:41 -0700
Message-ID: <53C70D3D.8080605@zytor.com>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org> <2351210.nfpIXXiZXh@vostro.rjw.lan> <3908561D78D1C84285E8C5FCA982C28F3285FA2B@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47087 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbaGPXkW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 19:40:22 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F3285FA2B@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, 'Ingo Molnar' <mingo@kernel.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "x86@kernel.org" <x86@kernel.org>

On 07/16/2014 04:28 PM, Luck, Tony wrote:
>> Are there any objections against this series from the x86 and ia64 maintainers?
> 
> I'll believe the claim of no functional changes for ia64 ... so no objections from me.
> 
> -Tony
> 

No objection here, modulo the issue I just flagged (which is
IA64-related, not x86, so Tony is the one who actually needs to decide it.)

	-hpa

