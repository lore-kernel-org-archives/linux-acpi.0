From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Thu, 25 Jun 2009 12:42:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906251237490.4308@localhost.localdomain>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
 <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <71cd59b00906190128h6de62133o9e8380e1992da59c@mail.gmail.com>
 <alpine.LFD.2.00.0906191535220.4325@localhost.localdomain>
 <alpine.LFD.2.00.0906240136300.32742@localhost.localdomain>
 <71cd59b00906232339t1d0812embd711243468be91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:44229 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZFYQm0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2009 12:42:26 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLS00GMPZQGNSK0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 11:42:16 -0500 (CDT)
In-reply-to: <71cd59b00906232339t1d0812embd711243468be91d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org, sfr@canb.auug.org.au


On Wed, 24 Jun 2009, Corentin Chary wrote:

> On Wed, Jun 24, 2009 at 7:41 AM, Len Brown<lenb@kernel.org> wrote:

> > Unfortunately, upstream scribbed more rfkill stuff on eeepc-laptop.c
> > I did take a swing at merging the conflicts, but got lost.
> > So it is probably best if you refresh those last 8 eeepc-laptop.c
> > patches and send them again.

> Isn't that fixed by http://lkml.org/lkml/2009/6/21/169 ?

Hmm, apparently so -- I didn't receive that note.
I suppose if Stephen signed off on it, I could have applied it
and not dropped the tail of your patch series from rc1...

Anyway, thanks for refreshing the patches,
I've checked them in and they'll be in my -rc2 push.

cheers,
Len Brown, Intel Open Source Technology Center

