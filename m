From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Compaq 2552EA suspend/resume
Date: Mon, 10 Oct 2005 10:56:25 +0200
Message-ID: <20051010085625.GC2369@elf.ucw.cz>
References: <1128581461.8134.7.camel@localhost.localdomain> <20051006093525.GB10865@openzaurus.ucw.cz> <1128884950.12703.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1128884950.12703.3.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Ne 09-10-05 21:09:10, Hein-Pieter van Braam wrote:
> Actually, the problem is that it does everything but actually GO in S3,
> it just hangs on the console. Without patched DSDT S3 it keeps hanging
> on the console, with patches DSDT it comes out of the 'suspend'
> immediately...

Okay, you'll probably have to debug this yourself, or at least file it
in osdl bugzilla.
								Pavel

> On Thu, 2005-10-06 at 11:35 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > anyway, what happens when I try to enter S3, is (without patched DSDT)
> > > it tried to resume, then just sits there doing nothing. I can then
> > > switch to another console, and continue working, but I can't suspend
> > > again. 
> > 
> > So S3 works for you, once? Okay, so add printks to debug where it hangs,
> > than fix that :-).
> > 				Pavel



-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
