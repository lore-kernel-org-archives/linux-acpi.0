From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: Laptop fan on Acer 4061NWLCi
Date: Mon, 3 Apr 2006 18:45:54 +0200
Message-ID: <20060403164554.GB13970@poupinou.org>
References: <794f042d0604030408k3073a44dg70255e3342f4a2db@mail.gmail.com> <20060403134138.GA13970@poupinou.org> <794f042d0604030856t465a822fub4449c02e1a3456e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:39996 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1751544AbWDCQp7
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Apr 2006 12:45:59 -0400
Content-Disposition: inline
In-Reply-To: <794f042d0604030856t465a822fub4449c02e1a3456e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Saurabh Nanda <saurabhnanda@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Apr 03, 2006 at 09:26:28PM +0530, Saurabh Nanda wrote:
> Hi,
> 
> > Yes, only problem is to define _ON and _OFF methods in order to control
> > the fan device.  Good luck...
> 
> How do I do that? Can you please point me to some examples?

I can't, sorry.  It depend how the fan is controlled.  This could be
some magic values to poke to the EC space for example, or some
io register to set/reset, etc.

Look at ACPI spec v3.0 (available at www.acpi.info) page 345, 
"11.6 ThermalZone Examples."
for examples of fan devices and how to make them work with a
thermal zone.  But if you don't know how to control that fan,
I don't see how I can help you.
Those examples depends on the fact that the fan is controllable
via some registers into the EC space.  I don't know if your laptop
do have those registers.

> I've got my fan *visible* (doesn't function -- just visible), under
> /proc/acpi. What else should I do to get it actually working?

BTW you are sure the fan is not functionning properly?
What happens if you try to control it like this:

off:
echo 3 > /proc/acpi/fan/???/state

on:
echo 0 > /proc/acpi/fan/???/state

If that's work, it's just a matter to add to the thermal zone
some lines like those:

Method(_AC0)(Return (a temperature))
Name(_AL0, Package() {\_SB...\FAN})

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
