From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Tue, 29 Aug 2017 10:20:55 +0200
Message-ID: <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 28, 2017 at 11:11:54AM -0600, Tyler Baicar wrote:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
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

Did you make the effort to see which commit added those lines and read
its commit message?

Doesn't look like it...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
