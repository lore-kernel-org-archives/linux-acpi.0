From: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: Mon, 20 Jan 2003 19:45:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2C43D3.3020307@gmx.net>
References: <1043083690.1702.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1043083690.1702.15.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Christian,

Christian Brix Folsted Andersen wrote:
> I'm running RedHat 8.0 on my Compaq EVO N160 laptop.
> 
> What might be the problem?

As far is I know, it's because of some errors in the DSDT of the Compaq 
Evo N160. I also have this notebook and have fixed at least the obvious 
errors (and wrong information about the battery).

--> You should take a fixed DSDT and include in into your kernel.

Steps:
- Get a fixed DSDT. You could try mine from 
http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_dsdt.asl , but 
you should alter it to fit to your battery. I've coded the current 
maximum capacity of my battery (3357 mAh instead of 4000 mAh for a new 
battery) into it - see my posting of 14 december 2002 for details about 
the battery part.
- Compile your DSDT with Intel's ASL compiler into a c source code file 
and copy it to kernel-src-dir/drivers/acpi/tables/acpi_dsdt.c.
- [Don't know by heart if this is needed with current acpi patches] 
Apply a patch to your kernel that makes it use your DSDT.
- Compile your kernel once again.
- Boot it...

I'm sorry that I couldn't write it in more detail, but I my Evo N160 is 
not running at the moment and I'm busy... I hope you'll find out how to 
use the information I could give you by now.

Some links that could help you, especially for finding Intel's ASL 
compiler and patching your kernel:

http://www.cpqlinux.com/acpi-howto.html
http://dude.noc.clara.net/~faye/compaq2701ea/

Kind regards
Heiko



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
