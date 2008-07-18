From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Please pull ACPI updates
Date: Fri, 18 Jul 2008 15:25:21 +0200
Message-ID: <20080718132521.GA94799@dspnet.fr.eu.org>
References: <200807161633.01375.jbarnes@virtuousgeek.org> <487EEAEB.4050009@firstfloor.org> <alpine.LFD.1.10.0807170807040.2959@woody.linux-foundation.org> <alpine.LFD.1.10.0807170835320.2959@woody.linux-foundation.org> <487F71E8.9050705@firstfloor.org> <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com> <487FA24B.9060803@firstfloor.org> <alpine.LFD.1.10.0807171259010.2959@woody.linux-foundation.org> <alpine.LFD.1.10.0807171304220.2959@woody.linux-foundation.org> <alpine.LFD.1.10.0807171323320.2959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dspnet.fr.eu.org ([213.186.44.138]:2160 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049AbYGRNZX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 09:25:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807171323320.2959@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, Ray Lee <ray-lk@madrabbit.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jul 17, 2008 at 01:28:20PM -0700, Linus Torvalds wrote:
> One final note on this: the above is obviously not a problem for simple 
> code that only really does one thing, and in particular for code that you 
> wrote yourself. Moving your own commits around to make them make more 
> sense - or splitting them up etc - is often a _good_ thing, even if it 
> obviously does change history.

You seem to be talking of subtly different things Andi and you, and
since I'm quite interested in the answer I'll try to rephrase what I
understood.

You say "don't rebase on the most recent kernel version".  Andi seems
to accept that going forwards.  You say "use topic branches that are
based on whatever kernel version you had at the time, I'll do the
merge".  That's ok too.  His remaining question is "what do I do with
broken patches _in_the_topic_branch_?".  He wants to
amend/merge/split/reorder within the topic branch so that the branch
itself is bisectable.  So what should be done there?

  OG.

