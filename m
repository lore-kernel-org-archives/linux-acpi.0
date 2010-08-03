From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce acpi_pci_osc_control_query()
Date: Tue, 03 Aug 2010 13:52:01 +0900
Message-ID: <4C57A071.2090902@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022353.04353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201008022353.04353.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

(2010/08/03 6:53), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rjw@sisk.pl>
>
> Introduce a function allowing the caller to obtain a mask of _OSC
> control bits the BIOS will allow the kernel to control for a given
> PCI root bridge.
>
> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> ---
>   drivers/acpi/pci_root.c |   58 ++++++++++++++++++++++++++++++++++++++++--------
>   include/linux/acpi.h    |    1
>   2 files changed, 50 insertions(+), 9 deletions(-)
>
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -225,21 +225,32 @@ static acpi_status acpi_pci_run_osc(acpi
>   	return status;
>   }
>
> -static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
> +static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> +					u32 support,
> +					u32 *control)
>   {
>   	acpi_status status;
> -	u32 support_set, result, capbuf[3];
> +	u32 result, capbuf[3];
> +
> +	support&= OSC_PCI_SUPPORT_MASKS;
> +	support |= root->osc_support_set;
>
> -	/* do _OSC query for all possible controls */
> -	support_set = root->osc_support_set | (flags&  OSC_PCI_SUPPORT_MASKS);
>   	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
> -	capbuf[OSC_SUPPORT_TYPE] = support_set;
> -	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> +	capbuf[OSC_SUPPORT_TYPE] = support;
> +	if (control) {
> +		*control&= OSC_PCI_CONTROL_MASKS;
> +		capbuf[OSC_CONTROL_TYPE] = *control;

I think controls that are already granted to OS need to be ORed here.
I.e.

		capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | *control;

Thanks,
Kenji Kaneshige
