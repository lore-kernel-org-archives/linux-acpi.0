From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [patch 05/12] fujitsu-laptop: fix tests of acpi_evaluate_integer()
Date: Wed, 25 Nov 2009 16:59:21 +1030 (CST)
Message-ID: <200911250629.nAP6TL2u009406@turbo.physics.adelaide.edu.au>
References: <alpine.LFD.2.00.0911250057060.4058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:45684 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751976AbZKYGjX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 01:39:23 -0500
In-Reply-To: <alpine.LFD.2.00.0911250057060.4058@localhost.localdomain> from "Len Brown" at Nov 25, 2009 12:58:44 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, roel.kluin@gmail.com, jwoithe@physics.adelaide.edu.au

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
> as status is a positive number, shouldn't we be returning something like 
> -1 here on failure, rather than status?

These functions are called via the backlight_ops structure by the standard
backlight class framework and it seems, from a real quick look, that the API
treats numbers >=0 as valid data.  So something like this (untested, off the
top of my head) might be more appropriate:

diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return drivers/platform/x86/fujitsu-laptop.c
--- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return
+++ a/drivers/platform/x86/fujitsu-laptop.c
@@ -376,7 +376,7 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return -status;
 
      fujitsu->brightness_level = state & 0x0fffffff;
@@ -398,7 +398,7 @@ static int get_max_brightness(void)
 
	status =
	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return -status;
 
 	fujitsu->max_brightness = state;


Otherwise "return -1;" would be fine by me.  My only reason for going with
"-status" is that it might give some clue as to what went wrong.  Thoughts?

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan
