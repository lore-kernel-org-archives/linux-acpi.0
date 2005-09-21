From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 10:46:15 -0700
Message-ID: <20050921104615.2e8dd7d5.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0509210930410.2553-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org> wrote:
>
> 
> 
> On Wed, 21 Sep 2005, Pavel Machek wrote:
> > 
> > I think you are not following the proper procedure. All the patches
> > should go through akpm.
> 
> One issue is that I actually worry that Andrew will at some point be where 
> I was a couple of years ago - overworked and stressed out by just tons and 
> tons of patches. 

Patches are very low overhead, really.  It's patches which don't work which
take lots of time - a single dud patch can take hours and can make me think
rude thoughts about its originator.

> Yes, he's written/modified tons of patch-tracking tools, and the git 
> merging hopefully avoids some of the pressures, but it still worries me. 
> If Andrew burns out, we'll all suffer hugely.
> 
> I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> having -mm as a staging area and catching some problems there, so going 
> through andrew is wonderful in that sense, but it has downsides.
> 
> Andrew?
> 

I'm doin OK.

Patch volume isn't a problem wrt the simple mechanics of handling them. 
The problem we have at present is lack of patch reviewing bandwidth.  I'll
be tightening things up in that area.  Relatively few developers seem to
have the stomach to do a line-by-line through large patches, and it would
be nice to refocus people a bit on that.  Christoph's work is hugely
appreciated, thanks.

Famous last words, but the actual patch volume _has_ to drop off one day. 
In fact there doesn't seem to much happening out there wrt 2.6.15.

Bugs are a big problem - it takes 4 hours minimum to get a -mm out the door
and a single bug can cause it to slip to the next day in which case I have
to start again.  A couple of times it has taken over two days just to get
together a tree which boots on four architectures and compiles on seven.

I'm spending more and more time on bugs now.  We have hundreds of bugs
which people have taken the time to report, which the relevant developers
know about and NOTHING IS HAPPENING.  "I can't reproduce it" is not an
adequate reason when there are nice testers out there who are available to
work through the diagnosis process.  We have hundreds of machines out there
which we are known to have broken and developers just need to reapportion
some of their time to getting these things fixed.

The -mm tree does prevent a large amount of crap from hitting mainline -
I'd guess the bug leakthrough rate is ~10%, although that 90% tends to be
the easy stuff - often compile errors.  I'd like to release -mm's more
often and I'd like -mm to have less of a wild-and-crappy reputation.  Both
of these would happen if originators were to test ther stuff more
carefully.




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
