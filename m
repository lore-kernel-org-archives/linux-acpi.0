From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tools/testing/nvdimm, acpica: fix flag rename build breakage
Date: Wed, 11 Nov 2015 01:07:34 +0100
Message-ID: <CAJZ5v0hR5sGdZnjdNVDWCUbmJD4s2O36RYxv5D84acW9m3ak=Q@mail.gmail.com>
References: <20151110235921.1876.27564.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35614 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKKAHg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 19:07:36 -0500
Received: by lfdo63 with SMTP id o63so7759406lfd.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2015 16:07:34 -0800 (PST)
In-Reply-To: <20151110235921.1876.27564.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

Hi,

On Wed, Nov 11, 2015 at 1:00 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> Commit ca321d1ca672 "ACPICA: Update NFIT table to rename a flags field"
> performed a tree-wide s/ACPI_NFIT_MEM_ARMED/ACPI_NFIT_MEM_NOT_ARMED/
> operation, but missed the tools/testing/nvdimm/ directory.
>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or if you want me to take this patch, I can do that next week.

> ---
>
> I'm working to get build regression coverage for this directory in 0day.
>
>  tools/testing/nvdimm/test/nfit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index dce346aa94ea..40ab4476c80a 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1135,7 +1135,7 @@ static void nfit_test1_setup(struct nfit_test *t)
>         memdev->interleave_ways = 1;
>         memdev->flags = ACPI_NFIT_MEM_SAVE_FAILED | ACPI_NFIT_MEM_RESTORE_FAILED
>                 | ACPI_NFIT_MEM_FLUSH_FAILED | ACPI_NFIT_MEM_HEALTH_OBSERVED
> -               | ACPI_NFIT_MEM_ARMED;
> +               | ACPI_NFIT_MEM_NOT_ARMED;
>
>         offset += sizeof(*memdev);
>         /* dcr-descriptor0 */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
