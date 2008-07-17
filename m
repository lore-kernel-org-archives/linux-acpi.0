From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 12:16:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807171212500.2959@woody.linux-foundation.org>
References: <20080716214516.GA10777@basil.nowhere.org> <200807170011.12184.rjw@sisk.pl> <200807161633.01375.jbarnes@virtuousgeek.org> <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org> <487EE940.1050007@firstfloor.org>
 <alpine.LFD.1.10.0807170752190.2959@woody.linux-foundation.org> <alpine.LFD.1.10.0807171402110.2965@localhost.localdomain> <alpine.LFD.1.10.0807171154560.2959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49746 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754916AbYGQTQ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 15:16:56 -0400
In-Reply-To: <alpine.LFD.1.10.0807171154560.2959@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org



On Thu, 17 Jul 2008, Linus Torvalds wrote:
> 
> No, what others do (if they know the tricks) is to say something like:
> 
> 	git rebase -i <starting-point>

Oh, and before anybody goes any further with this: it's a very convenient 
feature, but it _is_ still technically nothing but a very nice interface 
to cherry-picking and rebasing history. 

So all the caveats about _not_ doing this with public history that others 
have already seen and possibly merged are still in place. That part 
doesn't change at all.

So it's great to do with private changes to clean them up before 
publicizing them, or possibly with branches that you have explicitly told 
people are _not_ stable, but it is still very much about creating a 
totally new history.

			Linus
