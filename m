From: Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
Subject: Re: Laptop does not reboot
Date: Sat, 06 Mar 2004 18:51:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404A0F92.3BBD5BC8@imail.de>
References: <403E59FF.990E2CD0@imail.de>
 <200402270209.04355.bernd-schubert@web.de> <4044A787.4ABB6C89@imail.de>
 <4047C22B.514DD10B@imail.de>
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

> As last chance I tried kernel 2.4.22 and guess ... rebooting works. :-)
> 
> Therefore I studied the ChangeLogs from 2.4.23 up to 2.4.25. There were
> a lot of changes in the ACPI parts, and I suppose, that some of those
> changes make my laptop not properly rebooting.

I must correct my statement/presumption from yesterday. Further testing
yielded, that the aty framebuffer driver is the "bad guy". Why?

I compiled a kernel 2.4.25 with vesa and aty framebuffer included. When
I boot with video=atyfb:off and video=vesa, I can properly reboot. But
when I boot with video=atyfb and video=vesa:off, I cannot properly
reboot. The same is true with kernel 2.4.22.

I'll write an email to Geert Uytterhoeven and Daniel Mantione (developer
of atyfb) and ask them for their opinion about this matter.

Again, many thanks for listening and replying.

Dieter

-- 
Every mail not from this mailing list will be deleted.
Please post your answers only to this mailing list.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
