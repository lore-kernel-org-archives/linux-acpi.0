From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Tue, 16 Jul 2013 09:30:32 +0200
Message-ID: <1654161.p7sLd1rPau@hammer82.arch.suse.de>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <20130715163427.GG1074@khazad-dum.debian.net> <3454747.PmElQdFDGy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46595 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab3GPHai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 03:30:38 -0400
In-Reply-To: <3454747.PmElQdFDGy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oliver Neukum <oneukum@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 16, 2013 01:56:49 AM Rafael J. Wysocki wrote:
> On Monday, July 15, 2013 01:34:27 PM Henrique de Moraes Holschuh wrote:
...
> > We still have 10 to 15 years worth of users using non-win8 firmware boxes
> > on x86/x86-64.
> 
> But what's the risk from removing the check exactly for those systems?

Yeah, I guess this is the point.

Is there a security or data corruption issue that might show up?
And even if.., if you exchange HW you should do a real reboot, otherwise
you have to blame yourself. The check is/was nice to at least give a hint
and remember the user where the failure might have come from.
But this does not work if Windows does not check for it.
Maybe Windows never checked for it, but it's not worth trying out
different versions, just for the sake of absolute Windows version
compatibility.

       Thomas

