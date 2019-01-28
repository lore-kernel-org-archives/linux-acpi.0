From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Date: Mon, 28 Jan 2019 13:01:19 -0800
Message-ID: <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <PU1P153MB0169DF967C5BAAC8334FCC42BF990-7hHSCQUTt08p9lVGRpUb+2HfQuWdHs3hiGd9ebBGJoev3QGu/rdwKA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Cc: Josh Poulson <jopoulso-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org" <driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sasha Levin <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Dexuan,

Looks good. Just one update request and a note below...

On Wed, Jan 23, 2019 at 12:51 PM Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org> wrote:
>
>
> Add the Hyper-V _DSM command set to the white list of NVDIMM command
> sets.
>
> This command set is documented at http://www.uefi.org/RFIC_LIST
> (see the link to "Virtual NVDIMM 0x1901" on the page).
>
> Signed-off-by: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
> ---
>
> I'm going to change the user-space utility "ndctl" to support Hyper-V Virtual NVDIMM.
> This kernel patch is required first.
>
>  drivers/acpi/nfit/core.c   | 5 ++++-
>  drivers/acpi/nfit/nfit.h   | 6 +++++-
>  include/uapi/linux/ndctl.h | 1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 011d3db19c80..fb48cb17a519 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1840,7 +1840,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
>
>         /*
> -        * Until standardization materializes we need to consider 4
> +        * Until standardization materializes we need to consider 5
>          * different command sets.  Note, that checking for function0 (bit0)
>          * tells us if any commands are reachable through this GUID.
>          */

This comment is stale. This "HYPERV" family is the first example of
the "right" way to define a new NVDIMM command set. Lets update it to
mention the process and considerations for submitting new command sets
to UEFI (http://www.uefi.org/RFIC_LIST). The fact that there's now a
defined process is a step forward from when this comment was initially
written. Also, the fact that the process encourages "adopt" vs
"supersede" addresses the main concern about vendor-specific
command-set proliferation.

> @@ -1865,6 +1865,8 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>                         dsm_mask &= ~(1 << 8);
>         } else if (nfit_mem->family == NVDIMM_FAMILY_MSFT) {
>                 dsm_mask = 0xffffffff;
> +       } else if (nfit_mem->family == NVDIMM_FAMILY_HYPERV) {
> +               dsm_mask = 0x1f;

Just a note that starting with commit 5e9e38d0db1d "acpi/nfit: Block
function zero DSMs", bit0 in this mask will be cleared to ensure that
only the kernel has the ability to probe for supported DSM functions.
