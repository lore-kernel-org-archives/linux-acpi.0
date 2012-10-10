From: Igor Murzov <e-mail@date.by>
Subject: Re: [PATCH] ACPI video: Ignore AE_AML_PACKAGE_LIMIT errors after
 _DOD evaluation.
Date: Wed, 10 Oct 2012 04:43:40 +0400
Message-ID: <20121010044340.3abe82bd@garik-laptop.linux.org>
References: <1349821146-19155-1-git-send-email-e-mail@date.by>
	<1357974.cUcUJdG05H@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward5h.mail.yandex.net ([84.201.186.23]:51104 "EHLO
	forward5h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab2JJAns (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 20:43:48 -0400
In-Reply-To: <1357974.cUcUJdG05H@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Sergey V <sftp.mtuci@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 10 Oct 2012 00:58:10 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 10 of October 2012 02:19:06 Igor Murzov wrote:
> > This should fix brightness controls on some laptops.
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=47861
> > 
> > Signed-off-by: Igor Murzov <e-mail@date.by>
> 
> Put more detials into the changelog, please.  The BZ entry linked above
> may or may not be accessible when the changelog is read by someone.
> 
> > ---
> >  drivers/acpi/video.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index 1e0a9e1..01bb58d 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -1349,8 +1349,12 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
> >  	struct acpi_device *dev;
> >  
> >  	status = acpi_video_device_enumerate(video);
> > -	if (status)
> > -		return status;
> > +	if (status) {
> > +		if (status == AE_AML_PACKAGE_LIMIT)
> > +			status = 0; /* Ignore this error */
> > +		else
> > +			return status;
> > +	}
> 
> First off, please add a comment explaining _why_ we're ignoring the error.

The problem is that i'm not sure if it's ok to ignore
AE_AML_PACKAGE_LIMIT here. Stefan Wilkens in bugzilla
claims that video module works fine on his Compaq 6720s
in spite of the fact that acpi_video_device_enumerate()
is not able to find any video device on his laptop.
This fix is just the most obvious one, not necessarily
the proper one.


> Second, what about adding just:
> 
> if (status == AE_AML_PACKAGE_LIMIT)
> 	status = 0;
> 
> before the "if (status)" check?

Ok

-- Igor

> >  
> >  	list_for_each_entry(dev, &device->children, node) {
> 
> Thanks,
> Rafael
