From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH] pci, acpi: QDF2xxx 32 bit config space accessors
Date: Tue, 19 Jan 2016 15:19:38 -0500
Message-ID: <569E9A5A.9050305@codeaurora.org>
References: <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1453233259-29562-1-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37985 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbcASUTl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 15:19:41 -0500
In-Reply-To: <1453233259-29562-1-git-send-email-cov@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Sinan Kaya <okaya@codeaurora.org>

[Fixing Jon's email; sorry for the typo.]

On 01/19/2016 02:54 PM, Christopher Covington wrote:
> Qualcomm Technologies QDF2xxx SoCs require 32 bit accessors to be used
> for the PCI configuration space. Register the appropriate quirk.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> This patch depends on Tomasz Nowicki's ACPI support for PCI:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/thread.html#399200
> 
>  drivers/acpi/mcfg.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
> index ec5fe7b..dee4964 100644
> --- a/drivers/acpi/mcfg.c
> +++ b/drivers/acpi/mcfg.c
> @@ -78,6 +78,29 @@ static struct pci_ops default_pci_mcfg_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> +static const struct dmi_system_id qcom_qdf2xxx[] = {
> +	{
> +		.ident = "Qualcomm Technologies QDF2xxx",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Qualcomm"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "QDF2"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static struct pci_ops qcom_qdf2xxx_pci_mcfg_ops = {
> +	.map_bus = pci_mcfg_dev_base,
> +	.read = pci_generic_config_read32,
> +	.write = pci_generic_config_write32,
> +};
> +
> +DECLARE_ACPI_MCFG_FIXUP(qcom_qdf2xxx,
> +			NULL,
> +			&qcom_qdf2xxx_pci_mcfg_ops,
> +			PCI_MCFG_DOMAIN_ANY,
> +			PCI_MCFG_BUS_ANY);
> +
>  struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>  {
>  	struct pci_ops *pci_mcfg_ops_quirk;
> 


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
