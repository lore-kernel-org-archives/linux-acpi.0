From: Mike Mestnik <cheako911-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Maby it's fixed now, I turned off one of the battery monitors.
Date: Sun, 7 Mar 2004 13:49:52 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040307214952.39886.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > -----Original Message-----  FROM ACPI LIST.
> > From: Yu, Luming [mailto:luming.yu-lUQJ9CVx3tM@public.gmane.org]
> > Sent: Tuesday, February 17, 2004 3:46 PM
> > To: Ow Mun Heng; Acpi-List (E-mail)
> > Subject: RE: [ACPI] 2.6.3-rc3 + D600 + battery status missing
> > sometimes..

> Here is the dmsg output I get.
>     ACPI-0279: *** Error: Looking up [BST0] in namespace,
AE_ALREADY_EXISTS
>     ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST]
(Node
cffc8cc0), AE_ALREADY_EXISTS
> This is outputed every time battery status is checked, I have 2 programs
> doing this.  Lookes like there is a locking problem.

I THINK it has stoped now that I turned off one of my battery monitors. 
It also seams to have something todo with closing the lid/screen, but this
could be unrelated.

I would look for problems with preemptation of the [1]status get ioctl it
self.  This is a single CPU system Dell Inspiron 3800.

[1] What ever IO that programs do to get the status of the battery, the
kernel side.


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
