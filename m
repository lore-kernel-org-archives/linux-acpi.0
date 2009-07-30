From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
Date: Thu, 30 Jul 2009 13:12:47 +0200
Message-ID: <200907301312.48132.bzolnier@gmail.com>
References: <200907300743.n6U7hnK6000821@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f210.google.com ([209.85.220.210]:32922 "EHLO
	mail-fx0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZG3MLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 08:11:03 -0400
In-Reply-To: <200907300743.n6U7hnK6000821@mercury.physics.adelaide.edu.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com, Julia Lawall <julia@diku.dk>


Hi,

On Thursday 30 July 2009 09:43:49 Jonathan Woithe wrote:
> Hi Bart
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
> > 
> > This takes care of the following entries from Dan's list:
> > 
> > drivers/platform/x86/fujitsu-laptop.c +327 set_lcd_level(13) warning: variable derefenced before check 'fujitsu'
> > drivers/platform/x86/fujitsu-laptop.c +358 set_lcd_level_alt(13) warning: variable derefenced before check 'fujitsu'
> 
> I'd rather keep the test for a non-null fujitsu in there, but obviously it's
> kind of pointless doing it after the first dereference.  Since this fixup
> overlaps with the one previously discussed with Julia I've taken the liberty

They are on top of Julia's patch (sorry I forgot to mention it)..
