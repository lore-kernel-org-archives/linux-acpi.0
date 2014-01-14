From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to enforce this ACPI mode
Date: Tue, 14 Jan 2014 22:26:21 +0100
Message-ID: <15081767.3kxW799CSQ@wuerfel>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54030 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbaANV0s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 16:26:48 -0500
In-Reply-To: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: al.stone@linaro.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-acpi@lists.linaro.org

On Tuesday 14 January 2014 13:37:02 al.stone@linaro.org wrote:
> +config ACPI_REDUCED_HARDWARE_ONLY
> +       bool "Hardware-reduced ACPI support only"
> +       def_bool n
> +       depends on ACPI && EXPERT

I think this will cause a Kconfig warning if you try to select this
on ARM64 without turning on EXPERT as well. 

It should be ok if you express it as

config ACPI_REDUCED_HARDWARE_ONLY
       bool "Hardware-reduced ACPI support only" if EXPERT
       def_bool n
       depends on ACPI


	Arnd
