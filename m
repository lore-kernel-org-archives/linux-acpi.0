From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 00:34:20 -0700
Message-ID: <20050908003420.00e49325.akpm@osdl.org>
References: <1126163937.21723.12.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1126163937.21723.12.camel@toshiba>
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
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Linus, please pull from the release branch here:
> 
>  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

There are a few bugs which I'd identified as arising from the acpi tree
while it was in -mm.  Is this patch likely to drag them into mainline?

They include:


http://bugzilla.kernel.org/show_bug.cgi?id=4977
            Summary: ACPI 20050708 fails on HP RX2600 platform

http://bugzilla.kernel.org/show_bug.cgi?id=4867
            Summary: bug in ACPI crashes machine when reading
                     /proc/acpi/thermal_zone/THRM/temperature

http://bugzilla.kernel.org/show_bug.cgi?id=4980
            Summary: krash on entering mem sleep

Plus we have all the battery monitor woes, but they're in 2.6.13 already.

Thanks.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
