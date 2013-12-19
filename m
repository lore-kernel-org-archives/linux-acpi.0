From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Patch v2 03/13] PCI, pci-label: release allocated ACPI object on
 error recovery path
Date: Thu, 19 Dec 2013 11:22:22 -0700
Message-ID: <CAErSpo4oKsJCKxUhxT8E745BkX+veOD-tMEeHULHOuH-3suMRA@mail.gmail.com>
References: <1387456702-4709-1-git-send-email-jiang.liu@linux.intel.com> <1387456702-4709-4-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387456702-4709-4-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 19, 2013 at 5:38 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Function dsm_get_label() leaks the returned ACPI object if
> obj->package.count is not 2, so fix the possible memory leak.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Rafael, if you want to take these through your tree, feel free.  I'm
guessing it probably makes sense to keep the whole series together.

> ---
>  drivers/pci/pci-label.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index d51f45a..f6e01a5 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -233,11 +233,7 @@ dsm_get_label(acpi_handle handle, int func,
>                 return -1;
>
>         obj = (union acpi_object *)output->pointer;
> -
> -       switch (obj->type) {
> -       case ACPI_TYPE_PACKAGE:
> -               if (obj->package.count != 2)
> -                       break;
> +       if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 2) {
>                 len = obj->package.elements[0].integer.value;
>                 if (buf) {
>                         if (attribute == ACPI_ATTR_INDEX_SHOW)
> @@ -250,10 +246,10 @@ dsm_get_label(acpi_handle handle, int func,
>                 }
>                 kfree(output->pointer);
>                 return len;
> -       break;
> -       default:
> -               kfree(output->pointer);
>         }
> +
> +       kfree(output->pointer);
> +
>         return -1;
>  }
>
> --
> 1.7.10.4
>
