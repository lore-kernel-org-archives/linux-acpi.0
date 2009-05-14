From: Len Brown <lenb@kernel.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Thu, 14 May 2009 13:14:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905141307300.24833@localhost.localdomain>
References: <87k5691x3y.fsf@olivierberger.com>
 <200904281339.15689.trenn@suse.de> <877i14aed8.fsf@olivierberger.com>
 <200904281956.50640.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49432 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZENRQy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 13:16:54 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJN00EAP988NQIG@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 14 May 2009 12:14:34 -0500 (CDT)
In-reply-to: <200904281956.50640.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Olivier Berger <oberger@ouvaton.org>, linux-acpi@vger.kernel.org

The P4B266 DMI entry went into ./arch/i386/kernel/dmi_scan.c
back in Aug-2003.

That was when I was just starting to maintain ACPI,
and I took a bunch of blacklist entries from SuSE
because they were already shipping with ACPI enabled.

In the short term, it may have been the right thing to do,
but in the long term it was a mistake and I regret doing it.

Blacklist entries paper-over real bugs, and unless we are lucky
enough that somebody like you, Oliver, steps forward,
blacklist entries are nearly impossible to ever remove.

So I'm inclined to apply your original patch to delete
the blacklist entry entirely.  If somebody with one of
those boxes has a regression, we'll go fix their box --
which we may have acutally fixed years ago and not known it...

thanks,
-Len
