From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] ACPI: Support D3 COLD device in old BIOS for ZPODD
Date: Thu, 10 Dec 2015 00:07:27 +0100
Message-ID: <2607233.VlpZS8z9ty@vostro.rjw.lan>
References: <1449649050.2175.59.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60415 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753677AbbLIWh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2015 17:37:29 -0500
In-Reply-To: <1449649050.2175.59.camel@kxue-X58A-UD3R>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Xue <ken.xue@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, SPG_Linux_Kernel@amd.com, mika.westerberg@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Ivan.Zheng@amd.com, Alex.Chuang@amd.com, tj@kernel.org, stern@rowland.harvard.edu

On Wednesday, December 09, 2015 04:17:30 PM Ken Xue wrote:
> D3cold is only regarded as valid if the "_PR3" object is
> present for the given device after the commit 20dacb71ad28
> ("ACPI/PM: Rework device power management to follow ACPI 6").
> 
> But some old BIOS only defined "_PS3" for the D3COLD device,
> such as ZPODD device. And old kernel also believes the device with
> "_PS3" is a D3COLD device.
> 
> So, add some logics for supporting D3 COLD device with old BIOS
> which is compatible with earlier ACPI spec and kernel behavior.
> 
> Reference:
> http://marc.info/?l=linux-acpi&m=144946938709759&w=2
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> Reported-and-tested-by: Gang Long <Gang.Long@amd.com>
> ---
>  include/acpi/acpi_bus.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ad0a5ff..9894b75 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -631,7 +631,9 @@ static inline bool acpi_device_can_wakeup(struct acpi_device *adev)
>  
>  static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  {
> -	return adev->power.states[ACPI_STATE_D3_COLD].flags.valid;
> +	return adev->power.states[ACPI_STATE_D3_COLD].flags.valid ||
> +		((acpi_gbl_FADT.header.revision < 6) &&
> +		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
>  }
>  
>  #else	/* CONFIG_ACPI */

This is fine by me, but _PS3 is allowed to remove power from the device even by ACPI 6.

Queued up for 4.5, thanks!

Rafael

