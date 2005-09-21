From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 12:08:24 -0600
Message-ID: <m1ll1qcmzr.fsf@ebiederm.dsl.xmission.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921104615.2e8dd7d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921104615.2e8dd7d5.akpm-3NddpPZAyC0@public.gmane.org> (Andrew Morton's
 message of "Wed, 21 Sep 2005 10:46:15 -0700")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, pavel-AlSwsSmVLrQ@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org> writes:

> I'm doin OK.

Good to hear.

> Patch volume isn't a problem wrt the simple mechanics of handling them. 
> The problem we have at present is lack of patch reviewing bandwidth.  I'll
> be tightening things up in that area.  Relatively few developers seem to
> have the stomach to do a line-by-line through large patches, and it would
> be nice to refocus people a bit on that.  Christoph's work is hugely
> appreciated, thanks.
>
> Famous last words, but the actual patch volume _has_ to drop off one day. 
> In fact there doesn't seem to much happening out there wrt 2.6.15.

Due to changes coming through git or that there will simply be fewer
things that need to be patched?

As for 2.6.15 I know I have patches in the queue that I intend to send
out later this week, which probably count.  I wonder if other developers
are similar.  

Eric


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
