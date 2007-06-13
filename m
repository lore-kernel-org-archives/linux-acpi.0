From: Norbert Preining <preining@logic.at>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Wed, 13 Jun 2007 19:39:25 +0200
Message-ID: <20070613173925.GA20628@gamma.logic.tuwien.ac.at>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:42979 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231AbXFMRj0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2007 13:39:26 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3])
	by mx.logic.tuwien.ac.at with esmtp (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1HyWoX-0006fi-Qt
	for linux-acpi@vger.kernel.org; Wed, 13 Jun 2007 19:39:25 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 3.35 #1)
	id 1HyWoX-0005Yl-00
	for linux-acpi@vger.kernel.org; Wed, 13 Jun 2007 19:39:25 +0200
Content-Disposition: inline
In-Reply-To: <20070612153102.GD5986@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all!

On Die, 12 Jun 2007, Pavel Machek wrote:
> > Hibernate (aka suspend to disk) works, however.
> > 
> > When I resume, everything seems to come up (fan becomes busy, disk and
> > dvd spin up for a short time), but the machine is not responding to
> > anything - neither keyboard, mouse nor ping from another machine. The
> > laptop is effectively dead and only a power cycle helps.
> > 
> > I've tried a minimal config and init=/bin/bash as well, but the result
> > is the same.

All same here, same problem with Acer TM3012, Intel Core Duo, intel
945M, ipw3945.

> Beeping patch? It is in -mm now. noapic nolapic and nosmp are useful,
> too.

Can you tell me more about the beeping patch? I checked the patches in
-mm and the patch names do not contain "beep", neither does
git-acpi.patch. Where does it come from, do I need some special
configureation? Is there a bit of explanation around?

Thanks a lot, I really want to try it out. I tried already so many
kernels and so many iterations and never succeeded, while s2r works
without problems even with DRI enabled.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCREEB (n.)
To make the noise of a nylon anorak rubbing against a pair of corduroy
trousers.
			--- Douglas Adams, The Meaning of Liff
