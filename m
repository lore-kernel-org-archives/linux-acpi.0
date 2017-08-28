From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Mon, 28 Aug 2017 22:52:58 +0200
Message-ID: <4587608.qG1kLJBqxQ@aspire.rjw.lan>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, bp@suse.de
Cc: lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, August 28, 2017 7:11:54 PM CEST Tyler Baicar wrote:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>

Boris?

> ---
>  drivers/acpi/apei/ghes.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..5cab238 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -489,9 +489,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>  
> -			if (sev == GHES_SEV_RECOVERABLE &&
> -			    sec_sev == GHES_SEV_RECOVERABLE &&
> -			    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +			if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>  			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
>  				unsigned int devfn;
>  				int aer_severity;
> 
