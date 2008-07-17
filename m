From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Please pull ACPI updates
Date: Wed, 16 Jul 2008 17:32:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807161728560.2835@woody.linux-foundation.org>
References: <20080716214516.GA10777@basil.nowhere.org> <200807161633.01375.jbarnes@virtuousgeek.org> <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org> <200807161651.44990.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbYGQAcQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 20:32:16 -0400
In-Reply-To: <200807161651.44990.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



On Wed, 16 Jul 2008, Jesse Barnes wrote:
> >
> > Andi did not. The whole series I pulled was rebased today at 2PM.
> 
> Ugg, when Andi took over we talked about it; I thought we had agreed that he 
> would stick with Len's tree.  I guess I was wrong.

Well, I haven't actually seen Len's original tree, so maybe the stuff Andi 
pushed was just the stuff he had queued up independently. I guess I 
shouldn't judge before I'm sure.

> Is a topic branch flow like what Len uses documented somewhere that you know 
> of?  I know my process could use some improvement; I'd rather not have to 
> wait for Len to come back to ask him. :)

Len wrote it up at one point, but I can't for the life of me remember 
where. 

He's not the onyl one to ask, though - Ingo and Thomas seem to have picked 
up topic branches pretty well (I had some issues with a couple of the 
topics, but they weren't fundamental and the major one was probably 
because Ingo tried a bit too hard to make sure that I never saw any 
conflicts at all).

Other topic branch users include Jeff Garzik and rmk. There's definitely 
people around who should be able to talk about what they are doing.

		Linus
