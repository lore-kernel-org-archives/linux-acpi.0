From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Sat, 8 May 2010 02:03:30 +0200
Message-ID: <201005080203.30634.rjw@sisk.pl>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain> <201005080117.23760.rjw@sisk.pl> <alpine.LFD.2.00.1005071618410.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57304 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab0EHACh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 May 2010 20:02:37 -0400
In-Reply-To: <alpine.LFD.2.00.1005071618410.901@i5.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Saturday 08 May 2010, Linus Torvalds wrote:
> 
> On Sat, 8 May 2010, Rafael J. Wysocki wrote:
...
> 
> Let me explain what I think we should do with actual code:
> 
> 	acpi_enable();
> 	if (test_if_that_f_cking_bit_still_isnt_set)
> 		set_it_by_hand();
> 
> wouldn't that work on your box?

Yes, it would.

> The acpi_enable() seems to work for you, so it wouldn't actually ever set it
> by hand. 
>
> But the problem is that on a number of boxes, acpi_enable() apparently 
> doesn't do what it should do. Because the stupid BIOS "knows" it is 
> already in ACPI mode, but it forgot to actually set the bit!

To calrify, I think the approach in the Matthew's patch is correct, but since I have
some bad experience with that particular thing, I prefer to make that change in
2.6.35 and then move on to drop the flag entirely.

Rafael
