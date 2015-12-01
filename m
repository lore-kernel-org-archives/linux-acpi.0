From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ACPI: scan add call to probe amba devices
Date: Tue, 1 Dec 2015 12:16:51 +0000
Message-ID: <20151201121627.GA4036@xora-haswell.xora.org.uk>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
 <1443609530-21524-3-git-send-email-graeme.gregory@linaro.org>
 <8504062.kEYB5C4QA7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55525 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756007AbbLAMQx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 07:16:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 42C7020E76
	for <linux-acpi@vger.kernel.org>; Tue,  1 Dec 2015 07:16:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <8504062.kEYB5C4QA7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>

On Tue, Dec 01, 2015 at 03:16:53AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, September 30, 2015 11:38:49 AM Graeme Gregory wrote:
> > Call the amba device creation function in the default enumeration path,
> > this is the same location platform devices are probed.
> 
> First, I'm sorry for the glacially slow response here.
> 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > ---
> >  drivers/acpi/scan.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index f834b8c..aa3184e 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1633,8 +1633,10 @@ static void acpi_default_enumeration(struct acpi_device *device)
> >  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> >  			       &is_spi_i2c_slave);
> >  	acpi_dev_free_resource_list(&resource_list);
> > -	if (!is_spi_i2c_slave)
> > +	if (!is_spi_i2c_slave) {
> > +		acpi_create_amba_device(device);
> 
> Do you really have to add this here?
> 
> It would be much cleaner to use a new scan handler instead.
> 

I can certainly look into doing that, I cannot from a quick scan see any
reason not too. I just didn't think of it.

Graeme

