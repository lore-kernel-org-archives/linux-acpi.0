From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 13:10:19 -0700
Message-ID: <20050921131019.21f20e97.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921194306.GC13246@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921194306.GC13246-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org, torvalds-3NddpPZAyC0@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>
> So, before trying to get the "underworked" bug system used more,
>  please try to get more developers signed up to it so that we have
>  the necessary folk behind the bug system to handle the increased
>  work load.

They don't actually need to be signed up to bugzilla.  Just cc
bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org on the email trail and anything with
'[Bug NNNN]' in Subject: gets filed appropriately.

So all you need to do forward the email to the relevant culprit and cc
bugme-daemon-ztI5WcYan/vQLgFONoPN61N6ohzGQtmt@public.gmane.org  Unfotunately some of the emails which
bugzilla sends (the [bugme-new] ones) don't actually have
bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org on the To: or Cc: lines, so you need to
add that by hand the first time.

On problem with all this is that once the discussion has gone to email, it
kinda has to stay that way - if someone goes in and updates the bug via the
web interface, those people who were getting the info only via direct email
don't get to see the new info.   Generally that works out OK.

It would be nice if

a) we could add non-bugzilla-account-holders to a bug's cc list and

b) Once bugzilla sees any person either sending or receiving emails or
   web entries, it autoadds that person to the bug's cc list, so they get
   email for all further activity.  Could be a bit irritating, but tough
   luck ;) We need to fix bugs.




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
