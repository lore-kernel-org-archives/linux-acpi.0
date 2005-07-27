From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 16:09:07 -0700
Message-ID: <20050727160907.7d1ed683.akpm@osdl.org>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com>
	<1122407079.13241.4.camel@toshiba.lenb.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1122407079.13241.4.camel-g3qfMnKXm6m1ouK1UO9oVVDQ4js95KgL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> On Sun, 2005-05-22 at 07:25 -0400, Cameron Harris wrote:
> > I just upgraded from 2.6.11.3 and now my /proc/acpi/button directory
> > doesn't exist...
> 
> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?

Can we put it back, please?

> Note that over time everything in /proc/acpi is
> going away.  In this case, there didn't seem to be
> a case for making appear in /sys.

That'll be hard.  I guess we could add the new /sys entries, make sure that
userspace tool developers have migrated and then remove the /proc entries
in a year or so.

We cannot go ripping out stuff which applications and users are currently
using without quite a lot of preparation.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
