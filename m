From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: Re: [PATCH] filling in ACPI method access via sysfs namespace
Date: Fri, 09 Apr 2004 21:52:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4077535D.6020403@neggie.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com> <1081549317.2694.25.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081549317.2694.25.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alex Williamson wrote:
>    Here's another approach that's far less ugly than the last and is
> much more powerful.  The code is a little over half the size as a
> bonus.  Rather than specifically poking for certain methods and exposing
> them, this patch exposes everything.  The down side is that all reading
> and writing of the files need to use binary acpi data structures.  This
> interface certainly provides "shoot yourself in the foot" potential, but
> the access to the namespace from userspace is hard to beat.  Any
> thoughts on this approach versus the last?  This interface and a simple
> set of libraries to go along with it has a lot of potential.  Thanks,

The limitation of this interface is that it's not able to call an ACPI 
method with some arguments and get the return value, correct?

-John


-- 
http:// if  ile.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
