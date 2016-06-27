From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] acpi, nfit: treat volatile virtual CD region as pmem
Date: Mon, 27 Jun 2016 10:34:32 -0700
Message-ID: <CAPcyv4hknQyYAT3PjsLTuPEwd=+ZbkF6ndsVJaG28TUPwJVxzQ@mail.gmail.com>
References: <1467009960-20580-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1467009960-20580-1-git-send-email-jlee-IBi9RG/b67k@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Lee, Chun-Yi" <joeyli.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Lee,
 Chun-Yi" <jlee-IBi9RG/b67k@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gary Lin <GLin-IBi9RG/b67k@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 26, 2016 at 11:46 PM, Lee, Chun-Yi <joeyli.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch adds logic to treat volatile virtual CD region as pmem
> region, then /dev/pmem* device can be mounted with iso9660.
>
> It's useful to work with the httpboot in EFI firmware to pull a remote
> ISO file to the local memory region for booting and installation.
>
> Wiki page of UEFI HTTPBoot with OVMF:
>         https://en.opensuse.org/UEFI_HTTPBoot_with_OVMF
>
> The ramdisk function in EDK2/OVMF generates a ACPI0012 root device that
> it contains empty _STA but without _DSM:
>
> DefinitionBlock ("ssdt2.aml", "SSDT", 2, "INTEL ", "RamDisk ", 0x00001000)
> {
>     Scope (\_SB)
>     {
>         Device (NVDR)
>         {
>             Name (_HID, "ACPI0012")  // _HID: Hardware ID
>             Name (_STR, Unicode ("NVDIMM Root Device"))  // _STR: Description String
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
>         }
>     }
> }
>
> In section 5.2.25.2 of ACPI 6.1 spec, it mentions that the "SPA Range
> Structure Index" of VCD SPA shall be set to zero. That means VCD SPA
> will not be associated by any NVDIMM region mapping.
>
> The VCD's SPA Range Structure in NFIT is similar to virtual disk region
> as following:
>
> [028h 0040   2]                Subtable Type : 0000 [System Physical Address Range]
> [02Ah 0042   2]                       Length : 0038
>
> [02Ch 0044   2]                  Range Index : 0000
> [02Eh 0046   2]        Flags (decoded below) : 0000
>                    Add/Online Operation Only : 0
>                       Proximity Domain Valid : 0
> [030h 0048   4]                     Reserved : 00000000
> [034h 0052   4]             Proximity Domain : 00000000
> [038h 0056  16]           Address Range GUID : 77AB535A-45FC-624B-5560-F7B281D1F96E
> [048h 0072   8]           Address Range Base : 00000000B6ABD018
> [050h 0080   8]         Address Range Length : 0000000005500000
> [058h 0088   8]         Memory Map Attribute : 0000000000000000
>
> The way to not associate a SPA range is to never reference it from a "flush hint",
> "interleave", or "control region" table.
>
> After testing on OVMF, pmem driver can support the region that it doesn't
> assoicate to any NVDIMM mapping. So, treat VCD like pmem is a idea to get
> a pmem block device that it contains iso.
>
> v3:
> To simplify patch, removed VCD region in libnvdimm.
>
> v2:
> Removed the code for setting VCD to a read-only region.
>
> Cc: Gary Lin <GLin-IBi9RG/b67k@public.gmane.org>
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
> Signed-off-by: Lee, Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>
> ---
>  drivers/acpi/nfit.c          |  8 +++++++-
>  drivers/nvdimm/region_devs.c | 26 +++++++++++++++++++++++++-
>  include/linux/libnvdimm.h    |  2 ++
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> Index: linux/drivers/acpi/nfit.c
> ===================================================================
> --- linux.orig/drivers/acpi/nfit.c
> +++ linux/drivers/acpi/nfit.c
> @@ -1995,7 +1995,7 @@ static int acpi_nfit_register_region(str
>         if (nfit_spa->nd_region)
>                 return 0;
>
> -       if (spa->range_index == 0) {
> +       if (spa->range_index == 0 && nfit_spa_type(spa) != NFIT_SPA_VCD) {
>                 dev_dbg(acpi_desc->dev, "%s: detected invalid spa index\n",
>                                 __func__);

If we're adding the special casing might as well add it for all
"virtual spa" tables.  I.e. introduce nfit_spa_is_virtual() and have
it check for: NFIT_SPA_VDISK, NFIT_SPA_VCD, NFIT_SPA_PDISK, and
NFIT_SPA_PCD.
