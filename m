From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/8] ACPI: video - more cleanups
Date: Wed, 14 Nov 2007 12:42:06 -0500
Message-ID: <200711141242.06801.lenb@kernel.org>
References: <20071105164328.982283020@anvil.corenet.prv> <20071105165012.815613696@anvil.corenet.prv> <1195024691.1262.48.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51860 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761516AbXKNRoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 12:44:38 -0500
In-Reply-To: <1195024691.1262.48.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday 14 November 2007 02:18, Zhang Rui wrote:
> On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> > ACPI: video - more cleanups
> > 
> > Remove unneeded checks and initializations, implement proper
> > unwinding after errors in initialization code, get rid of
> > unneeded casts, adjust formatting.
> A big patch with a large number of minor cleanups/fixes.
> Thanks for your work, Dmitry.
> I'm okay with this one except the comment below.
> 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> > @@ -1772,12 +1783,11 @@ static int acpi_video_bus_stop_devices(s
> >  static void acpi_video_bus_notify(acpi_handle handle, u32 event, void
> > *data)
> >  {
> >         struct acpi_video_bus *video = data;
> > -       struct acpi_device *device = NULL;
> > +       struct acpi_device *device;
> >         struct input_dev *input;
> >         int keycode;
> > 
> > -
> > -       printk("video bus notify\n");
> > +       printk(KERN_DEBUG "video bus notify\n");
> This debug message should be removed.

wups, yes I remember that one...
I'll delete that in .24 and queue the rest of Dmitry's cleanup for .25.

thanks,
-Len
