From: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Sat, 10 Sep 2005 11:42:59 +0200
Message-ID: <20050910094259.GA16051@gollum.tnic>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.61.0509091817220.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750727AbVIJJnP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509091817220.3743@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>, akpm@osdl.org, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 09, 2005 at 06:25:00PM +0200, Roman Zippel wrote:
 
> The best would be to avoid using defaults completely, unless the resulting 
> kernel is non-functional (e.g. it doesn't compile or boot).
> So far it's still the responsibility of the user to explicitly turn 
> everything on he needs (at least until we have a functional autoconfig).
> BTW distros are not the only users, from them I would expect how to 
> configure a kernel.

Actually, this sounds pretty sane and IMHO is somehow the biggest common
denominator concerning linux users and their kernel configuration
recreational activities :); but seriously, going all over the menus of Kbuild
and turning everything off is a lot of work compared to turning on the
several things I need on my system. "default m" is also not a good thing
since compiling of unnecessary modules is simply dumb for a system
that's just not going to use them.

Regards,
		Boris.
