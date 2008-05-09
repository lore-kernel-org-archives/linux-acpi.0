From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Fri, 9 May 2008 10:40:36 -0700
Message-ID: <200805091040.37139.jbarnes@virtuousgeek.org>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com> <1210297604.8716.5.camel@sli10-desk.sh.intel.com> <482400B3.4020808@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-152.bluehost.com ([67.222.39.32]:40092 "HELO
	outbound-mail-152.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754125AbYEIRrX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2008 13:47:23 -0400
In-Reply-To: <482400B3.4020808@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday, May 09, 2008 12:43 am Kenji Kaneshige wrote:
> -static u32 ctrlset_buf[3] = {0, 0, 0};
> -static u32 global_ctrlsets = 0;
> +#define MAX_ACPI_OSC 30 /* Should be enough */
> +static struct acpi_osc_data {
> +	acpi_handle handle;
> +	u32 ctrlset_buf[3];
> +	u32 global_ctrlsets;
> +} acpi_osc_data_array[MAX_ACPI_OSC];

Could this just be a linked list of OSC objects instead?

Jesse
