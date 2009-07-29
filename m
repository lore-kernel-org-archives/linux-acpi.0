From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 6/12] drivers/platform/x86: Correct redundant test
Date: Wed, 29 Jul 2009 04:22:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907290422121.16543@ask.diku.dk>
References: <200907290050.n6T0oL0o024740@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:39609 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930AbZG2CYK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 22:24:10 -0400
In-Reply-To: <200907290050.n6T0oL0o024740@mercury.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, 29 Jul 2009, Jonathan Woithe wrote:

> Hi guys
> 
> > Julia Lawall wrote:
> > > [...]
> > > ---
> > >  drivers/platform/x86/fujitsu-laptop.c          |    3 ---
> > >  1 files changed, 0 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> > > index 218b9a1..5306901 100644
> > > --- a/drivers/platform/x86/fujitsu-laptop.c
> > > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > > @@ -745,9 +745,6 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
> > >  
> > >  	fujitsu = acpi_driver_data(device);
> > >  
> > > -	if (!device || !acpi_driver_data(device))
> > > -		return -EINVAL;
> > > -
> > 
> > Shouldn't this still do a:
> > 
> >    if (!fujitsu)
> >      return -EINVAL;
> > 
> > to avoid dereferencing a NULL pointer below?
> 
> Hmm, yes it should.  Well spotted.  And I'm not certain how the duplicate
> test on "device" got in there in the first place.  I suspect it came about
> due to some structural changes made a few versions ago and I failed to
> notice that the second check became redundant.

If you are going to check fujitsu afterwards, then I think there is no 
need to test the result of acpi_driver_data before.

julia

 
> So, combining this with the above patch we should instead do
> 
> Signed-off-by: jwoithe@physics.adelaide.edu.au <Jonathan Woithe>
> 
> --- a/drivers/platform/x86/fujitsu-laptop.c	2009-06-12 19:51:45.333234000 +0930
> +++ b/drivers/platform/x86/fujitsu-laptop.c	2009-07-29 10:14:30.610249941 +0930
> @@ -745,7 +745,7 @@ static int acpi_fujitsu_remove(struct ac
>  
>  	fujitsu = acpi_driver_data(device);
>  
> -	if (!device || !acpi_driver_data(device))
> +	if (!fujitsu)
>  		return -EINVAL;
>  
>  	fujitsu->acpi_handle = NULL;
> 
> Regards
>   jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
