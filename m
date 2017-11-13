From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of
 severity
Date: Mon, 13 Nov 2017 10:34:58 -0500
Message-ID: <f3baa5eb-a7fa-9654-99b6-81dadb6df938@codeaurora.org>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
 <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
 <cbcfe70b-e74f-ca1d-b58d-a8b1c391a91b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdKMPfC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Nov 2017 10:35:02 -0500
In-Reply-To: <cbcfe70b-e74f-ca1d-b58d-a8b1c391a91b@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>, rjw@rjwysocki.net, tony.luck@intel.com, bp@alien8.de, bp@suse.de, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>

On 11/13/2017 7:36 AM, Dongdong Liu wrote:
>
> 在 2017/11/9 3:13, Tyler Baicar 写道:
>> Currently the GHES code only calls into the AER driver for
>> recoverable type errors. This is incorrect because errors of
>> other severities do not get logged by the AER driver and do not
>> get exposed to user space via the AER trace event. So, call
>> into the AER driver for PCIe errors regardless of the severity
>
> It will also call do_recovery() regardless of the severity for AER correctable 
> errors.
> Correctable errors include those error conditions where hardware can recover 
> without any loss of information.
> Hardware corrects these errors and software intervention is not required.
> So we'd better modify the code as below.
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
> b/drivers/pci/pcie/aer/aerdrv_core.c
> index 7448052..a7f77549 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -633,7 +633,8 @@ static void aer_recover_work_func(struct work_struct *work)
>                         continue;
>                 }
>                 cper_print_aer(pdev, entry.severity, entry.regs);
> -           do_recovery(pdev, entry.severity);
> +         if(entry.severity != AER_CORRECTABLE)
> +                 do_recovery(pdev, entry.severity);
>                 pci_dev_put(pdev);
>         }
>  }
Hello Dongdong,

Yes, I have a patch for this that needs to be picked up.

https://lkml.org/lkml/2017/8/28/848

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

