From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 17 Jan 2014 15:21:35 +0100
Message-ID: <201401171521.35940.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50019 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaAQOVn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 09:21:43 -0500
In-Reply-To: <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Amit Daniel Kachhap <amit.daniel@samsung.com>

On Friday 17 January 2014, Hanjun Guo wrote:
> 
> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> name from the ACPI timer table is matched with all the registered
> timer controllers and matching initialisation routine is invoked.

I wouldn't anticipate this infrastructure to be required. Shouldn't all
ARMv8 machines have an architected timer?

	Arnd
