From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fw: powersave not working with amd64 on nforce 4 board
Date: Thu, 28 Jul 2005 12:29:47 -0400
Message-ID: <20050728162947.GB26599@redhat.com>
References: <20050727161646.05c40b3a.akpm@osdl.org> <200507281025.25183.rjw@sisk.pl> <20050728013416.6cd24d6e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050728013416.6cd24d6e.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org, Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 28, 2005 at 01:34:16AM -0700, Andrew Morton wrote:
 > "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
 > >
 > > n Thursday, 28 of July 2005 01:16, Andrew Morton wrote:
 > >  > 
 > >  > It might help if you were to raise a bugzilla entry for this..
 > > 
 > >  More likely it's BIOS bug.  I ran 2.6.13-rc3-mm1 on a box with nForce4
 > >  and it worked fine except I needed to apply the attached patch from
 > >  Mark Langsdorf, since the CPU is a dual-core.
 > > 
 > >  BTW, any chance to include this patch in -mm?
 > 
 > Spose so.  Would prefer that Mark himself sends it though.
 > 
 > Dave, does it look sane?

Yes it does, I meant to send this along, but got caught up
in the usual OLS-travelling foo. I'll clear the cpufreq
backlog today, as there's 2-3 other bits that really should
make it into .13

Thanks,

		Dave


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
