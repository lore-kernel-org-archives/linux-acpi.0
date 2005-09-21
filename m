From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Wed, 21 Sep 2005 20:45:24 +0100 (BST)
Message-ID: <Pine.LNX.4.61.0509212042400.11126@goblin.wat.veritas.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
 <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
 <20050921173630.GA2477@localhost.localdomain> <20050921111523.4b007281.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921111523.4b007281.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Sep 2005, Andrew Morton wrote:
> 
> I wouldn't say that bugmeister is a fulltime job, but it'll be a
> lot-of-time job.  It needs someone who isn't shy and who has a good
> understanding of the kernel code-wise, of the processes (hah) and of the
> people.
> 
> The ability to maintain an overall view of where we're at, which bugs are
> serious and which aren't.  The ability to succinctly communicate that
> overview to everyone else.  Able to tell Linus "you can't release a kernel
> until bugs A, B and C are fixed".  The skills and gut-feel to know when a
> patch is some once-off which can be ignored unless it reoccurs, etc.  It's
> one of those things which can consume as much effort as one is able to put
> into it.

I recognize this description: sorry, Andrew, can we please clone you?

Hugh


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
