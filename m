From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 11:15:23 -0700
Message-ID: <20050921111523.4b007281.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751348AbVIUSQY@vger.kernel.org>
In-Reply-To: <20050921173630.GA2477@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Nyberg <alexn@telia.com>
Cc: torvalds@osdl.org, pavel@suse.cz, ebiederm@xmission.com, len.brown@intel.com, drzeus-list@drzeus.cx, acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com, masouds@masoud.ir, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> On Wed, Sep 21, 2005 at 09:35:20AM -0700 Linus Torvalds wrote:
> 
> > 
> > 
> > On Wed, 21 Sep 2005, Pavel Machek wrote:
> > > 
> > > I think you are not following the proper procedure. All the patches
> > > should go through akpm.
> > 
> > One issue is that I actually worry that Andrew will at some point be where 
> > I was a couple of years ago - overworked and stressed out by just tons and 
> > tons of patches. 
> > 
> > Yes, he's written/modified tons of patch-tracking tools, and the git 
> > merging hopefully avoids some of the pressures, but it still worries me. 
> > If Andrew burns out, we'll all suffer hugely.
> > 
> > I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> > having -mm as a staging area and catching some problems there, so going 
> > through andrew is wonderful in that sense, but it has downsides.
> > 
> 
> Morever bugme.osdl.org is severely underworked (acpi being a noteable
> exception) and Andrew has stepped in alot there too. Alot of bugs
> reported on the mailing list are only followed up by Andrew.
> 
> I think he really should receive much more help than he currently does.

Yes, kernel bugmeister is a completely separate function from
patchmonkeying.  It is something which a separate person can and should do.

My current thinking is that I'll develop the processes, find out what works
and then look to hand it off to some other sucker.  I wouldn't claim that
this is going very well at present, perhaps because I'm just not putting
enough time into the bugmeistering to be able to demonstrate what works and
what does not.

I wouldn't say that bugmeister is a fulltime job, but it'll be a
lot-of-time job.  It needs someone who isn't shy and who has a good
understanding of the kernel code-wise, of the processes (hah) and of the
people.

The ability to maintain an overall view of where we're at, which bugs are
serious and which aren't.  The ability to succinctly communicate that
overview to everyone else.  Able to tell Linus "you can't release a kernel
until bugs A, B and C are fixed".  The skills and gut-feel to know when a
patch is some once-off which can be ignored unless it reoccurs, etc.  It's
one of those things which can consume as much effort as one is able to put
into it.

Kernel development is more professional than we like to pretend nowadays,
and developers will react well to someone who is doing this for us.  It's
pretty boring tho.
