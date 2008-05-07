From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 22:13:54 -0300
Message-ID: <20080507011354.GA8163@khazad-dum.debian.net>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac> <1210065811.12668.1.camel@sli10-desk.sh.intel.com> <20080506151846.GA22828@khazad-dum.debian.net> <1210122279.27316.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39550 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753649AbYEGBN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 21:13:57 -0400
Content-Disposition: inline
In-Reply-To: <1210122279.27316.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

On Wed, 07 May 2008, Shaohua Li wrote:
> On Tue, 2008-05-06 at 12:18 -0300, Henrique de Moraes Holschuh wrote:
> > On Tue, 06 May 2008, Shaohua Li wrote:
> > > The bay driver is duplicated with libata, I thought we should delete it.
> > > See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526
> > 
> > The bay driver is currently useless, BUT it should handle a lot of stuff
> > libata won't, such as bay batteries, bay floppies, and anything else in
> > a bay that is not a hard disk.
> > 
> > The fact that the driver currently looks only after disks is just a bug.
> > It should, in fact, bind to any ejectable device not already handled by
> > a different driver.
> Isn't this the job of acpi dock driver?

No, but I actually fail to see why do we even care about the difference
from a dock to a bay.  Dock *could* be made to handle both.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
