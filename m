From: Len Brown <lenb@kernel.org>
Subject: Notify(0x88) (was Re: Asus V1j)
Date: Mon, 26 Mar 2007 00:32:46 -0400
Message-ID: <200703260032.46355.lenb@kernel.org>
References: <46051CEE.4030402@o2.pl> <200703241415.04656.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41563 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933586AbXCZElB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Mar 2007 00:41:01 -0400
In-Reply-To: <200703241415.04656.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: acpi4asus-user@lists.sourceforge.net, Szymon Olko <szymonolko@o2.pl>, linux-acpi@vger.kernel.org


> > 1. In /proc/acpi/events few keys which looks normal in DSDT are not
> > reported. I found that all of them have code bigger than 0x80. I founded
> > those lines and changed them to return codes below 0x80 (to ones that
> > are not used) and that solved problem. I did not have time to look into
> > acpi source code and maybe my solution is not the best way to do it, and
> > maybe not solves the problem, but works for me.
> > Example:
> >
> >     - F2 wifi button
> >     //Notify (\_SB.ATKD, 0x88)
> >     Notify (\_SB.ATKD, 0x56)
> >
> > The only exception is sleep button F1 but it is notified not to
> > \_SB.ATKD but to \_SB.SLPB and is processed by buttons module.
> >
> > Notify (\_SB.SLPB, 0x80)
> >
> > Is it a bug or a feature that codes over 0x80 are not reported?
> I don't know :/ So, let's ask linux-acpi@vger.kernel.org

According to the ACPI spec, section 5.6.3 "Device Object Notifications"
0-7f common for all devices
80-bf device specific
c0-ff vendor specific

so I think that what happens to codes of 80 and above should
depend on the device driver that is bound to the device
that handles the notify.

I'll venture that SLPB is the sleep button, and the standard button driver
is already bound to handle that one.

-Len
