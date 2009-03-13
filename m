From: Len Brown <lenb@kernel.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 12 Mar 2009 21:17:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903122102490.24376@localhost.localdomain>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
 <20090225152409.GA4015@srcf.ucam.org>
 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
 <20090225165152.GA5981@srcf.ucam.org>
 <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
 <1235657022.3802.86.camel@hughsie-work.lan>
 <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
 <1235753349.5444.53.camel@localhost.localdomain>
 <20090228151933.GC17541@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:63777 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCMBRY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 21:17:24 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGF002K47KIP365@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 12 Mar 2009 20:17:12 -0500 (CDT)
In-reply-to: <20090228151933.GC17541@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, Jonathan Buzzard <jonathan@buzzard.me.uk>, John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org

I acknowledge that the SMM control method doesn't fit well
into our current generic software abstractions for
controlling hardware.

I also acknowledge that this control has a right to exist
if people find it useful.  Further, I don't by the fact
that it root can use it to brick a system as sufficient
reason not to provide it.  Root can already do worse...

However, I'm not excited about extending toshiba_acpi to
include /dev/toshiba SMM interface that is already
provided by the toshiba driver.

I'd rather see the 'toshiba' driver (perhaps renamed to be toshiba_smm)
extended so that it is the only driver to provide this interface.

BTW. I notice that both toshiba_acpi and toshiba ship in Fedora
and can load on my satellite pro.  However, fedora doesn't ship
toshset -- is toshiba and /dev/toshiba useful without it?

Are new machines still using this interface, or it is going away over 
time?

thanks,
-Len


