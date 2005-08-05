From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: latest ACPI patch based on 2.6.13
Date: Thu, 4 Aug 2005 22:41:35 -0700
Message-ID: <20050804224135.6faeaf59.akpm@osdl.org>
References: <1123214969.13136.51.camel@toshiba>
	<1123220125.13136.77.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123220125.13136.77.camel@toshiba>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> The Latest ACPI patch based on 2.6.13 is available here:
> 
>  http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/acpi-20050729-2.6.13-rc6.patch
> 
>  These patches are exported to-akpm for inclusion in -mm
>  with the intent to integrate into 2.6.14.

Thanks, Len.

We do have a number of -mm-only acpi bugs which should be fixed before
we can send this on to Linus.

http://bugzilla.kernel.org/show_bug.cgi?id=4867
http://bugzilla.kernel.org/show_bug.cgi?id=4964
http://bugzilla.kernel.org/show_bug.cgi?id=4977
http://bugzilla.kernel.org/show_bug.cgi?id=4980

are the one's I've kept a record of.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
