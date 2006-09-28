From: Andi Kleen <ak@suse.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Thu, 28 Sep 2006 09:49:06 +0200
Message-ID: <200609280949.06676.ak@suse.de>
References: <200609271424.47824.eike-kernel@sf-tec.de> <200609272250.21925.ak@suse.de> <Pine.LNX.4.64.0609271436310.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:8856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751757AbWI1HtM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 03:49:12 -0400
In-Reply-To: <Pine.LNX.4.64.0609271436310.3952@g5.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org, jbeulich@novell.com

On Wednesday 27 September 2006 23:38, Linus Torvalds wrote:
> 
> On Wed, 27 Sep 2006, Andi Kleen wrote:
> > 
> > It doesn't matter much because these days this stuff is all out of lined
> > anyways and in a single function. And the dynamic branch predictor
> > in all modern CPUs will usually cache the decision (unlocked) there.
> 
> Ahh, good point. Once there's only one copy, the branch predictor will get 
> it right (and the code size won't much matter)

As a postscript I (unintentionally) bended the truth on that one actually
yesterday. Sorry for that. Semaphores are still inline, unlike spinlocks.

However if the spinlocks are out of line I see no reason to keep semaphores
inline either, so perhaps it would be better to just move them. Then my
argument above would actually work :)

For some reason the unwinder also still seems to get stuck on it :/

-Andi
