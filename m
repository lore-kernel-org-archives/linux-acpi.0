From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 13:34:27 -0300
Message-ID: <20130715163427.GG1074@khazad-dum.debian.net>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org>
 <7120686.9AnYUBdZSM@skinner.arch.suse.de>
 <20130715150611.GC1074@khazad-dum.debian.net>
 <4740878.DpcUBhhgIN@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58315 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933394Ab3GOQea (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 12:34:30 -0400
Content-Disposition: inline
In-Reply-To: <4740878.DpcUBhhgIN@linux-5eaq.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Mon, 15 Jul 2013, Oliver Neukum wrote:
> On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote:
> > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > I would not make it too complicated.
> > > Sticking to the latest Windows version should be enough for this one.
> > > What bad should happen if we still try to resume and fail...
> > 
> > Hmm, why was that check added in the first place?
> 
> Safety.
> 
> > If it is useless,
> > removing it for good is fine.  If it is _not_ useless, we should still do
> > the checking when not operating in windows-8 firmware mode.
> 
> Firmware will only be tested against Windows 8 pretty soon.
> We'd end up with a gigantic list of exceptions.

No, we won't.  We can query the ACPI core for the OSI compatibility level
requested by the firmware, and ignore the test only for win8.

We still have 10 to 15 years worth of users using non-win8 firmware boxes on
x86/x86-64.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
