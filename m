From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: driver [un]registration fixes
Date: Tue, 22 Dec 2009 09:02:40 +1030 (CST)
Message-ID: <200912212232.nBLMWe5r016214@turbo.physics.adelaide.edu.au>
References: <200912211003.22227.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754822AbZLUWcs@vger.kernel.org>
In-Reply-To: <200912211003.22227.dmitry.torokhov@gmail.com> from "Dmitry Torokhov" at Dec 21, 2009 10:03:21 AM
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Dmitry

> On Wed, Jul 29, 2009 at 10:15:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > @@ -722,22 +722,22 @@ static int acpi_fujitsu_add(struct acpi_
> >  
> >  	return result;
> >  
> > -end:
> > +err_unregister_input_dev:
> > +	input_unregister_device(input);
> >  err_free_input_dev:
> >  	input_free_device(input);
> >  err_stop:
> 
> Just noticed it scanning ACPI list. You must not use input_free_device()
> after calling input_unregister_device() since unregister likely drops the
> last reference to the device and it will get freed by input core.

So what's the correct way to deal with that in this case?  Something like

-end:
+err_unregister_input_dev:
+	input_unregister_device(input);
+	goto err_stop;
 err_free_input_dev:
 	input_free_device(input);
 err_stop:

(with a short comment to explain the goto) would circumvent the problem but
it looks ugly (at least to my eyes - I've never really liked "goto"s :-) ).

> For polled input devices you need to use both unregister and free though
> because polled device structure is not refcounted (but underlying input
> device is).

This isn't a polled input device AFAIK so this doesn't apply here, right?

Regards
  jonathan
