From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI / ARM64: Get configuration base address of ECAM via
 ACPI MCFG table
Date: Fri, 28 Aug 2015 15:39:43 +0100
Message-ID: <20150828143943.GF15924@red-moon>
References: <1440766163-12101-1-git-send-email-dennis.chen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52232 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbbH1Ojk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Aug 2015 10:39:40 -0400
Content-Disposition: inline
In-Reply-To: <1440766163-12101-1-git-send-email-dennis.chen@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dennis Chen <dennis.chen@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>

Hi Dennis,

You should CC linux-pci@vger.kernel.org and the PCI subsystem
maintainer next time.

On Fri, Aug 28, 2015 at 01:49:23PM +0100, Dennis Chen wrote:
> This patch will fall back to ACPI MCFG table if _CBA method fails
> to get the configuration base address of ECAM. Firmware on ARM
> platform uses MCFG table instead of _CBA method. This is needed
> to scan the PCIe root complex for ARM SoC.

Code to enumerate PCI with ACPI on ARM64 is under review:

https://lkml.org/lkml/2015/6/8/443

Having said that, I do not think this patch will be needed,
you can't add code in the kernel because it may be needed in
the future, I do not see how it can be possibly useful at present
on ARM64 unless you pulled some patch dependencies; if that's the
case you should have listed them.

This patch can't be review standalone since it has no use in
the current kernel (at least for ARM64, it should be tested
on x86 though).

Thanks,
Lorenzo

> Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> ---
>  drivers/pci/pci-acpi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 97 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 314a625..211b9d9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -27,18 +27,110 @@ const u8 pci_acpi_dsm_uuid[] = {
>  	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
>  };
>  
> +static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg)
> +{
> +	if (mcfg->header.revision != 1) {
> +		pr_err("invalid header revision:%d in ACPI MCFG table\n",
> +			mcfg->header.revision);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static phys_addr_t __init acpi_get_mcfg_cba(u16 segment, u8 bus)
> +{
> +	struct acpi_table_header *table = NULL;
> +	acpi_size tbl_size;
> +	struct acpi_table_mcfg *mcfg = NULL;
> +	struct acpi_mcfg_allocation *cfg_table, *cfg;
> +	acpi_status status;
> +	phys_addr_t cba = 0;
> +	unsigned long i;
> +	int entries;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	status = acpi_get_table_with_size(ACPI_SIG_MCFG, 0, &table, &tbl_size);
> +	if (ACPI_FAILURE(status)) {
> +		const char *msg = acpi_format_exception(status);
> +
> +		pr_err("Failed to get MCFG table, %s\n", msg);
> +		return 0;
> +	}
> +
> +	if (table)
> +		mcfg = (struct acpi_table_mcfg *)table;
> +
> +	entries = 0;
> +	i = table->length - sizeof(struct acpi_table_mcfg);
> +	while (i >= sizeof(struct acpi_mcfg_allocation)) {
> +		entries++;
> +		i -= sizeof(struct acpi_mcfg_allocation);
> +	}
> +	if (entries == 0) {
> +		pr_err("ACPI MCFG table has no entries\n");
> +		goto out;
> +	}
> +
> +	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
> +	for (i = 0; i < entries; i++) {
> +		cfg = &cfg_table[i];
> +		if (acpi_mcfg_check_entry(mcfg))
> +			goto out;
> +
> +		if (cfg->pci_segment == segment &&
> +			cfg->start_bus_number <= bus &&
> +			bus <= cfg->end_bus_number) {
> +			cba = (phys_addr_t)cfg->address;
> +			goto out;
> +		}
> +	}
> +out:
> +	/*
> +	 * acpi_get_table_with_size() creates MCFG table mapping that
> +	 * should be released after parsing and before resuming boot
> +	 */
> +	early_acpi_os_unmap_memory(table, tbl_size);
> +	return cba;
> +}
> +
>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  {
>  	acpi_status status = AE_NOT_EXIST;
> -	unsigned long long mcfg_addr;
> +	unsigned long long mcfg_addr, mcfg_seg, mcfg_bus;
> +	u16 seg;
> +	u8 bus;
> +
> +	if (!handle)
> +		return 0;
>  
> -	if (handle)
> -		status = acpi_evaluate_integer(handle, METHOD_NAME__CBA,
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__CBA,
>  					       NULL, &mcfg_addr);
> +	if (ACPI_SUCCESS(status))
> +		return (phys_addr_t)mcfg_addr;
> +
> +	pr_info("ACPI: Falling back to acpi mcfg table\n");
> +
> +	/*
> +	 * Fall back to MCFG table if _CBA failed:
> +	 * get the mcfg_addr via ACPI MCFG table. PCI Firmware v3.2 spec: 4.1.2
> +	 */
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG,
> +						NULL, &mcfg_seg);
>  	if (ACPI_FAILURE(status))
> -		return 0;
> +		mcfg_seg = 0;
> +
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN,
> +						NULL, &mcfg_bus);
> +	if (ACPI_FAILURE(status))
> +		mcfg_bus = 0;
> +
> +	seg = mcfg_seg & 0xFFFF;
> +	bus = mcfg_bus & 0xFF;
>  
> -	return (phys_addr_t)mcfg_addr;
> +	return acpi_get_mcfg_cba(seg, bus);
>  }
>  
>  static acpi_status decode_type0_hpx_record(union acpi_object *record,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
