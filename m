From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.24-rc1-git] properly hookup acpi buttons to driver model tree
Date: Tue, 6 Nov 2007 13:28:36 -0800
Message-ID: <200711061328.36905.david-b@pacbell.net>
References: <200711061207.46939.david-b@pacbell.net> <d120d5000711061245h9e69d6ck744a5ba19c02d322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:21764 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754501AbXKFV2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2007 16:28:41 -0500
In-Reply-To: <d120d5000711061245h9e69d6ck744a5ba19c02d322@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Andrey Borzenkov <arvidjaar@mail.ru>

On Tuesday 06 November 2007, Dmitry Torokhov wrote:
> Hi David,
> 
> On Nov 6, 2007 3:07 PM, David Brownell <david-b@pacbell.net> wrote:
> > --- g26.orig/drivers/acpi/button.c      2007-11-04 11:47:40.000000000 -0800
> > +++ g26/drivers/acpi/button.c   2007-11-04 11:48:50.000000000 -0800
> > @@ -395,6 +395,7 @@ static int acpi_button_add(struct acpi_d
> >                error = -ENOMEM;
> >                goto err_free_button;
> >        }
> > +       input->cdev.dev = &device->dev;
> >
> 
> Don't use cdev, I will be gone as of 2.6.25. Use input_dev->dev.parent
> please. Actually I sent a bunch of patches to ACPI/video to Len/ACPI
> list a couple of days ago.

Right now I'm just clearing out an old patch , which has been
sitting around since very early this year (ISTR, January) ...
I was kind of surprised to see this bug still exists.

So, for 2.6.24-final, what's the resolution?  Is someone else's
patch going to resolve this issue?  Or will it not be resolved?
I have no idea what patch you mean, and don't subscribe to the
ACPI list...

- Dave
