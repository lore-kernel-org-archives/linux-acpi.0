From: John Gruenenfelder <johng-94UORaXeK15yz7m2JG+yfZVzexx5G7lz@public.gmane.org>
Subject: ACPI on Sony Vaio F490 laptop
Date: Tue, 18 May 2004 22:48:22 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040519054822.GA23135@as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

I am using ACPI on my Sony Vaio F490 laptop with Linux kernel 2.6.6.  Given
the age of the laptop (it's a P3-650 machine), I must boot with acpi=force for
ACPI to work.

For the most part, ACPI is working well, but I am missing a few features.
Namely, I cannot suspend (any type), nor can I control the LCD backlight.
Suspend did work, mostly, when using APM instead of ACPI, though some of the
drivers in 2.6.6 didn't care much for the suspend.

At first I suspected that this might be due to a bad ACPI implementation (I've
read that this is common).  I dumpded the DSDT and decompiled it.  When I
recompiled it I found that there was only one minor error in a section related
to the embedded controller.  After fixing that there were no errors and no
warnings.

That was the most I could think to do on my own.  How can I help to get these
features working on my laptop?


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng-xN8xRfjKI9JQXdO203pMgQ@public.gmane.org
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
