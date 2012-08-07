From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] irq_remap: disable IRQ remapping if any IOAPIC lacks
 an IOMMU
Date: Tue, 7 Aug 2012 15:04:33 -0700
Message-ID: <CAE9FiQVEsPisVUKeG0aejKzvS+Csp5Ca2KEQyy6ZJW-MR-VFUA@mail.gmail.com>
References: <20120807210408.GK1917@8bytes.org>
	<1344375573-16716-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47935 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab2HGWEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Aug 2012 18:04:34 -0400
In-Reply-To: <1344375573-16716-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Suresh Siddha <suresh.b.siddha@intel.com>

On Tue, Aug 7, 2012 at 2:39 PM, Seth Forshee <seth.forshee@canonical.com> wrote:
> The ACPI tables in the Macbook Air 5,1 define a single IOAPIC with id 2,
> but the only remapping unit described in the DMAR table matches id 0.
> Interrupt remapping fails as a result, and the kernel panics with the
> message "timer doesn't work through Interrupt-remapped IO-APIC."
>
> To fix this, check each IOAPIC for a corresponding IOMMU. If an IOMMU is
> not found, do not allow IRQ remapping to be enabled.
>
> v2: Move check to parse_ioapics_under_ir(), raise log level to KERN_ERR,
>     and add FW_BUG to the log message
>
> Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  drivers/iommu/intel_irq_remapping.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index e0b18f3..84e5dc3 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -736,6 +736,7 @@ int __init parse_ioapics_under_ir(void)
>  {
>         struct dmar_drhd_unit *drhd;
>         int ir_supported = 0;
> +       int ioapic_idx;
>
>         for_each_drhd_unit(drhd) {
>                 struct intel_iommu *iommu = drhd->iommu;
> @@ -754,6 +755,16 @@ int __init parse_ioapics_under_ir(void)
>                 return -1;
>         }
>

need to add

            if (ir_supported)

> +       for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
> +               int ioapic_id = mpc_ioapic_id(ioapic_idx);
> +               if (!map_ioapic_to_ir(ioapic_id)) {
> +                       pr_err(FW_BUG "ioapic %d has no mapping iommu, "
> +                              "interrupt remapping will be disabled\n",
> +                              ioapic_id);
> +                       return -1;
> +               }
> +       }
> +

otherwise may false warning.

>         return ir_supported;
>  }

also could remove the ir_ioapic_num == nr_ioapics checking.

Thanks

Yinghai
