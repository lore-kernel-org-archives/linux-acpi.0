From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [patch 3/9] fujitsu-laptop: fix tests of acpi_evaluate_integer()
Date: Wed, 23 Dec 2009 09:15:11 +1030 (CST)
Message-ID: <200912222245.nBMMjBWo002395@turbo.physics.adelaide.edu.au>
References: <alpine.LFD.2.00.0912221515560.5153@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:42257 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbZLVWqL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2009 17:46:11 -0500
In-Reply-To: <alpine.LFD.2.00.0912221515560.5153@localhost.localdomain> from "Len Brown" at Dec 22, 2009 03:28:45 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, roel.kluin@gmail.com, jwoithe@physics.adelaide.edu.au

> NAK, this patch is incorrect
> 
> On Mon, 21 Dec 2009, akpm@linux-foundation.org wrote:
> 
> > From: Roel Kluin <roel.kluin@gmail.com>
> > 
> > The wrong test was used acpi_status status is unsigned.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/platform/x86/fujitsu-laptop.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return drivers/platform/x86/fujitsu-laptop.c
> > --- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return
> > +++ a/drivers/platform/x86/fujitsu-laptop.c
> > @@ -376,7 +376,7 @@ static int get_lcd_level(void)
> >  
> >  	status =
> >  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> > -	if (status < 0)
> > +	if (ACPI_FAILURE(status))
> >  		return status;
> 
> backlight_show_actual_brightness() will stuff this return value in sysfs
> no matter what you return.
> 
> I'm sure we don't want to return an acpi_status.
> 
> Looks like it should return 0 on failure, like thinkpad does.

Fair enough.  At the time this patch was first proposed there was some
confusion as to what the return value should be.  We ended up taking a punt
and got it wrong.

> >  	fujitsu->brightness_level = state & 0x0fffffff;
> > @@ -398,7 +398,7 @@ static int get_max_brightness(void)
> >  
> >  	status =
> >  	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
> > -	if (status < 0)
> > +	if (ACPI_FAILURE(status))
> >  		return status;
> 
> needs to be return -1, since show_max_brightness is testing for < 0.

Same here.

Thanks for the feedback; I'll do up a revised patch in a sec.

Regards
  jonathan
