From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: S4bios support
Date: Thu, 13 Feb 2003 15:57:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030213155730.GA5170@clara.net>
References: <20030213163007.6fc31e08.nils@kernelconcepts.de> <Pine.LNX.4.33.0302131630010.7941-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302131630010.7941-100000-Hi2dXqvvzfEtpH44vsTDoQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bjorn Wesen [bjorn.wesen-VrBV9hrLPhE@public.gmane.org] wrote:
> I guessed that but how does the BIOS know where to suspend on the disk ? 
> Does the kernel tell it by giving the block ranges for the swap partition or 
> do you need to repartition the harddisk to contain some magic partitions ?

You need to repartition to create a magic partition.  If your laptop has
a phoenix bios then you set the partition type for the new partition to
IBM Hibernate Partition (can't remember the number, but it's in the
lphdisk manpage), make sure it's big enough for the amount of RAM you
have, format it with lphdisk and bingo (or that's the theory)


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

BOFH excuse #396:

Mail server hit by UniSpammer.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
