From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] filling in ACPI method access via sysfs
	namespace
Date: Sat, 10 Apr 2004 14:42:57 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081629776.2562.40.camel@wilson.home.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net>
	 <1081566768.2562.8.camel@wilson.home.net>  <407786C6.7030706@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <407786C6.7030706-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-04-09 at 23:31, John Belmonte wrote:
> 
> You may want to look at the acpi-devel thread "[rfc] generic testing 
> ACPI module", where this issue was discussed 
> (http://sourceforge.net/mailarchive/message.php?msg_id=7455349).

   Ok, I took a look.  The open/write/read/close interface seems to be
the best approach.  It shouldn't be too hard, except the read/write
interfaces don't pass in the attribute pointer like they do for the
show/store interface.  Is this a bug?

   A nice feature of the current implementation is that I have one show
function that reads the method name out of the attribute structure. 
With the bin_file interface, I'd need to have a different read/write
function for every possible method on a kobject.  I also lose the
convenience of being able extend the container structure to meet my
needs.  Am I strecthing the use of the bin_file too far or should these
interfaces pass the attribute pointer?  Thanks,

	Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
