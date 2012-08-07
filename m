From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] irq_remap: disable IRQ remapping if any IOAPIC lacks an
 IOMMU
Date: Tue, 7 Aug 2012 23:04:08 +0200
Message-ID: <20120807210408.GK1917@8bytes.org>
References: <20120807201030.GJ1917@8bytes.org>
 <1344372489-14087-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344372489-14087-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 07, 2012 at 03:48:09PM -0500, Seth Forshee wrote:
> The ACPI tables in the Macbook Air 5,1 define a single IOAPIC with id 2,
> but the only remapping unit described in the DMAR table matches id 0.
> Interrupt remapping fails as a result, and the kernel panics with the
> message "timer doesn't work through Interrupt-remapped IO-APIC."
> 
> To fix this, check each IOAPIC for a corresponding IOMMU. If an IOMMU is
> not found, do not allow IRQ remapping to be enabled.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  drivers/iommu/intel_irq_remapping.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index e0b18f3..ce2c0c6 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -526,6 +526,7 @@ static int __init intel_irq_remapping_supported(void)
>  static int __init intel_enable_irq_remapping(void)
>  {
>  	struct dmar_drhd_unit *drhd;
> +	int ioapic_idx;
>  	int setup = 0;
>  	int eim = 0;
>  
> @@ -534,6 +535,16 @@ static int __init intel_enable_irq_remapping(void)
>  		return -1;
>  	}
>  
> +	for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
> +		int ioapic_id = mpc_ioapic_id(ioapic_idx);
> +		if (!map_ioapic_to_ir(ioapic_id)) {
> +			pr_info("ioapic %d has no mapping iommu, "
> +				"interrupt remapping will be disabled\n",
> +				ioapic_id);
> +			return -1;
> +		}
> +	}
> +

I would change this to pr_err() and add FW_BUG to make clear that this
is an error caused by a firmware bug.


	Joerg
