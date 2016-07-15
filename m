From: Haozhong Zhang <haozhong.zhang@intel.com>
Subject: Re: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Fri, 15 Jul 2016 16:12:12 +0800
Message-ID: <20160715081212.l3rfkk2wvh7bjdo5@hz-desktop>
References: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160715075515.ufwwvwngteqyovsk@hz-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:33720 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbcGOIMP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jul 2016 04:12:15 -0400
Content-Disposition: inline
In-Reply-To: <20160715075515.ufwwvwngteqyovsk@hz-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Xiao Guangrong <guangrong.xiao@intel.com>

On 07/15/16 15:55, Haozhong Zhang wrote:
> On 07/14/16 20:28, Dan Williams wrote:
> > acpi_evaluate_object() allocates memory. Free the buffer allocated
> > during acpi_nfit_add().
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Reported-by: Xiao Guangrong <guangrong.xiao@intel.com>
> > Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/acpi/nfit.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> > index 0497175ee6cb..008dbaaa2b75 100644
> > --- a/drivers/acpi/nfit.c
> > +++ b/drivers/acpi/nfit.c
> > @@ -2414,12 +2414,15 @@ static int acpi_nfit_add(struct acpi_device *adev)
> >  			acpi_desc->nfit =
> >  				(struct acpi_nfit_header *)obj->buffer.pointer;
> >  			sz = obj->buffer.length;
> > +			rc = acpi_nfit_init(acpi_desc, sz);
> >  		} else
> >  			dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
> >  				 __func__, (int) obj->type);
> 
> 'rc' is not set in this path, so it maybe used uninitialized by 'if (rc)' below.
> Should we set it to a non-zero value in this path?

'rc' should be set to 0 here, as what patch 2 does. Sorry for my mistake.

Haozhong
