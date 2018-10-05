From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPIT: Register attributes based on FADT
Date: Fri, 05 Oct 2018 11:46:01 +0200
Message-ID: <2363635.PV2ruU7bBX@aspire.rjw.lan>
References: <20180928085402.9108-1-rajneesh.bhardwaj@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928085402.9108-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rajneesh.bhardwaj@intel.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, September 28, 2018 10:54:02 AM CEST Rajneesh Bhardwaj wrote:
> ACPI Low Power S0 Idle capabilities are announced via FADT table and can
> be used to inform the kernel about the presence of one or more Low Power
> Idle (LPI) entries as descried in LPIT table. LPIT table can exist
> independently even if the FADT S0 Idle flag is not set and thus it could
> confuse user since the following cpuidle attributes are created.
> 
> /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> 
> Presence or absence of above attributes could mean that the given
> platform supports S0ix state or not.
> 
> This change allows to create the above cpuidle attributes only if
> FADT table supports Low Power S0 Idle.
> 
> Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index cf4fc0161164..e43cb71b6972 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -117,11 +117,17 @@ static void lpit_update_residency(struct lpit_residency_info *info,
>  		if (!info->iomem_addr)
>  			return;
>  
> +		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +			return;
> +
>  		/* Silently fail, if cpuidle attribute group is not present */
>  		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
>  					&dev_attr_low_power_idle_system_residency_us.attr,
>  					"cpuidle");
>  	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
> +		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +			return;
> +
>  		/* Silently fail, if cpuidle attribute group is not present */
>  		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
>  					&dev_attr_low_power_idle_cpu_residency_us.attr,
> 

Applied, thanks!
