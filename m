From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Battery life difference
Date: Sat, 5 Jul 2008 12:34:38 -0700
Message-ID: <20080705123438.15c8de40@infradead.org>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
	<20080705082352.4b6be669@infradead.org>
	<31e679430807050844r30ff74fby7e15641573b42d82@mail.gmail.com>
	<20080705085432.2f9b2964@infradead.org>
	<31e679430807051041w6dd9b917xc51f31f66fbd65d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49984 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYGETek (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 15:34:40 -0400
In-Reply-To: <31e679430807051041w6dd9b917xc51f31f66fbd65d3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, 5 Jul 2008 20:41:07 +0300
"Felipe Balbi" <felipebalbi@users.sourceforge.net> wrote:

> 
> Cool, now I'm using current linux 2.6.26-rc8 from git
> b8a0b6ccf2ba2519ace65d782b41ee91bf3c3778
> 
> Now I'm reaching 9.8w consumption :-)
> 
> Really good improvements.

cool

> 
> btw, any plans to move some of the powertop features to acpid ?
> I mean, the wireless pm for iwl4965 could be there, couldn't it ?

actually.. it needs to/is moving into the driver. This sort of decision
needs to just happen locally in the driver; the idea that you can make
power decisions (rather than policy decisions) on a global level is
just no longer true (if it ever was).

Actually I thought this was already in the 2.6.26-rc kernel series
driver...


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
