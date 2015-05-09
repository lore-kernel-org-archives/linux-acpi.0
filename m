From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 5/7] Xen / ACPI / processor: Remove unneeded NULL
 check in xen_acpi_processor_enable()
Date: Sat, 9 May 2015 18:06:42 -0400
Message-ID: <20150509220642.GB27485@l.oracle.com>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
 <1430793998-21631-6-git-send-email-hanjun.guo@linaro.org>
 <alpine.DEB.2.02.1505051128400.2640@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48035 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbbEIWHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2015 18:07:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1505051128400.2640@kaball.uk.xensource.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, David Vrabel <david.vrabel@citrix.com>

On Tue, May 05, 2015 at 11:29:05AM +0100, Stefano Stabellini wrote:
> CC'ing Konrad and David.
> 
> On Tue, 5 May 2015, Hanjun Guo wrote:
> > Before xen_acpi_processor_enable() is called, struct acpi_processor *pr is
> > allocated in xen_acpi_processor_add() and checked if it's NULL, so no need
> > to check again when passed to xen_acpi_processor_enable(), just remove it.

Sounds right.

> > 
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > CC: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  drivers/xen/xen-acpi-cpuhotplug.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/xen/xen-acpi-cpuhotplug.c b/drivers/xen/xen-acpi-cpuhotplug.c
> > index 5a62aa0..f4a3694 100644
> > --- a/drivers/xen/xen-acpi-cpuhotplug.c
> > +++ b/drivers/xen/xen-acpi-cpuhotplug.c
> > @@ -46,13 +46,7 @@ static int xen_acpi_processor_enable(struct acpi_device *device)
> >  	unsigned long long value;
> >  	union acpi_object object = { 0 };
> >  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
> > -	struct acpi_processor *pr;
> > -
> > -	pr = acpi_driver_data(device);
> > -	if (!pr) {
> > -		pr_err(PREFIX "Cannot find driver data\n");
> > -		return -EINVAL;
> > -	}
> > +	struct acpi_processor *pr = acpi_driver_data(device);
> >  
> >  	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
> >  		/* Declared with "Processor" statement; match ProcessorID */
> > -- 
> > 1.9.1
> > 
