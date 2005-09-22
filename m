From: Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Thu, 22 Sep 2005 10:38:11 +0100
Message-ID: <20050922093811.GC16949@flint.arm.linux.org.uk>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> <20050921173630.GA2477@localhost.localdomain> <20050921194306.GC13246@flint.arm.linux.org.uk> <43325A02.90208@drzeus.cx> <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m14q8dcuvm.fsf-T1Yj925okcoyDheHMi7gv2pdwda3JcWeAL8bYrjMMd8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>, Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Masoud Sharbiani <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 22, 2005 at 03:30:21AM -0600, Eric W. Biederman wrote:
> One problem I have with a system like bugzilla is that frequently bug
> reports are not complete, and bugzilla sets the expectation that
> once you file a bug the reporters part is complete.  Frequently it takes
> several round trips via email to even understand the bug that is being
> reported. 

What it needs is something like the Red Hat bugzilla front end,
where reporters are guided through the information they need to
submit.  Maybe that would help with bugme if we had such a front
end?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
