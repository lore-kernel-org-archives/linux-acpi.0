From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: ACPI + loop(AES) + swsusp
Date: Fri, 2 Nov 2001 13:56:18 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20011102135618.C35@toy.ucw.cz>
References: <Pine.SOL.4.44.0208181454300.2717-100000@mimosa.csv.warwick.ac.uk> <3D612050.F980C545@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D612050.F980C545-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>; from jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org on Mon, Aug 19, 2002 at 07:44:00PM +0300
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>
Cc: "John J. Lee" <jjl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Robert Stark <rstark-viLzafFedAGELgA04lAiVw@public.gmane.org>, Linux Mailinglists <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-crypto-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org, Sean Neakums <sneakums-iTLVOByc1N8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Given your point about security, wouldn't it be nice if there were yet
> > another flag to indicate that encrypted partitions should just be
> > turned off on suspend?
> > 
> > This is more useful than it sounds -- not all partitions are mounted all
> > the time.  It might actually be convenient if you don't want to
> > accidentally leave a partition accessible when you walk away from a
> > machine and forget to losetup -d, or whatever.
> 
> Like Sean Neakums pointed out in earlier post to linux-crypto list, just
> forcing unmount or losetup -d is not really an option. Maybe just checking
> for encrypted loops in userspace _before_ starting suspend is a better
> solution. Something like this:

Agreed. Decision if keys should go to disk is user decision (btw they *do*
go to disk if BIOS is used to suspend-to-disk; some notebooks do s-t-d 
automagially on battery fail), so it has to be userspace.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
