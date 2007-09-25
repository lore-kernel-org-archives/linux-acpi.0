From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [lm-sensors] [PATCH 8/9] ACPI: thinkpad-acpi: use a separate
	platform device for hwmon and name it
Date: Tue, 25 Sep 2007 13:53:05 -0300
Message-ID: <20070925165305.GB20847@khazad-dum.debian.net>
References: <1190557457539-git-send-email-hmh@hmh.eng.br> <11905574583315-git-send-email-hmh@hmh.eng.br> <20070924171128.19f91009@hyperion.delvare> <20070925023958.GA15111@khazad-dum.debian.net> <20070925180006.74e06c4e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41771 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756232AbXIYQxL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 12:53:11 -0400
Content-Disposition: inline
In-Reply-To: <20070925180006.74e06c4e@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, LM Sensors ML <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

On Tue, 25 Sep 2007, Jean Delvare wrote:
> > > > Cc: LM Sensors ML <lm-sensors@lm-sensors.org>
> > > 
> > > It's pretty pointless to have a mailing list listed here, as the list
> > > itself can't ack nor nack your patch.
> > 
> > People in the list certainly can :-)  But if you'd rather I cc you directly,
> > I will change it.
> 
> Actually you'd rather Cc the hwmon subsystem maintainer, if anyone, and
> that's not me. But I was really only commenting on the Cc: in the
> header of the patch, not the Cc: when sending the patch. Cc'ing the
> lm-sensors list when sending your patch was of course correct. Just
> writing it down in the patch header doesn't make sense.

That's how I track down whom I need to CC.  These patches often sit on my
queues for a while before I submit them anywhere, so I'd have to actually
place the maintainers *and* the list in the patch headers.  The patches are
sent in patch sets, and often have different CCs on individual patches.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
