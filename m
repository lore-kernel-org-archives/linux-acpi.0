From: Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
Subject: Re: Laptop does not reboot
Date: Fri, 05 Mar 2004 00:56:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4047C22B.514DD10B@imail.de>
References: <403E59FF.990E2CD0@imail.de>
 <200402270209.04355.bernd-schubert@web.de> <4044A787.4ABB6C89@imail.de>
Reply-To: u490248-uKKRHEr75Vc@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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

Dieter Rohlfing wrote:

> > maybe you should also give 2.6.x a try?
> 
> I downloaded kernel 2.6.3 and guess ... rebooting now works. :-)

I evaluated kernel 2.6.3. Okay, rebooting works, but because of some
other reasons I must stay with 2.4.x.

As last chance I tried kernel 2.4.22 and guess ... rebooting works. :-)

Therefore I studied the ChangeLogs from 2.4.23 up to 2.4.25. There were
a lot of changes in the ACPI parts, and I suppose, that some of those
changes make my laptop not properly rebooting.

Because 2.6.3 properly reboots my laptop, I have the little hope, that
all ACPI changes are backported to 2.4.x.

Dieter

-- 
Every mail not from this mailing list will be deleted.
Please reply only to this mailing list.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
