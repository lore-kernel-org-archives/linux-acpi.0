From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/20] ARM64 / ACPI: Use Parked Address in GIC structure for spin table SMP initialisation
Date: Fri, 17 Jan 2014 15:15:20 +0100
Message-ID: <201401171515.21250.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62383 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbaAQOPm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 09:15:42 -0500
In-Reply-To: <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com

On Friday 17 January 2014, Hanjun Guo wrote:
> +/* Parked Address in ACPI GIC structure */
> +static u64 parked_address[NR_CPUS];

Please use the per_cpu infrastructure rather than NR_CPUS long arrays.

	Arnd
