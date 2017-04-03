From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix acpi_get_table leak
Date: Mon, 3 Apr 2017 13:00:14 -0600
Message-ID: <20170403190014.GA20892@linux.intel.com>
References: <149107472042.16205.8935477753191459036.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <149107472042.16205.8935477753191459036.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 01, 2017 at 12:25:20PM -0700, Dan Williams wrote:
> Calls to acpi_get_table() must be paired with acpi_put_table() to undo
> the mapping established by acpi_tb_acquire_table().
> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Fixes: 6b11d1d67713 ("ACPI / osl: Remove acpi_get_table_with_size()/early_acpi_os_unmap_memory() users")
> Cc: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reported-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index c8ea9d698cd0..6acfea69f061 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2818,6 +2818,11 @@ void acpi_nfit_desc_init(struct acpi_nfit_desc *acpi_desc, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_desc_init);
>  
> +static void acpi_nfit_put_table(void *table)
> +{
> +	acpi_put_table(table);
> +}
> +
>  static int acpi_nfit_add(struct acpi_device *adev)
>  {
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -2834,6 +2839,10 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  		dev_dbg(dev, "failed to find NFIT at startup\n");
>  		return 0;
>  	}
> +
> +	rc = devm_add_action_or_reset(dev, acpi_nfit_put_table, tbl);
> +	if (rc)
> +		return rc;
>  	sz = tbl->length;
>  
>  	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);

I've been looking at this this as well, and I think it might be better to just
drop the reference immediately in acpi_nfit_add() after we're done processing
the tables?  

Anyway, here's the patch I was working on, but I think either works.

------ 8< ------
>From 4819cd889b08c3c17f8f9fcf895a083f21fa0898 Mon Sep 17 00:00:00 2001
From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 3 Apr 2017 11:53:32 -0600
Subject: [PATCH] nfit: release reference on ACPI nfit table

Currently acpi_nfit_add() grabs a reference to the ACPI NFIT table
structures via acpi_get_table(), but never releases it with
acpi_put_table().  This means that the refcount protecting the ioremap for
the NFIT table never decrements, so the ioremap can never be undone.  The
ioremap happens via this path:

acpi_get_table()
  acpi_tb_get_table()
    acpi_tb_validate_table()
      acpi_tb_acquire_table()
        acpi_os_map_memory()

In practice this fix is correct but won't have a usable visible impact
because the ACPI sysfs code (acpi_table_attr_init() et al.), which
populates /sys/firmware/acpi/tables/NFIT, also keeps a table reference, so
the NFIT table memory will always remain mapped.

We drop the refcount at the end of acpi_nfit_add() instead of waiting till
driver unload and doing it via acpi_nfit_remove() or something akin to
acpi_nfit_destruct() called via the devm_ interface.  This is because
during acpi_nfit_add() we never actually keep any references to the
original ACPI tables.  We either copy individual elements out, or we make
whole copies of tables in functions like add_spa(), add memdev(), etc.

Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 662036b..ad0dfd6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2833,8 +2833,10 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	sz = tbl->length;
 
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
-	if (!acpi_desc)
-		return -ENOMEM;
+	if (!acpi_desc) {
+		rc = -ENOMEM;
+		goto out;
+	}
 	acpi_nfit_desc_init(acpi_desc, &adev->dev);
 
 	/* Save the acpi header for exporting the revision via sysfs */
@@ -2857,6 +2859,8 @@ static int acpi_nfit_add(struct acpi_device *adev)
 		rc = acpi_nfit_init(acpi_desc, (void *) tbl
 				+ sizeof(struct acpi_table_nfit),
 				sz - sizeof(struct acpi_table_nfit));
+out:
+	acpi_put_table(tbl);
 	return rc;
 }
 
-- 
2.9.3
