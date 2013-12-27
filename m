From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Fri, 27 Dec 2013 04:58:48 +0000
Message-ID: <20131227045848.GB21429@srcf.ucam.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44980 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3L0E6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Dec 2013 23:58:50 -0500
Content-Disposition: inline
In-Reply-To: <1387239401-13918-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Mon, Dec 16, 2013 at 05:16:37PM -0700, al.stone@linaro.org wrote:

> +config ACPI_REDUCED_HARDWARE
> +	bool "Hardware-reduced ACPI support"
> +	depends on ARM || ARM64
> +	help
> +	This config adds support for Hardware-reduced ACPI.

Well, that's not really true - most of the hardware-reduced ACPI support 
seems to be built even if this isn't turned on. Maybe 
ACPI_REDUCED_HARDWARE_ONLY ?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
