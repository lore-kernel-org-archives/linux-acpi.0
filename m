From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: Don't send KEY_UNKNOWN for random video
 notifications
Date: Thu, 01 Apr 2010 14:57:53 +0800
Message-ID: <1270105073.24064.4488.camel@rzhang1-desktop>
References: <1260571246-24582-1-git-send-email-mjg@redhat.com>
	 <alpine.LFD.2.00.1003312057140.5062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12298 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0DAG4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Apr 2010 02:56:51 -0400
In-Reply-To: <alpine.LFD.2.00.1003312057140.5062@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-04-01 at 08:57 +0800, Len Brown wrote:
> applied to acpi-test -- looking for ack from rui, the driver maintainer
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> On Fri, 11 Dec 2009, Matthew Garrett wrote:
> 
> > I have a machine here that's sending 0xD1 notifications on the video
> > device once every second or so. I have no idea why (it's a prototype,
> > it may be broken), but sending KEY_UNKNOWN is unhelpful and results in
> > the console becoming unusable. Let's not report keys unless we have
> > something useful to say about them.
> > 
Hi, Matthew,

can you attach the acpidump of your laptop please?

thanks,
rui


> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > ---
> >  drivers/acpi/video.c |   29 ++++++++++++++++-------------
> >  1 files changed, 16 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index 05dff63..655183c 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -2100,7 +2100,7 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
> >  {
> >  	struct acpi_video_bus *video = acpi_driver_data(device);
> >  	struct input_dev *input;
> > -	int keycode;
> > +	int keycode = 0;
> >  
> >  	if (!video)
> >  		return;
> > @@ -2136,17 +2136,19 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
> >  		break;
> >  
> >  	default:
> > -		keycode = KEY_UNKNOWN;
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  				  "Unsupported event [0x%x]\n", event));
> >  		break;
> >  	}
> >  
> >  	acpi_notifier_call_chain(device, event, 0);
> > -	input_report_key(input, keycode, 1);
> > -	input_sync(input);
> > -	input_report_key(input, keycode, 0);
> > -	input_sync(input);
> > +
> > +	if (keycode) {
> > +		input_report_key(input, keycode, 1);
> > +		input_sync(input);
> > +		input_report_key(input, keycode, 0);
> > +		input_sync(input);
> > +	}
> >  
> >  	return;
> >  }
> > @@ -2157,7 +2159,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
> >  	struct acpi_device *device = NULL;
> >  	struct acpi_video_bus *bus;
> >  	struct input_dev *input;
> > -	int keycode;
> > +	int keycode = 0;
> >  
> >  	if (!video_device)
> >  		return;
> > @@ -2198,17 +2200,19 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
> >  		keycode = KEY_DISPLAY_OFF;
> >  		break;
> >  	default:
> > -		keycode = KEY_UNKNOWN;
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  				  "Unsupported event [0x%x]\n", event));
> >  		break;
> >  	}
> >  
> >  	acpi_notifier_call_chain(device, event, 0);
> > -	input_report_key(input, keycode, 1);
> > -	input_sync(input);
> > -	input_report_key(input, keycode, 0);
> > -	input_sync(input);
> > +
> > +	if (keycode) {
> > +		input_report_key(input, keycode, 1);
> > +		input_sync(input);
> > +		input_report_key(input, keycode, 0);
> > +		input_sync(input);
> > +	}
> >  
> >  	return;
> >  }
> > @@ -2299,7 +2303,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
> >  	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
> >  	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
> >  	set_bit(KEY_DISPLAY_OFF, input->keybit);
> > -	set_bit(KEY_UNKNOWN, input->keybit);
> >  
> >  	error = input_register_device(input);
> >  	if (error)
> > -- 
> > 1.6.5.2
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


