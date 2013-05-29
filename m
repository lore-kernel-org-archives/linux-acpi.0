From: "Pearson, Greg" <greg.pearson@hp.com>
Subject: Re: [PATCH 2/3] ACPI/APEI: Force fatal AER severity when bus has
 been reset
Date: Wed, 29 May 2013 15:42:24 +0000
Message-ID: <51A621E0.9030307@hp.com>
References: <1369766929-4386-1-git-send-email-betty.dall@hp.com>
 <1369766929-4386-3-git-send-email-betty.dall@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1369766929-4386-3-git-send-email-betty.dall@hp.com>
Content-Language: en-US
Content-ID: <036514CC7E0DBE4C88BCDE20B2302EB2@Compaq.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Dall, Elizabeth J (MCLinux)" <betty.dall@hp.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "bhelgaas@google.com" <bhelgaas@google.com>, "ying.huang@intel.com" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 05/28/2013 12:48 PM, Betty Dall wrote:
> The CPER error record has a reset bit that indicates that the platform
> has reset the bus. The reset bit can be set for any severity error
> including recoverable.  From the AER code path's perspective,
> any error is fatal if the bus has been reset. This patch upgrades the
> severity of the AER recovery to AER_FATAL whenever the CPER error record
> indicates that the bus has been reset.
>
> Signed-off-by: Betty Dall <betty.dall@hp.com>
> ---
>
>   drivers/acpi/apei/ghes.c |   21 ++++++++++++++++++++-
>   1 files changed, 20 insertions(+), 1 deletions(-)
>
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d668a8a..4a42afc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -451,7 +451,26 @@ static void ghes_do_proc(struct ghes *ghes,
>   				int aer_severity;
>   				devfn = PCI_DEVFN(pcie_err->device_id.device,
>   						  pcie_err->device_id.function);
> -				aer_severity = cper_severity_to_aer(sev);
> +				/*
> +				 * Some Firmware First implementations
> +				 * put the device in SBR to contain
> +				 * the error. This is indicated by the
> +				 * CPER Section Decriptor Flags reset

Nit Pick, change "Decriptor" to "Descriptor".

--
Greg

> +				 * bit which means the component must
> +				 * be re-initialized or re-enabled
> +				 * prior to use. Promoting the AER
> +				 * serverity to FATAL will cause the
> +				 * AER code to link_reset and allow
> +				 * drivers to reprogram their cards.
> +				 */
> +				if (gdata->flags & CPER_SEC_RESET)
> +					aer_severity = cper_severity_to_aer(
> +							CPER_SEV_FATAL);
> +				else
> +					aer_severity =
> +						cper_severity_to_aer(sev);
> +
> +
>   				aer_recover_queue(pcie_err->device_id.segment,
>   						  pcie_err->device_id.bus,
>   						  devfn, aer_severity);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
