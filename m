From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] ACPI/NFIT: Update Control Region Structure per ACPI 6.1
Date: Fri, 19 Feb 2016 14:34:31 -0800
Message-ID: <CAPcyv4jUj=NzEHbZjiOUAqOva2ujwWfGSQHcFR-HVXdBwB2LvA@mail.gmail.com>
References: <1455923333-13629-1-git-send-email-toshi.kani@hpe.com>
	<1455923333-13629-2-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33250 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954AbcBSWec (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2016 17:34:32 -0500
Received: by mail-yk0-f181.google.com with SMTP id z13so40842683ykd.0
        for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2016 14:34:32 -0800 (PST)
In-Reply-To: <1455923333-13629-2-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devel@acpica.org, Lv Zheng <lv.zheng@intel.com>

On Fri, Feb 19, 2016 at 3:08 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> as follows.
>  - Valid Fields, Manufacturing Location, and Manufacturing Date
>    are added from reserved range.  No change in the structure size.
>  - IDs defined as SPD values are arrays of bytes.  The spec
>    clarified that they need to be represented as arrays of bytes
>    as well.
>
> This patch makes the following changes to support this update.
>  - Change 'struct acpi_nfit_control_region' to reflect the update.
>    SPD IDs are defined as arrays of bytes, so that they can be
>    treated in the same way regardless of CPU endianness and are
>    not miss-treated as little-endian numeric values.
>  - Change the NFIT driver to show SPD ID values as array of bytes
>    in sysfs.
>  - Change the NFIT driver to show Manufacturing Location and
>    Manufacturing Date when they are valid.
>  - Change the NFIT driver to show an NVDIMM unique ID as defined
>    in section 5.2.25.9 of the spec.
>  - Change sprintf format to use "0x" instead of "#" since "%#02x"
>    does not prepend '0' in some reason.
>
> link: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Robert Elliott <elliott@hpe.com>
> Cc: <devel@acpica.org>
> ---
>  drivers/acpi/nfit.c   |   75 ++++++++++++++++++++++++++++++++++++++++++-------
>  include/acpi/actbl1.h |   24 ++++++++++------
>  2 files changed, 80 insertions(+), 19 deletions(-)

Hi Toshi,

I general looks good, but note that changes to include/acpi/actbl1.h
need to go through the ACPICA project.  Then their normal import
process will bring it into the kernel.  I added Lv to the cc.

>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index ad6d8c6..06677d9 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -722,7 +722,8 @@ static ssize_t vendor_show(struct device *dev,
>  {
>         struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>
> -       return sprintf(buf, "%#x\n", dcr->vendor_id);
> +       return sprintf(buf, "0x%02x%02x\n",
> +                               dcr->vendor_id[0], dcr->vendor_id[1]);
>  }
>  static DEVICE_ATTR_RO(vendor);
>
> @@ -731,7 +732,8 @@ static ssize_t rev_id_show(struct device *dev,
>  {
>         struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>
> -       return sprintf(buf, "%#x\n", dcr->revision_id);
> +       return sprintf(buf, "0x%02x%02x\n",
> +                               dcr->revision_id[0], dcr->revision_id[1]);
>  }
>  static DEVICE_ATTR_RO(rev_id);
>
> @@ -740,7 +742,8 @@ static ssize_t device_show(struct device *dev,
>  {
>         struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>
> -       return sprintf(buf, "%#x\n", dcr->device_id);
> +       return sprintf(buf, "0x%02x%02x\n",
> +                               dcr->device_id[0], dcr->device_id[1]);
>  }
>  static DEVICE_ATTR_RO(device);
>
> @@ -749,7 +752,7 @@ static ssize_t format_show(struct device *dev,
>  {
>         struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>
> -       return sprintf(buf, "%#x\n", dcr->code);
> +       return sprintf(buf, "0x%02x%02x\n", dcr->code[0], dcr->code[1]);
>  }
>  static DEVICE_ATTR_RO(format);
>
> @@ -758,7 +761,9 @@ static ssize_t serial_show(struct device *dev,
>  {
>         struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>
> -       return sprintf(buf, "%#x\n", dcr->serial_number);
> +       return sprintf(buf, "0x%02x%02x%02x%02x\n",
> +                       dcr->serial_number[0], dcr->serial_number[1],
> +                       dcr->serial_number[2], dcr->serial_number[3]);
>  }
>  static DEVICE_ATTR_RO(serial);

These fixups look good.

Can we split the new sysfs attributes below into their own patch?  One
more comments below:

>
> @@ -776,6 +781,45 @@ static ssize_t flags_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(flags);
>
> +static ssize_t mfg_location_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
> +
> +       return sprintf(buf, "0x%02x\n", dcr->manufacturing_location);
> +}
> +static DEVICE_ATTR_RO(mfg_location);
> +
> +static ssize_t mfg_date_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
> +
> +       return sprintf(buf, "0x%02x%02x\n",
> +                       dcr->manufacturing_date[0], dcr->manufacturing_date[1]);
> +}
> +static DEVICE_ATTR_RO(mfg_date);
> +
> +static ssize_t unique_id_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
> +
> +       if (dcr->valid_fields & ACPI_NFIT_CONTROL_MFG_INFO_VALID)
> +               return sprintf(buf, "%02x%02x-%02x-%02x%02x-%02x%02x%02x%02x\n",
> +                       dcr->vendor_id[0], dcr->vendor_id[1],
> +                       dcr->manufacturing_location,
> +                       dcr->manufacturing_date[0], dcr->manufacturing_date[1],
> +                       dcr->serial_number[0], dcr->serial_number[1],
> +                       dcr->serial_number[2], dcr->serial_number[3]);
> +       else
> +               return sprintf(buf, "%02x%02x-%02x%02x%02x%02x\n",
> +                       dcr->vendor_id[0], dcr->vendor_id[1],
> +                       dcr->serial_number[0], dcr->serial_number[1],
> +                       dcr->serial_number[2], dcr->serial_number[3]);
> +}
> +static DEVICE_ATTR_RO(unique_id);

Let's just call it 'id' as not to confuse it with a 'uuid'.  Also if
the manufacturing info is incorporated into the id then I don't think
we need separate 'mfg_location' and 'mfg_date' attributes.  If
userspace really wants those separately it can just dump the NFIT
table.
