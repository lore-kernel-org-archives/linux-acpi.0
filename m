From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fujitsu-laptop: driver [un]registration fixes
Date: Mon, 21 Dec 2009 14:46:32 -0800
Message-ID: <200912211446.32380.dmitry.torokhov@gmail.com>
References: <200912212232.nBLMWe5r016214@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:48908 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbZLUWqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 17:46:45 -0500
In-Reply-To: <200912212232.nBLMWe5r016214@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jonathan,

On Monday 21 December 2009 02:32:40 pm Jonathan Woithe wrote:
> Hi Dmitry
> 
> > On Wed, Jul 29, 2009 at 10:15:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > @@ -722,22 +722,22 @@ static int acpi_fujitsu_add(struct acpi_
> > >
> > >  	return result;
> > >
> > > -end:
> > > +err_unregister_input_dev:
> > > +	input_unregister_device(input);
> > >  err_free_input_dev:
> > >  	input_free_device(input);
> > >  err_stop:
> >
> > Just noticed it scanning ACPI list. You must not use input_free_device()
> > after calling input_unregister_device() since unregister likely drops the
> > last reference to the device and it will get freed by input core.
> 
> So what's the correct way to deal with that in this case?  Something like
> 
> -end:
> +err_unregister_input_dev:
> +	input_unregister_device(input);
> +	goto err_stop;
>  err_free_input_dev:
>  	input_free_device(input);
>  err_stop:
> 
> (with a short comment to explain the goto) would circumvent the problem but
> it looks ugly (at least to my eyes - I've never really liked "goto"s :-) ).

Just do "input = NULL;" after calling  input_unregister_device() -
input_free_device() is like kfree() and will happily ignore passed NULL 
pointers.

Or rearrange the code to register device last, when everything is ready.

> 
> > For polled input devices you need to use both unregister and free though
> > because polled device structure is not refcounted (but underlying input
> > device is).
> 
> This isn't a polled input device AFAIK so this doesn't apply here, right?

Right, it was more of a general statement so I don't get bunch of patches 
removing input_free_polled_device() after calls to
input_unregister_polled_device() ;)

-- 
Dmitry
