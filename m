From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 6/12] drivers/platform/x86: Correct redundant test
Date: Wed, 29 Jul 2009 12:12:37 +0930 (CST)
Message-ID: <200907290242.n6T2gbP1025488@mercury.physics.adelaide.edu.au>
References: <Pine.LNX.4.64.0907290422121.16543@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:54586 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756115AbZG2CnH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 22:43:07 -0400
In-Reply-To: <Pine.LNX.4.64.0907290422121.16543@ask.diku.dk> from "Julia Lawall" at Jul 29, 2009 04:22:51 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Paulo Marques <pmarques@grupopie.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Julia

> > > Julia Lawall wrote:
> > > > [...]
> > > > ---
> > > >  drivers/platform/x86/fujitsu-laptop.c          |    3 ---
> > > >  1 files changed, 0 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> > > > index 218b9a1..5306901 100644
> > > > --- a/drivers/platform/x86/fujitsu-laptop.c
> > > > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > > > @@ -745,9 +745,6 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
> > > >  
> > > >  	fujitsu = acpi_driver_data(device);
> > > >  
> > > > -	if (!device || !acpi_driver_data(device))
> > > > -		return -EINVAL;
> > > > -
> > > 
> > > Shouldn't this still do a:
> > > 
> > >    if (!fujitsu)
> > >      return -EINVAL;
> > > 
> > > to avoid dereferencing a NULL pointer below?
> > 
> > Hmm, yes it should.  Well spotted.  And I'm not certain how the duplicate
> > test on "device" got in there in the first place.  I suspect it came about
> > due to some structural changes made a few versions ago and I failed to
> > notice that the second check became redundant.
> 
> If you are going to check fujitsu afterwards, then I think there is no 
> need to test the result of acpi_driver_data before.

Yes, of course.  I'll wake up soon, promise!

So we're left with this.

Signed-off-by: jwoithe@physics.adelaide.edu.au <Jonathan Woithe>

--- a/drivers/platform/x86/fujitsu-laptop.c	2009-06-12 19:51:45.333234000 +0930
+++ b/drivers/platform/x86/fujitsu-laptop.c	2009-07-29 12:10:11.504901871 +0930
@@ -740,12 +740,12 @@ static int acpi_fujitsu_remove(struct ac
 {
        struct fujitsu_t *fujitsu = NULL;
 
-	if (!device || !acpi_driver_data(device))
+	if (!device)
 		return -EINVAL;
 
 	fujitsu = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
+	if (!fujitsu)
 		return -EINVAL;
 
	fujitsu->acpi_handle = NULL;


Regards
  jonathan
