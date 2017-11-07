From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH V2] acpi: apei: call into AER handling regardless of
 severity
Date: Tue, 7 Nov 2017 18:21:31 -0500
Message-ID: <01fff9c1-8cd5-14d3-5d90-c0dab8e62a52@codeaurora.org>
References: <1508254115-27945-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbdKGXVf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Nov 2017 18:21:35 -0500
In-Reply-To: <1508254115-27945-1-git-send-email-tbaicar@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/17/2017 11:28 AM, Tyler Baicar wrote:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity.
>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Hello Boris,

Do you think this patch is good now?

Thanks,
Tyler
> ---
>   drivers/acpi/apei/ghes.c | 76 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 46 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3c3a37b..d7801bc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -458,6 +458,51 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>   #endif
>   }
>   
> +/*
> + * PCIe AER errors need to be sent to the AER driver for reporting and
> + * recovery. The GHES severities map to the following AER severities and
> + * require the following handling:
> + *
> + * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
> + *	These need to be reported by the AER driver but no recovery is
> + *	necessary.
> + * GHES_SEV_RECOVERABLE -> AER_NONFATAL
> + * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
> + *	These both need to be reported and recovered from by the AER driver.
> + * GHES_SEV_PANIC does not make it to this handling since the kernel must
> + *	panic.
> + */
> +static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		unsigned int devfn;
> +		int aer_severity;
> +
> +		devfn = PCI_DEVFN(pcie_err->device_id.device,
> +				  pcie_err->device_id.function);
> +		aer_severity = cper_severity_to_aer(gdata->error_severity);
> +
> +		/*
> +		 * If firmware reset the component to contain
> +		 * the error, we must reinitialize it before
> +		 * use, so treat it as a fatal AER error.
> +		 */
> +		if (gdata->flags & CPER_SEC_RESET)
> +			aer_severity = AER_FATAL;
> +
> +		aer_recover_queue(pcie_err->device_id.segment,
> +				  pcie_err->device_id.bus,
> +				  devfn, aer_severity,
> +				  (struct aer_capability_regs *)
> +				  pcie_err->aer_info);
> +	}
> +#endif
> +}
> +
>   static void ghes_do_proc(struct ghes *ghes,
>   			 const struct acpi_hest_generic_status *estatus)
>   {
> @@ -485,38 +530,9 @@ static void ghes_do_proc(struct ghes *ghes,
>   			arch_apei_report_mem_error(sev, mem_err);
>   			ghes_handle_memory_failure(gdata, sev);
>   		}
> -#ifdef CONFIG_ACPI_APEI_PCIEAER
>   		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> -			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> -
> -			if (sev == GHES_SEV_RECOVERABLE &&
> -			    sec_sev == GHES_SEV_RECOVERABLE &&
> -			    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> -			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> -				unsigned int devfn;
> -				int aer_severity;
> -
> -				devfn = PCI_DEVFN(pcie_err->device_id.device,
> -						  pcie_err->device_id.function);
> -				aer_severity = cper_severity_to_aer(gdata->error_severity);
> -
> -				/*
> -				 * If firmware reset the component to contain
> -				 * the error, we must reinitialize it before
> -				 * use, so treat it as a fatal AER error.
> -				 */
> -				if (gdata->flags & CPER_SEC_RESET)
> -					aer_severity = AER_FATAL;
> -
> -				aer_recover_queue(pcie_err->device_id.segment,
> -						  pcie_err->device_id.bus,
> -						  devfn, aer_severity,
> -						  (struct aer_capability_regs *)
> -						  pcie_err->aer_info);
> -			}
> -
> +			ghes_handle_aer(gdata);
>   		}
> -#endif
>   		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>   			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>   

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

