From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] ACPI/PCI: optimize checks in acpi_pci_osc_control_set()
Date: Fri, 30 Jul 2010 14:42:52 +0200
Message-ID: <201007301442.52450.rjw@sisk.pl>
References: <201007282323.56351.rjw@sisk.pl> <4C526E3E.3000600@jp.fujitsu.com> <4C526F96.2090409@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C526F96.2090409@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, July 30, 2010, Kenji Kaneshige wrote:
> Check for ACPI _OSC object is heavier than other checks in
> acpi_pci_osc_control_set(). So move it after the other checks.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

OK

Rafael

> ---
>  drivers/acpi/pci_root.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.35-rc6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.35-rc6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6.35-rc6/drivers/acpi/pci_root.c
> @@ -388,10 +388,6 @@ acpi_status acpi_pci_osc_control_set(acp
>  	acpi_handle tmp;
>  	struct acpi_pci_root *root;
>  
> -	status = acpi_get_handle(handle, "_OSC", &tmp);
> -	if (ACPI_FAILURE(status))
> -		return status;
> -
>  	control_req = (flags & OSC_PCI_CONTROL_MASKS);
>  	if (!control_req)
>  		return AE_TYPE;
> @@ -400,6 +396,10 @@ acpi_status acpi_pci_osc_control_set(acp
>  	if (!root)
>  		return AE_NOT_EXIST;
>  
> +	status = acpi_get_handle(handle, "_OSC", &tmp);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
>  	mutex_lock(&osc_lock);
>  	/* No need to evaluate _OSC if the control was already granted. */
>  	if ((root->osc_control_set & control_req) == control_req)
> 
> 
> 
