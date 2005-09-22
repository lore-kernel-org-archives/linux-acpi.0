From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Thu, 22 Sep 2005 09:15:14 +0200
Message-ID: <43325A02.90208@drzeus.cx>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> <20050921173630.GA2477@localhost.localdomain> <20050921194306.GC13246@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Masoud Sharbiani <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Russell King wrote:

>So, before trying to get the "underworked" bug system used more,
>please try to get more developers signed up to it so that we have
>the necessary folk behind the bug system to handle the increased
>work load.
>
>  
>

What we probably need then is an official policy that maintainers need
to have an account in the bugzilla. Start with the subsystem maintainers
and leave it to them to get each driver maintainer in line. Having only
a handful of parts of the kernel in the bugzilla is just confusing.

Personally I think the mailing lists are a great way for general
discussion. But once we have a confirmed bug (or difficult new feature)
it is better off being tracked in bugzilla. And this is my opinion both
as a user and as a developer. Bugzilla is the de facto standard of
reporting bugs so some users might find it troublesome dealing with
mailing lists such as LKML.

Rgds
Pierre


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
