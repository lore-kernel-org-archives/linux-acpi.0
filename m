From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Battery: Add sysfs support
Date: Tue, 18 Sep 2007 13:18:28 -0400
Message-ID: <200709181318.28690.lenb@kernel.org>
References: <20070913145714.23813.91351.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49388 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765AbXIRRSp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 13:18:45 -0400
In-Reply-To: <20070913145714.23813.91351.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday 13 September 2007 10:57, Alexey Starikovskiy wrote:
> From: Alexey Starikovskiy <astarikivskiy@suse.de>
> 
> Refer to Documentation/power_supply_class.txt for interface description.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/battery.c |  201 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 179 insertions(+), 22 deletions(-)


< +#ifdef CONFIG_ACPI_PROC
---
> +#ifdef CONFIG_ACPI_PROCFS

yes, this is an improvement over the last one.

thanks,
-Len
