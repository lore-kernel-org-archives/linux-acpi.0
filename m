From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] acpi: nfit: Add support for hotplug
Date: Mon, 12 Oct 2015 18:35:13 -0600
Message-ID: <1444696513.20657.16.camel@hpe.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	 <1444254577-23744-4-git-send-email-vishal.l.verma@intel.com>
	 <CAPcyv4gqoGho8HNmOQM_H88vyKVHguze+uYuyFoxBUiGgB7aDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6225.austin.hp.com ([15.73.96.126]:35071 "EHLO
	g1t6225.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbJMAiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 20:38:50 -0400
Received: from g1t6223.austin.hp.com (g1t6223.austin.hp.com [15.73.96.124])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g1t6225.austin.hp.com (Postfix) with ESMTPS id 5343682B1
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2015 00:38:50 +0000 (UTC)
In-Reply-To: <CAPcyv4gqoGho8HNmOQM_H88vyKVHguze+uYuyFoxBUiGgB7aDA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On Fri, 2015-10-09 at 12:44 -0700, Dan Williams wrote:
> [ adding Robert and Toshi ]
> 
> On Wed, Oct 7, 2015 at 2:49 PM, Vishal Verma <vishal.l.verma@intel.com>
> wrote:
 :
> > @@ -242,9 +246,13 @@ static bool add_memdev(struct acpi_nfit_desc
> > *acpi_desc,
> >                 struct acpi_nfit_memory_map *memdev)
> >  {
> >         struct device *dev = acpi_desc->dev;
> > -       struct nfit_memdev *nfit_memdev = devm_kzalloc(dev,
> > -                       sizeof(*nfit_memdev), GFP_KERNEL);
> > +       struct nfit_memdev *nfit_memdev;
> > +
> > +       list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list)
> > +               if (memcmp(nfit_memdev->memdev, memdev,
> > sizeof(*memdev)) == 0)
> > +                       return true;
> 
> I'm wondering if we need to be cognizant of flag changes here.
> Robert, Toshi are you expecting that the flags of an existing memory
> device entry will be updated by the this notification mechanism?

This patch-set can focus on the simple hot-add case for now.  We think bit
[4] of the flags, smart and health event bit, could be updated on an
existing memory device when such an event has occurred during runtime, but
it may require clarification to the spec since the bit is currently defined
as "SMART and health events prior to OSPM handoff" (which does not make
sense for _FIT).  We will need to support other updates in the flags, but
we will first need to understand what the OS should do in such scenarios.

> > @@ -811,6 +835,8 @@ static int acpi_nfit_register_dimms(struct
> > acpi_nfit_desc *acpi_desc)
> >                          */
> >                         dev_err(acpi_desc->dev, "duplicate DCR
> > detected: %s\n",
> >                                         nvdimm_name(nvdimm));
> > +                       /* TODO Do we need the warning? */
> > +                       dimm_count++;
> 
> Robert, comments?

Yes, this warning message should be removed.

Thanks,
-Toshi
