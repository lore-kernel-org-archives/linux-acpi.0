From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: better handling of P8010 hotkey
Date: Mon, 13 Oct 2008 08:25:37 +0930 (CST)
Message-ID: <200810122255.m9CMtbt6004616@turbo.physics.adelaide.edu.au>
References: <alpine.LFD.1.10.0810101624190.7059@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:43347 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981AbYJLWzw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Oct 2008 18:55:52 -0400
In-Reply-To: <alpine.LFD.1.10.0810101624190.7059@localhost.localdomain> from "Len Brown" at Oct 10, 2008 04:29:30 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

Hi Len

> > diff -ruNp misc-linus/fujitsu-laptop.c misc-jmw/fujitsu-laptop.c
> 
> please see "SECTION 1" of Documentation/SubmittingPatches
> dunno if this is why your last one didn't apply.

Oops, sorry about that.  I was going to fix the diff paths before submitting
but in my haste to get it out I forgot about it.  In other words, the
failure to apply would have been due to the bogus local paths in the patch,
which were never meant to see the light of day.  Basically

  misc-linus -> linux-2.6-linus/drivers/misc
  misc-jmw   -> linux-2.6/drivers/misc

> re: Lindent
> please don't mix functional and style patches in the same patch,
> they should be in a series of multiple patches.  otherwise the
> style changes make it impossible to revivew the functional changes.

Yep.  Part of the problem in this case was that some of these changes came
from elsewhere.  They never separated it for me and at the time neither they
nor I had time to enforce the separation.  I'll be stricter next time. :-)

> anyway, this one is in the test tree now.

Thanks - I appreciate it.

> perhaps you can address dmitry's question?

Will do, but it might be a while before I have time to digest exactly what
it means and how to do it.  I'm going to be extremely short on time for
the next 3-4 weeks.

Regards
  jonathan
