From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] nfit: add Microsoft NVDIMM DSM command set to white list
Date: Sun, 19 Jun 2016 19:59:20 +0200
Message-ID: <20160619175920.GA12470@xo-6d-61-c0.localdomain>
References: <5cff32b5-7849-4e9d-0ba8-1f12e21814a9@gmail.com>
 <790a33bd-98e9-89c8-6667-e135ada69f80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <790a33bd-98e9-89c8-6667-e135ada69f80-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >Add the Microsoft _DSM command set to the white list of NVDIMM command sets.
> >
> >This command set is documented at https://msdn.microsoft.com/library/windows/hardware/mt604741.
> >
> >Signed-off-by: Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >---
> > drivers/acpi/nfit.c        | 9 ++++++---
> > drivers/acpi/nfit.h        | 4 ++++
> > include/uapi/linux/ndctl.h | 1 +
> > 3 files changed, 11 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> >index 2215fc8..48fc575 100644
> >--- a/drivers/acpi/nfit.c
> >+++ b/drivers/acpi/nfit.c
> >@@ -1130,11 +1130,11 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
> >     }
> >
> >     /*
> >-     * Until standardization materializes we need to consider up to 3
> >+     * Until standardization materializes we need to consider several
> >      * different command sets.  Note, that checking for function0 (bit0)
> >      * tells us if any commands are reachable through this uuid.
> >      */
> >-    for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_HPE2; i++)
> >+    for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_MSFT; i++)
> >         if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))

Time to introduce NVDIMM_FAMILY_MAX?

> >@@ -1150,7 +1150,9 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
> >         dsm_mask = 0x1fe;
> >         if (disable_vendor_specific)
> >             dsm_mask &= ~(1 << 8);
> >-    } else {
> >+    } else if (nfit_mem->family == NVDIMM_FAMILY_MSFT)
> >+        dsm_mask = 0xffffffff;
> >+    else {
> >         dev_err(dev, "unknown dimm command family\n");
> >         nfit_mem->family = -1;
> >         return force_enable_dimms ? 0 : -ENODEV;

I'd really use {} around the if (), so that it is clear what the else belongs to.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
