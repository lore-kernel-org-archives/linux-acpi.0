From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] [RFC] Asynchronous suspend/resume - test results
Date: Mon, 21 Dec 2009 21:58:19 +0200
Message-ID: <1261425499.4328.10.camel@maxim-laptop>
References: <200912210140.19713.rjw@sisk.pl>  <4B2F22EF.6040500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:44553 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZLUT60 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 14:58:26 -0500
In-Reply-To: <4B2F22EF.6040500@crca.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, 2009-12-21 at 18:25 +1100, Nigel Cunningham wrote: 
> Hi.
> 
> Rafael J. Wysocki wrote:
> > I'm not sure what the next step should be at this point.  To me, the picture is
> > quite clear now, but perhaps we ought to run more tests on some other machines
> > or something.  Please let me know what you think.
> 
> Looks great. If you do decide you want other machines tested, I'll
> happily try the machines around here:
> 
> - Dell M1530
> - Omnibook XE3-GF.
> - Via LN10000 based Mythtv Box
> - Desktop machine - Some Intel-based mobo I've forgotten the name of.
> 
> I've been quietly following the thread, but have lost track of what
> iteration of the patch you're on, so if you'd give me a pointer to it,
> I'd be grateful.
> 
> By the way, I haven't forgotten about sending some real patches for
> swsusp (ie more than just cleanups). I'm just busy with other things and
> also thinking carefully about what order to do things in.

I vote for ability to save all ram to the disk.
After several days of testing I managed to make my system do s2disk
really reliable (~300 cycles tested), but suspending when memory is
tight still fails sometimes.

I didn't yet use your tuxonice system  though.

Best regards,
Maxim Levisky







