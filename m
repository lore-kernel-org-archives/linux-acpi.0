From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 16:26:04 -0700
Message-ID: <20050727162604.66efd801.akpm@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B300428CA9E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300428CA9E-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> 
> >Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >> I deleted /proc/acpi/button on purpose,
> >> did you have a use for those files?
> >
> >Can we put it back, please?
> 
> of course.

Thanks.

> >We cannot go ripping out stuff which applications and users 
> >are currently using without quite a lot of preparation.
> 
> Agreed.  Although the implementation of the /proc lid status
> file is fundamentally flawed in that even its name in /proc
> is able to change and thus it is a totally bogus user-space API,
> it was not thoughtful to delete it.
> 
> I'm open to suggestions on how to approach this transition.
> I can make ACPI_PROC a static build option -- what else
> can I do to ease the transition in this, our stable release?

Well I don't know how awkward this would be from an implementation POV, but
can we just leave the legacy /proc stuff there until the /sys interface is
all in place and userspace is upgraded?  Then kill all the /proc stuff
later?

We could also print a rude message the first time someone tries to use a
deprecated /proc file, just to help push the userspace tool developers
along.  Although I note that sys_bdflush() is still with us ;)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
