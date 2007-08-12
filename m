From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: AC: add sysfs support
Date: Sat, 11 Aug 2007 23:45:11 -0400
Message-ID: <200708112345.11948.lenb@kernel.org>
References: <46BE1494.2070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57788 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbXHLDup (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2007 23:50:45 -0400
In-Reply-To: <46BE1494.2070305@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 11 August 2007 15:57, Alexey Starikovskiy wrote:
> +#if defined(CONFIG_POWER_SUPPLY) || defined(CONFIG_POWER_SUPPLY_MODULE)
> +#define ENABLE_POWER_SUPPLY
> +#include <linux/power_supply.h>
> +#endif

sort of unfortunately to then have the #ifdef ENABLE_POWER_SUPPLY
sprinkled throughout the code, though I don't immediately see
a cleaner way to do it....
