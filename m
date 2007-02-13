From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output
	validation
Date: Tue, 13 Feb 2007 08:59:08 +0000
Message-ID: <1171357148.6028.5.camel@localhost.localdomain>
References: <20070212210107.GA5577@inferi.kami.home>
	 <200702122355.56336.lenb@kernel.org>
	 <49660.85.47.20.193.1171356477.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:52332 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbXBMJAd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 04:00:33 -0500
In-Reply-To: <49660.85.47.20.193.1171356477.squirrel@picard.linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 2007-02-13 at 09:47 +0100, Mattia Dongili wrote:
> On Tue, February 13, 2007 5:55 am, Len Brown said:
> > On Monday 12 February 2007 16:01, Mattia Dongili wrote:
> >> allows consistency between the sony-laptop
> >> specific 'brightness_default' and the backlight subsystem 0-based
> >> 'brightness'.
> >
> > Why do we need to have "sony-laptop specific 'brightness_default'" --
> > is that a shortcoming of the backlight subsystem?
> 
> It depends on how do you see it :)
> brightness_default is the value that brightness will have at the next (and
> later) reboot and it's currently handled as a platform_device attribute.
> It would be nice anyway if one such attribute could be added to the
> backlight subsystem (I'll provide patches - added rpurdie to the Cc list)
> in order to standardize its behavior/interface.

The backlight class doesn't really have any reason to know anything
about defaults. The current behaviour is that if you want it at a
certain 'default' brightness, you set it to this after you register the
device. Some devices don't want the brightness changed and want to use
whatever it was set to originally. In the case of some other drivers,
you can't read the brightness value.

With any patches, please keep in mind the changes in
http://git.o-hand.com/?p=linux-rpurdie-backlight;a=shortlog;h=for-mm as
I've separated out the ops functions from the actual device specific
data.

Regards,

Richard

