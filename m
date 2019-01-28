From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Date: Mon, 28 Jan 2019 13:54:46 -0800
Message-ID: <CAPcyv4hGYFuW901KZ1xCR4TucgRTkqZ=SOsLOK0MpKq0BBCokw@mail.gmail.com>
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
 <PU1P153MB0169CE6B02AE7D67E25DDD89BF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <PU1P153MB0169CE6B02AE7D67E25DDD89BF960-7hHSCQUTt08p9lVGRpUb+2HfQuWdHs3hiGd9ebBGJoev3QGu/rdwKA@public.gmane.org>
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

On Mon, Jan 28, 2019 at 1:40 PM Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org> wrote:
>
> > From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Sent: Monday, January 28, 2019 1:01 PM
> >
> > Hi Dexuan,
> > Looks good. Just one update request and a note below...
> >
> > On Wed, Jan 23, 2019 at 12:51 PM Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org> wrote:
> > > ...
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -1840,7 +1840,7 @@ static int acpi_nfit_add_dimm(struct
> > acpi_nfit_desc *acpi_desc,
> > >         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
> > >
> > >         /*
> > > -        * Until standardization materializes we need to consider 4
> > > +        * Until standardization materializes we need to consider 5
> > >          * different command sets.  Note, that checking for function0
> > (bit0)
> > >          * tells us if any commands are reachable through this GUID.
> > >          */
> >
> > This comment is stale. This "HYPERV" family is the first example of
> > the "right" way to define a new NVDIMM command set. Lets update it to
> > mention the process and considerations for submitting new command sets
> > to UEFI (http://www.uefi.org/RFIC_LIST). The fact that there's now a
> > defined process is a step forward from when this comment was initially
> > written. Also, the fact that the process encourages "adopt" vs
> > "supersede" addresses the main concern about vendor-specific
> > command-set proliferation.
>
> I made the below simple change. Is this enough? Please suggest the proper
> wording/sentence, as I'm relatively new to NVDIMM, and I don't really know the
> history of the standardization process.
>
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1732,8 +1732,10 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
>
>         /*
> -        * Until standardization materializes we need to consider 4
> -        * different command sets.  Note, that checking for function0 (bit0)
> +        * New command sets should be submitted to UEFI
> +        * http://www.uefi.org/RFIC_LIST.
> +        *

How about something a bit more relevant for the code in question:

---

There are 4 "legacy" NVDIMM command sets
(NVDIMM_FAMILY_{INTEL,MSFT,HPE1,HPE2}) that were created before an EFI
working group was established to constrain this proliferation. The
nfit driver probes for the supported command set by GUID. Note, If
you're a platform developer looking to add a new command set to this
probe consider using an existing set, or otherwise seek approval to
publish the command set at http://www.uefi.org/RFIC_LIST.
