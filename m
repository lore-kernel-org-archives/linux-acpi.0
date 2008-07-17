From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 08:06:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807170803460.2959@woody.linux-foundation.org>
References: <20080716214516.GA10777@basil.nowhere.org> <200807161633.01375.jbarnes@virtuousgeek.org> <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org> <200807161651.44990.jbarnes@virtuousgeek.org> <alpine.LFD.1.10.0807161728560.2835@woody.linux-foundation.org>
 <487EEA9B.4030808@firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46226 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753104AbYGQPHE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 11:07:04 -0400
In-Reply-To: <487EEA9B.4030808@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



On Thu, 17 Jul 2008, Andi Kleen wrote:
> 
> I originally started with topic branches and imported a few patches
> this way, but then eventually realized they don't really match my
> working style.

That still doesn't excuse then breaking _other_ peoples work.

> What I did then was to export Len's tree to quilt, do all the touchups
> etc, merged some more patches and then regenerated a quilt tree for
> the merge request. That is how the old x86-64 tree used to work.

Right. 

And Andi, remember the problems with that one? Remember how I ended up 
refusing to 'git pull' from you? (Also look at how it failed to work well 
for Ingo and Thomas as well, and how people complained about that? It's 
not just you.)

In other words, "That is how the old x86-64 tree used to NOT work".

			Linus
