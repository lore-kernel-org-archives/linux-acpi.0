From: "Kani, Toshimitsu" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: RE: [PATCH v2 2/2] acpi/nfit: Issue Start ARS to retrieve existing
 records
Date: Sat, 17 Jun 2017 00:47:03 +0000
Message-ID: <CS1PR84MB01046CCC9661AB0E2EF8B3E682C60@CS1PR84MB0104.NAMPRD84.PROD.OUTLOOK.COM>
References: <20170608183658.24731-1-toshi.kani@hpe.com>
 <20170608183658.24731-3-toshi.kani@hpe.com>
 <CAPcyv4j8vjw9arcNyHrszDNbX5xWzBOtTB5cS81rY9H_tJzhug@mail.gmail.com>
 <DF4PR84MB01051FBBC0ADDFF41A9534F282C60@DF4PR84MB0105.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4h4bkkrb0_6C0DiNGb0=LYFxqm0QhN15BsS4uyO+mNcpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4h4bkkrb0_6C0DiNGb0=LYFxqm0QhN15BsS4uyO+mNcpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> On Fri, Jun 16, 2017 at 5:01 PM, Kani, Toshimitsu <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> >> > --- a/drivers/acpi/nfit/core.c
> >> > +++ b/drivers/acpi/nfit/core.c
> >> > @@ -1031,7 +1031,7 @@ static ssize_t scrub_store(struct device *dev,
> >> >         if (nd_desc) {
> >> >                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> >> >
> >> > -               rc = acpi_nfit_ars_rescan(acpi_desc);
> >> > +               rc = acpi_nfit_ars_rescan(acpi_desc, 0);
> >> >         }
> >> >         device_unlock(dev);
> >> >         if (rc)
> >> > @@ -2057,6 +2057,10 @@ static int ars_start(struct acpi_nfit_desc
> >> *acpi_desc, struct nfit_spa *nfit_spa
> >> >                 ars_start.type = ND_ARS_VOLATILE;
> >> >         else
> >> >                 return -ENOTTY;
> >> > +       if (nfit_spa->ars_prev_data) {
> >> > +               ars_start.flags |= ND_ARS_RETURN_PREV_DATA;
> >> > +               nfit_spa->ars_prev_data = 0;
> >> > +       }
> >>
> >> I'd rather you plumb a new 'flags' parameter all the way through from
> >> acpi_nfit_ars_rescan() to ars_start() rather than carrying this as a
> >> property of nfit_spa.
> >
> > Yes, I wanted to carry 'flags' all the way, but since acpi_nfit_ars_rescan()
> > calls acpi_nfit_scrub() via acpi_desc->work, all info needs to be marshalled
> > into struct acpi_nfit_desc.  Using nfit_spa allows a request to be carried as
> > per-spa basis...
> 
> Ah ok, but I still think it does not belong to a spa. This is control
> / context information for the workqueue and that belongs with
> acpi_nfit_desc. It think it's fine if all spas get re-scrubbed with
> the "prev_data" flag in the the notification case.

Sounds good.  I will add the flags info to acpi_nfit_desc and update
this patch.

Thanks!
-Toshi
