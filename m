From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, nfit: treat volatile virtual CD region as
 read-only pmem
Date: Fri, 3 Jun 2016 12:27:34 -0700
Message-ID: <CAPcyv4iLb9qzXZTLL5z-RH_CRObnRfzx=vGTvVvieJUEwNvtRw@mail.gmail.com>
References: <1464938015-5489-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464938015-5489-1-git-send-email-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Gary Lin <GLin@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 3, 2016 at 12:13 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> This patch adds codes to treat a volatile virtual CD region as a
> read-only pmem region, then read-only /dev/pmem* device can be mounted
> with iso9660.
>
> It's useful to work with the httpboot in EFI firmware to pull a remote
> ISO file to the local memory region for booting and installation.
>
> Wiki page of UEFI HTTPBoot with OVMF:
>         https://en.opensuse.org/UEFI_HTTPBoot_with_OVMF
>
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> Cc: Gary Lin <GLin@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/nfit.c          |  8 +++++++-
>  drivers/nvdimm/region_devs.c | 26 +++++++++++++++++++++++++-
>  include/linux/libnvdimm.h    |  2 ++
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 2215fc8..b100a17 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1949,6 +1949,7 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
>         switch (nfit_spa_type(spa)) {
>         case NFIT_SPA_PM:
>         case NFIT_SPA_VOLATILE:
> +       case NFIT_SPA_VCD:
>                 nd_mapping->start = memdev->address;
>                 nd_mapping->size = memdev->region_size;
>                 break;

Why do we need to distinguish NFIT_SPA_VOLATILE vs NFIT_SPA_VCD, i.e.
what happens if something writes to a VCD device?
