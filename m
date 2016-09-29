From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] pci: remove error message when device not present
Date: Thu, 29 Sep 2016 14:34:40 +0200
Message-ID: <3286868.r1zjOMuMhU@vostro.rjw.lan>
References: <20160929112843.13552-1-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59859 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932514AbcI2M2N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Sep 2016 08:28:13 -0400
In-Reply-To: <20160929112843.13552-1-grant.likely@secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@hpe.com>, Linn Crosetto <linn@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>

On Thursday, September 29, 2016 12:28:43 PM Grant Likely wrote:
> It's not an error if the IBM ACPI pseudo-device isn't present, it merely
> means the kernel isn't running on that IBM hardware. Get rid of the
> error report so as not to pollute the kernel log with an message
> irrelevant to the vast majority of users.
> 
> If someone wants to debug it, they can turn on the pr_debug() message
> which will show progress through the .init function.
> 
> Reported-by: Jim Hull <jim.hull@hpe.com>
> Signed-off-by: Grant Likely <grant.likely@hpe.com>
> Cc: Linn Crosetto <linn@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

ACK

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index f6221d7..ec43510 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -439,7 +439,6 @@ static int __init ibm_acpiphp_init(void)
>  	if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>  			ACPI_UINT32_MAX, ibm_find_acpi_device, NULL,
>  			&ibm_acpi_handle, NULL) != FOUND_APCI) {
> -		pr_err("%s: acpi_walk_namespace failed\n", __func__);
>  		retval = -ENODEV;
>  		goto init_return;
>  	}
> 

Thanks,
Rafael

