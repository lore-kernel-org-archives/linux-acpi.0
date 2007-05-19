From: Christian Leber <christian@leber.de>
Subject: Re: [BUG] acpi double resume and fail
Date: Sat, 19 May 2007 21:42:53 +0200
Message-ID: <20070519194253.GA27651@core>
References: <20070518213701.GA810@core> <20070518154507.30ebfdcb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764205AbXESTnG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070518154507.30ebfdcb.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 18, 2007 at 03:45:07PM -0700, Andrew Morton wrote:

> > I still can suspend, but after the first resume it goes back to sleep
> > directly again, when resuming again it works.
> > After the second suspend it won't resume at all.

I should add, that it goes from the suspend state to "on" and back to
suspend, when i press power again it goes "on", but the screen stays
black, but network doesn't work and most likely linux isn't running,
because the laptop sucks max_power. (2.6.20-rc4)

> > The problem is that i can't try out the kernel versions <rc4, because
> > rc1, rc2 and rc3 doesn't boot at all, so git-bisect also won't help.
> > 
> > Has somebody an idea what i could try out?
> > 
> > (the distribution is in this case ubuntu feisty)
 
> The fact that bisection broke really does make it hard.  What you would
> need to do is to find the patch which fixed that doesn't-boot problem, then
> reapply it each time you perform an iteration.  That's all doable, if you
> have the time.  Use git-bisect for it.

I'll try, unfortunatelly the problem is that PCI doesn't work with this
versions.

> Have you tested 2.6.21 and/or 2.6.22-rc1?

I just have tried 2.6.22-rc2 and it's a bit different, I still have to resume
2 times and X does only work the "first" resume correctly, but it somewhat
works.

> We had one other report earlier today that 2.6.22-rc1 does an immediate
> resume after suspend-to-RAM - perhaps that is related.

no


Regards
Christian Leber

-- 
http://rettetdieti.vde-uni-mannheim.de/
