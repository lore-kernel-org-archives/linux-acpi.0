From: "Anthony J. Breeds-Taurima" <tony-xfCdrj5MXxYnC9Muvcwxkw@public.gmane.org>
Subject: Re: swsusp acpi-20021022
Date: Sat, 2 Nov 2002 14:54:03 +0800 (WST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211021442430.6335-100000@thor.cantech.net.au>
References: <20021031110654.GB27413@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021031110654.GB27413-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 31 Oct 2002, Ducrot Bruno wrote:

> No.  A simple fsck should be OK, but be warned that this kernel has 
> a known bug for fs corruption, and is somehow broken in syncing ide
> disks.  Take a look at 2.5.44-ac5 instead.

Great, I'm running 2.5.44-ac5 ATM (does 2.5.45 have the same IDE issues?) that
has other swsups issues for me but I think they're mostly my own doing.

Incase it is of use to anyone My original (handwritten oops) is available at:
	http://thor.cantech.net.au/~tony/swsusp/hand.txt
and the results of running that through ksymoops 2.4.6 are at
	http://thor.cantech.net.au/~tony/swsusp/ksymoops.txt

I think I've made at least one mistake in the oops :(

Thanks to all that gave advice on getting my machine back.  I'll be less
squeamish next time (and I'll have backups of the rwally important stuf just
in case)


Yours Tony

   Jan 22-25 2003           Linux.Conf.AU            http://linux.conf.au/
		  The Australian Linux Technical Conference!



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
