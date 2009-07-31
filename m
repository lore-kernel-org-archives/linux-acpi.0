From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
Date: Fri, 31 Jul 2009 13:27:15 +0930 (CST)
Message-ID: <200907310357.n6V3vFSr005759@mercury.physics.adelaide.edu.au>
References: <200907301312.48132.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:48230 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165AbZGaD5p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 23:57:45 -0400
In-Reply-To: <200907301312.48132.bzolnier@gmail.com> from "Bartlomiej Zolnierkiewicz" at Jul 30, 2009 01:12:47 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com, Julia Lawall <julia@diku.dk>

Hi

> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
> > > 
> > > This takes care of the following entries from Dan's list:
> > > 
> > > drivers/platform/x86/fujitsu-laptop.c +327 set_lcd_level(13) warning: variable derefenced before check 'fujitsu'
> > > drivers/platform/x86/fujitsu-laptop.c +358 set_lcd_level_alt(13) warning: variable derefenced before check 'fujitsu'
> > 
> > I'd rather keep the test for a non-null fujitsu in there, but obviously it's
> > kind of pointless doing it after the first dereference.  Since this fixup
> > overlaps with the one previously discussed with Julia I've taken the liberty
> 
> They are on top of Julia's patch (sorry I forgot to mention it)..

Ah, right.  I was trying to work out where it fitted (that was probably the
one preceeding patch I *didn't* end up trying).

Regards
  jonathan
