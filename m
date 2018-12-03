From: Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather
 than "ARS-short"
Date: Mon, 3 Dec 2018 13:12:24 -0700
Message-ID: <6345bd3b-b5c0-eb51-bd81-878cd764e66d@intel.com>
References: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: Jacek Zloch <jacek.zloch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On 12/3/2018 11:30 AM, Dan Williams wrote:
> A "short" ARS (address range scrub) instructs the platform firmware to
> return known errors. In contrast, a "long" ARS instructs platform
> firmware to arrange every data address on the DIMM to be read / checked
> for poisoned data.
>
> The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
> Address Range Scrub completion tracking", changed the meaning of passing
> '0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now '0'
> is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-type
> behavior of user-initiated ARS sessions.
>
> Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion tracking")
> Reported-by: Jacek Zloch <jacek.zloch@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/nfit/core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14d9f5bea015..5912d30020c7 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1308,7 +1308,7 @@ static ssize_t scrub_store(struct device *dev,
>   	if (nd_desc) {
>   		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>   
> -		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
> +		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>   	}
>   	device_unlock(dev);
>   	if (rc)
>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
