From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 15:36:39 -0200
Message-ID: <20080108173639.GB6182@khazad-dum.debian.net>
References: <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org> <20080108120653.GA23216@khazad-dum.debian.net> <20080108121819.GA1324@srcf.ucam.org> <20080108124820.GB23216@khazad-dum.debian.net> <1199807102.6053.31.camel@localhost.localdomain> <20080108155401.GA4954@srcf.ucam.org> <1199809771.6053.42.camel@localhost.localdomain> <20080108164928.GA6182@khazad-dum.debian.net> <1199811397.6053.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59294 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbYAHRgp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 12:36:45 -0500
Content-Disposition: inline
In-Reply-To: <1199811397.6053.55.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 08 Jan 2008, Richard Purdie wrote:
> > So be it, then.  But my request that we get a way to add the information we
> > are losing to the backlight class still stands.
> 
> The thing is does this 0-100 value have a use to userspace? Its

You can request something like "middle brightness please" (although whether
you get middle power comsumption or middle brightness is undetermined in the
ACPI spec).

> extremely device specific and can't be exported from the class in a
> generic way suggesting it should really be something exported by the
> driver itself. You still have to ask whether userspace actually needs
> this value though?

To just cycle brightness up and down, it certainly doesn't need it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
