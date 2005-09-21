From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 11:28:55 -0600
Message-ID: <m1slvycotk.fsf@ebiederm.dsl.xmission.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751290AbVIURao@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 21 Sep 2005 09:35:20 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 21 Sep 2005, Pavel Machek wrote:
>> 
>> I think you are not following the proper procedure. All the patches
>> should go through akpm.

Ok.  I thought it was fine to send simple and obviously correct bug
fixes to Linus.

> One issue is that I actually worry that Andrew will at some point be where 
> I was a couple of years ago - overworked and stressed out by just tons and 
> tons of patches. 
>
> Yes, he's written/modified tons of patch-tracking tools, and the git 
> merging hopefully avoids some of the pressures, but it still worries me. 
> If Andrew burns out, we'll all suffer hugely.
>
> I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> having -mm as a staging area and catching some problems there, so going 
> through andrew is wonderful in that sense, but it has downsides.

It is especially challenging for people like me who typically work on
parts of the kernel without a maintainer.  So there frequently isn't
an intermediate I can submit my patches to.

Eric
