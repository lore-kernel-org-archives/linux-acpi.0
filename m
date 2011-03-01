From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] pnpacpi: Better format error message
Date: Tue, 1 Mar 2011 09:03:23 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858CA9C0F46@orsmsx503.amr.corp.intel.com>
References: <201103011513.40235.trenn@suse.de>
 <201103011524.50340.trenn@suse.de> <20110301162504.GC2940@helgaas.com>
 <201103011743.33975.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24017 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab1CARD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2011 12:03:27 -0500
In-Reply-To: <201103011743.33975.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bjorn@helgaas.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

- there seem to be another problem in the acpica resource handling
depths if _CRS functions do not return anything.


Strictly speaking it's illegal for _CRS to not return anything. Practically, perhaps we should repair this case to a "NULL" resource descriptor which perhaps could be defined as a resource descriptor with a single End Tag descriptor.



From: Thomas Renninger [mailto:trenn@suse.de] 
Sent: Tuesday, March 01, 2011 8:44 AM
To: Bjorn Helgaas
Cc: lenb@kernel.org; Moore, Robert; linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pnpacpi: Better format error message

On Tuesday, March 01, 2011 05:25:04 PM Bjorn Helgaas wrote:
> On Tue, Mar 01, 2011 at 03:24:50PM +0100, Thomas Renninger wrote:
> > On a system with empty _CRS method I see:
> > pnp 00:0c: can't evaluate _CRS: 12311
> > which is 0x3017, which would mean: AE_AML_INVALID_RESOURCE_TYPE
> > 
> > This patch would directly show: AE_AML_INVALID_RESOURCE_TYPE
> 
> The patch seems fine to me, but I question whether we need these
> printks at all. It seems pointless to have an empty _CRS method,
> but it does seem legal, or at least debatable, so I'm not sure
> that the message is telling us anything useful.
Theoretically the callback function passed to:
acpi_walk_resources(handle, METHOD_NAME__CRS
should get called with an empty resource string or not at all
in case _CRS can return nothing.
But in this case acpi_walk_resources fails which is worth
reporting. I could imagine other _CRS functions are not
processed anymore when acpi_walk_resources bails out with
AE_AML_INVALID_RESOURCE_TYPE on a specific _CRS function, don't know.

Summary:
- acpi_walk_resources failures should be reported (and this patch
is to do that more nicely)
- there seem to be another problem in the acpica resource handling
depths if _CRS functions do not return anything.

Thomas


> 
> Bjorn
> 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: bjorn@helgaas.com
> > CC: lenb@kernel.org
> > CC: robert.moore@intel.com
> > 
> > ---
> > Corrected email address of Bjorn.
> > 
> > drivers/pnp/pnpacpi/rsparser.c | 12 ++++++++----
> > 1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > Index: linux-2.6.37-master/drivers/pnp/pnpacpi/rsparser.c
> > ===================================================================
> > --- linux-2.6.37-master.orig/drivers/pnp/pnpacpi/rsparser.c
> > +++ linux-2.6.37-master/drivers/pnp/pnpacpi/rsparser.c
> > @@ -498,7 +498,8 @@ int pnpacpi_parse_allocated_resource(str
> > 
> > if (ACPI_FAILURE(status)) {
> > if (status != AE_NOT_FOUND)
> > - dev_err(&dev->dev, "can't evaluate _CRS: %d", status);
> > + dev_err(&dev->dev, "can't evaluate _CRS: %s",
> > + acpi_format_exception(status));
> > return -EPERM;
> > }
> > return 0;
> > @@ -809,7 +810,8 @@ int __init pnpacpi_parse_resource_option
> > 
> > if (ACPI_FAILURE(status)) {
> > if (status != AE_NOT_FOUND)
> > - dev_err(&dev->dev, "can't evaluate _PRS: %d", status);
> > + dev_err(&dev->dev, "can't evaluate _PRS: %s",
> > + acpi_format_exception(status));
> > return -EPERM;
> > }
> > return 0;
> > @@ -876,7 +878,8 @@ int pnpacpi_build_resource_template(stru
> > status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> > pnpacpi_count_resources, &res_cnt);
> > if (ACPI_FAILURE(status)) {
> > - dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
> > + dev_err(&dev->dev, "can't evaluate _CRS: %s\n",
> > + acpi_format_exception(status));
> > return -EINVAL;
> > }
> > if (!res_cnt)
> > @@ -891,7 +894,8 @@ int pnpacpi_build_resource_template(stru
> > pnpacpi_type_resources, &resource);
> > if (ACPI_FAILURE(status)) {
> > kfree(buffer->pointer);
> > - dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
> > + dev_err(&dev->dev, "can't evaluate _CRS: %s\n",
> > + acpi_format_exception(status));
> > return -EINVAL;
> > }
> > /* resource will pointer the end resource now */
> 


