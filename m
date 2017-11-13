From: Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of
 severity
Date: Mon, 13 Nov 2017 20:36:26 +0800
Message-ID: <cbcfe70b-e74f-ca1d-b58d-a8b1c391a91b@huawei.com>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
 <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:10474 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbdKMMgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Nov 2017 07:36:54 -0500
In-Reply-To: <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, rjw@rjwysocki.net, tony.luck@intel.com, bp@alien8.de, bp@suse.de, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


ÔÚ 2017/11/9 3:13, Tyler Baicar Ð´µÀ:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity

It will also call do_recovery() regardless of the severity for AER correctable errors.
Correctable errors include those error conditions where hardware can recover without any loss of information.
Hardware corrects these errors and software intervention is not required.
So we'd better modify the code as below.
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 7448052..a7f77549 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -633,7 +633,8 @@ static void aer_recover_work_func(struct work_struct *work)
                         continue;
                 }
                 cper_print_aer(pdev, entry.severity, entry.regs);
-           do_recovery(pdev, entry.severity);
+         if(entry.severity != AER_CORRECTABLE)
+                 do_recovery(pdev, entry.severity);
                 pci_dev_put(pdev);
         }
  }

Thanks,
Dongdong
>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 839c3d5..bb65fa6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -458,14 +458,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>  #endif
>  }
>
> -static void ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev, int sec_sev)
> +static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  {
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>
> -	if (sev == GHES_SEV_RECOVERABLE &&
> -	    sec_sev == GHES_SEV_RECOVERABLE &&
> -	    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>  	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
>  		unsigned int devfn;
>  		int aer_severity;
> @@ -519,7 +517,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			ghes_handle_memory_failure(gdata, sev);
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> -			ghes_handle_aer(gdata, sev, sec_sev);
> +			ghes_handle_aer(gdata);
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>

