From: Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>
Subject: Re: ACPI + loop(AES) + swsusp
Date: Mon, 19 Aug 2002 19:44:00 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D612050.F980C545@pp.inet.fi>
References: <Pine.SOL.4.44.0208181454300.2717-100000@mimosa.csv.warwick.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "John J. Lee" <jjl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Robert Stark <rstark-viLzafFedAGELgA04lAiVw@public.gmane.org>, Linux Mailinglists <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-crypto-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org, Sean Neakums <sneakums-iTLVOByc1N8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

"John J. Lee" wrote:
> Given your point about security, wouldn't it be nice if there were yet
> another flag to indicate that encrypted partitions should just be
> turned off on suspend?
> 
> This is more useful than it sounds -- not all partitions are mounted all
> the time.  It might actually be convenient if you don't want to
> accidentally leave a partition accessible when you walk away from a
> machine and forget to losetup -d, or whatever.

Like Sean Neakums pointed out in earlier post to linux-crypto list, just
forcing unmount or losetup -d is not really an option. Maybe just checking
for encrypted loops in userspace _before_ starting suspend is a better
solution. Something like this:

#!/bin/bash
if losetup -a | grep -q -s "AES" ; then
    echo "Found active encrypted loops, suspend aborted"
    exit 1
fi
echo "now suspending..."
echo "1 0 0" > /proc/sys/kernel/swsusp

Regards,
Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
