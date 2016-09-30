From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] nfit: don't start a full scrub by default for an
 MCE
Date: Fri, 30 Sep 2016 15:39:28 -0700
Message-ID: <CAPcyv4hW64O-pPkdHJmzxgqOxYf_BnDYoD7QEQ8Df0MVsaDrZw@mail.gmail.com>
References: <1475266203-18559-1-git-send-email-vishal.l.verma@intel.com>
 <1475266203-18559-2-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1475266203-18559-2-git-send-email-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 30, 2016 at 1:10 PM, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Starting a full Address Range Scrub (ARS) on hitting a memory error
> machine check exception may not always be desirable. Provide a way
> through sysfs to toggle the behavior between just adding the address
> (cache line) where the MCE happened to the poison list and doing a full
> scrub. The former (selective insertion of the address) is done
> unconditionally.
>
> Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/nfit/mce.c  | 24 ++++++++++++++++-----
>  drivers/acpi/nfit/nfit.h |  6 ++++++
>  3 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 80cc7c0..6a12bc2 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -878,6 +878,58 @@ static ssize_t revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(revision);
>
> +static ssize_t hw_error_scrub_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
> +       struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> +
> +       return sprintf(buf, "%d\n", acpi_desc->scrub_mode);
> +}
> +
> +/*
> + * The 'hw_error_scrub' attribute can have the following values written to it:
> + * '1': Enable a full scrub to happen if an exception for a memory error is
> + *      received.
> + * '2': Switch to the default mode where an exception will only insert
> + *      the address of the memory error into the poison and badblocks lists.

Should the default be zero instead of 2, to match what ->scrub_mode is
initialized to by default?

> + */
> +static ssize_t hw_error_scrub_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       struct nvdimm_bus_descriptor *nd_desc;
> +       ssize_t rc;
> +       long val;
> +
> +       rc = kstrtol(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +
> +       device_lock(dev);
> +       nd_desc = dev_get_drvdata(dev);
> +       if (nd_desc) {
> +               struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> +
> +               switch (val) {
> +               case MCE_SCRUB_ON:
> +                       acpi_desc->scrub_mode = MCE_SCRUB_ON;

If we're calling the sysfs attribute "hw_error_scrub" to avoid the
x86-specific MCE naming, I think we should call these defines
HW_ERROR_SCRUB_*.

> +                       break;
> +               case MCE_SCRUB_OFF:
> +                       acpi_desc->scrub_mode = MCE_SCRUB_OFF;
> +                       break;
> +               default:
> +                       rc = -EINVAL;
> +                       break;
> +               }
> +       }
> +       device_unlock(dev);
> +       if (rc)
> +               return rc;
> +       return size;
> +}
> +static DEVICE_ATTR_RW(hw_error_scrub);
> +
>  /*
>   * This shows the number of full Address Range Scrubs that have been
>   * completed since driver load time. Userspace can wait on this using
> @@ -950,6 +1002,7 @@ static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
>  static struct attribute *acpi_nfit_attributes[] = {
>         &dev_attr_revision.attr,
>         &dev_attr_scrub.attr,
> +       &dev_attr_hw_error_scrub.attr,
>         NULL,
>  };
>
> @@ -2489,6 +2542,7 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
>                 goto out_unlock;
>         }
>
> +       acpi_desc->scrub_mode = MCE_SCRUB_OFF;

If we make HW_ERROR_SCRUB_OFF == 0, then we don't need this line.
