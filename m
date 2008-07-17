From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 3/4]  ACPI: Add "acpi.power_nocheck=1" to disable power
 state check in power transitio
Date: Thu, 17 Jul 2008 14:48:24 +0200
Message-ID: <487F3F98.8000305@firstfloor.org>
References: <1216021174.32159.22.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:55570 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYGQMs0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 08:48:26 -0400
In-Reply-To: <1216021174.32159.22.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org


As a general  comment I wonder if this problem is really wide spread enough
to deserve an own command line option or if that could be just done
with quirks.

> --- linux-2.6.orig/drivers/acpi/power.c
> +++ linux-2.6/drivers/acpi/power.c
> @@ -54,6 +54,14 @@ ACPI_MODULE_NAME("power");
>  #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
>  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
>  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif

How can MODULE_PARAM_PREFIX be set here?

-Andi
