From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 11:24:48 -0700
Message-ID: <20050921112448.0e121a3d.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921104615.2e8dd7d5.akpm@osdl.org>
	<m1ll1qcmzr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751356AbVIUSZt@vger.kernel.org>
In-Reply-To: <m1ll1qcmzr.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: torvalds@osdl.org, pavel@suse.cz, len.brown@intel.com, drzeus-list@drzeus.cx, acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com, masouds@masoud.ir, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> > Famous last words, but the actual patch volume _has_ to drop off one day. 
> > In fact there doesn't seem to much happening out there wrt 2.6.15.
> 
> Due to changes coming through git or that there will simply be fewer
> things that need to be patched?

We're at -rc2 and I only have only maybe 100 patches tagged for 2.6.15 at
this time.  The number of actual major features lined up for 2.6.15 looks
relatively small too.

As I said, famous last words.  But we have to finish this thing one day ;)

> As for 2.6.15 I know I have patches in the queue that I intend to send
> out later this week, which probably count.  I wonder if other developers
> are similar.  

Possibly.  Quite a few of the git trees are looking pretty fat.  I need to
get another kernel-status thingy out soon, but that takes many hours of
bugzilla-poking.
