From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Help with debugging intermittent crash on resume from
 hibernation
Date: Sat, 18 Apr 2015 06:45:25 +0200
Message-ID: <1429332325.3175.16.camel@gmail.com>
References: <8761a3s1vq.fsf@vostro.rath.org>
	 <87vbhwwdzz.fsf@vostro.rath.org> <1426823821.3150.4.camel@gmail.com>
	 <5531CC47.9000008@rath.org> <1429329703.4034.4.camel@gmail.com>
	 <87bnimhy5h.fsf@vostro.rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36496 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbDRFI2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2015 01:08:28 -0400
In-Reply-To: <87bnimhy5h.fsf@vostro.rath.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nikolaus Rath <Nikolaus@rath.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

On Fri, 2015-04-17 at 21:13 -0700, Nikolaus Rath wrote:
> On Apr 17 2015, Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> > On Fri, 2015-04-17 at 20:15 -0700, Nikolaus Rath wrote:
> > > 
> > > Is there anything I can do to help debug this issue?
> > 
> > You could try to bisect it, but judging from the problem 
> > description, 
> > that could be more like a career than a troubleshooting session.
> 
> Furthermore, I have yet to find a kernel version that does *not* 
> exhibit
> the problem (I went back to 3.14).

My solution would be don't do that then.  Hibernation doesn't save 
much time anyway, so is worth zero annoyance.

I would like to be able to suspend, but went from GeForce 8600 GT in 
old box that suspended great, resumed not at all to GeForce GTX 980 in 
new box which suspends great and resumes not at all, and is supported 
by nothing that makes eyecandy, so I have roughly a zillion unused 
transistors.  The thing occupies nearly the same volume of space as my 
laptop... but lappy doesn't have sexy big green leds to remind me that 
it's a Satellite lest I forget :)

        -Mike
