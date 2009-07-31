From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: consolidated fixes (NULL pointer checks, [un]registration fixes, etc)
Date: Fri, 31 Jul 2009 13:34:26 +0930 (CST)
Message-ID: <200907310404.n6V44Qn0005781@mercury.physics.adelaide.edu.au>
References: <200907301408.10864.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752333AbZGaEE4@vger.kernel.org>
In-Reply-To: <200907301408.10864.bzolnier@gmail.com> from "Bartlomiej Zolnierkiewicz" at Jul 30, 2009 02:08:10 PM
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com, Julia Lawall <julia@diku.dk>
List-Id: linux-acpi@vger.kernel.org

Hi all

> > This patch consolidates the two patches posted by Bartlomiej Zolnierkiewicz
> > and the NULL pointer patch which came out of a discussion with Julia Lawall.
> > Some additional NULL pointer check tidy-ups have also been done.
> > 
> > To summarise:
> 
> I think that for the increased readability and to preserve proper credits it
> would be better to keep separate patches (updating the driver version can be
> as well handled in an incremental patch).

Ok, leave it with me and I'll re-split along these lines.

> I would also strongly insist on removing the following needless NULL pointer
> checks introduced by this version.  They may hide real bugs in the ACPI driver
> code (which should make sure that we always have valid 'device' in the ACPI
> driver methods and that it doesn't go away while the method executes) or in
> the fujitsu-laptop itself (which has to always provide valid 'fujitsu_hotkey',
> 'fujitsu' and 'input' pointers and not free them while there are still some
> users left).

I'll take another look at these.  What I was concerned about was whether the
hotkey pointer in particular was valid in all cases (since some of the
relevant laptops don't in fact have hotkeys) - and I was very short of time
yesterday.  I've had a very quick look through the code just now and it
seems that this may not be a problem after all.  In any case I'll confirm
this over the next day or so and redo/reisssue the patches accordingly.

Regards
  jonathan
