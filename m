From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] ACPI: compal-laptop: use rfkill switch subsystem
Date: Thu, 3 Jul 2008 09:54:28 -0300
Message-ID: <20080703125428.GE17823@khazad-dum.debian.net>
References: <20080702214524.2ba4a001@debian> <20080703021433.GC20410@khazad-dum.debian.net> <20080703070528.2f0603a5@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60916 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753340AbYGCMyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 08:54:32 -0400
Content-Disposition: inline
In-Reply-To: <20080703070528.2f0603a5@debian>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Cc: linux-netdev@vger.kernel.org, Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org

On Thu, 03 Jul 2008, Cezary Jackiewicz wrote:
> Dnia 2008-07-02, o godz. 23:14:33
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> napisa?(a):
> > BTW, it is a good idea to Cc linux-wireless on rfkill patches, and you
> > *really* should be CCing the rfkill maintainer on any patches dealing with
> > rfkill IMHO.  That way, you get more reviews, rfkill isn't (unfortunately)
> > easy to use.
> 
> Is there any reason why rfkill_unregister switches off radio rather than 
> leaving it in the current status?

Probably the same reason why backlight powers off the backlight, etc.  We
basically try to power down and secure what we can when we are going out and
locking the door ;-)

Ivo?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
