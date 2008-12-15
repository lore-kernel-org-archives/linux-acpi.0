From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Tue, 16 Dec 2008 10:12:26 +1030 (CST)
Message-ID: <200812152342.mBFNgQJj028844@sprite.physics.adelaide.edu.au>
References: <1229361241.13400.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:41096 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293AbYLOXoF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 18:44:05 -0500
In-Reply-To: <1229361241.13400.1.camel@localhost> from "Tony Vroon" at Dec 15, 2008 05:14:01 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: Dan Williams <dcbw@redhat.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au, Peter Gruber <nokos@gmx.net>, linux-wireless@vger.kernel.org

Hi Tony

> On Mon, 2008-12-15 at 10:19 -0500, Dan Williams wrote:
> > I plan to beat the .... out of the hal killswitch support pretty soon.
> > AFAIK it still doesn't know about softblock, which is part of the whole
> > reason for the rfkill rewrite in 2.6.26 anyway.  It also doesn't yet
> > (AFAIK) support uevents from killswitches either, which sucks.
> 
> Could you let me know when you've committed this code so I have another
> shot at implementing rfkill reporting in fujitsu-laptop?

This is to let you know that I'm still following this discussion but haven't
had anything sensible to add to the basic infrastructure issues being worked
through at present.  It's probably sensible for me to pick up on the next
version of your patch.

Also, over the Christmas period (ie: after this week) my responses are
likely to be slow due to intermittant network access in that time.

I also haven't forgotten about getting you the DSDT from the S7020 - I just
haven't had a chance to get to that yet.  I hope to get to this before the
end of the week.

Regards
  jonathan
