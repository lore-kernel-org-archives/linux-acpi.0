From: Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Re: Asus M6*, A6*, L5D - can't reboot after suspend/resume
Date: Sat, 03 Nov 2007 18:02:17 +0600
Message-ID: <87r6j7y1ti.fsf@vertex.dottedmag.net>
References: <87myyjdcp6.fsf@vertex.dottedmag.net>
	<200706282323.21340.rjw@sisk.pl>
	<3877989d0706281451j6ed47793u27d0855532106991@mail.gmail.com>
	<200706290006.52333.rjw@sisk.pl>
	<3877989d0706281508wa281ff0j735f684cb5c40de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foreigner.dottedmag.net ([208.78.98.26]:44116 "EHLO
	dottedmag.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXKCMWe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Nov 2007 08:22:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

"Luming Yu" <luming.yu@gmail.com> writes:

> OK, let's try linuxfirmware tool to see if it is Linux problem or probably
> bios problem.  you can grab the tool kit from http://www.linuxfirmwarekit.org/
> then please do a suspend-resume cycle, then try reboot from the command line.
> Let's see the results. :-)

Sorry for the, hm, long delay. Finally found the time to do this.

Grabbed the firmwaretoolkit r3, boot it, suspend-resume from menu and then exit
it (reboot from the command line did not work due to missing /dev/initctl).

Reboot hung exactly as it hungs on regular system.

Exiting from toolkit without suspend/resume works fine.

-- 
JID: dottedmag@jabber.dottedmag.net
