From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: (newbie) apci patch for 2.4.19 bug?  and S3? 2.5.33==joy?
Date: Wed, 11 Sep 2002 12:54:56 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209111654.g8BGsuI05703@p2.parker.boston.ma.us>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

My name is Brad and I have an HP zt1260... :-)

It has no apm support;  I installed RH 7.3 but got frustrated with no
power management which led me down the path to acpi...

I found some excellent instructions here for building a 2.4.19 kernel
and cleaning up bad DSDT tables:

  http://www.cpqlinux.com/acpi-howto.html

I managed to fix up my broken DSDT table and get the kernel to use my
cleaned up version.  With a better DSDT my ac-power and battery status
are now clean and appear correct.

I still want S3, however, since a sleeping notebook makes for a happy
notebook owner :-)

Two questions:

1. with the 20020821-2.4.19 patch, in drivers/acpi/system.c:acpi_suspend(),
the first "if" looks wrong.  Won't that if always return an error,
no matter what?

i.e.
	if (state != ACPI_STATE_S1 || state != ACPI_STATE_S5)
	   return AE_ERROR;

if state == 1 you get (1 != 1 || 1 != 5) or ( f | t )
if state == 3 you get (3 != 1 || 3 != 5) or ( t | t )

so it always fails, right?  I think it should be

	if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)
	   return AE_ERROR;

2. I noticed a note on the list which said S3 is implemented in
2.5.33.  The above test implies that S3 won't work in 2.4.x.  I tried
it and like others have reported, it goes off but when turned back on
the backlight does not come on and the notebook won't respond until I
reset it.  S1 seems to work fine (as does S5).

So my question is, if I run 2.5.33 will I find joy trying S3?

And, will the S3 fix every be backported to 2.4.x?

Also, any suggestions about the relative stability of 2.5.33 or 2.5.34?  

(note that I'm no kernel newbie - I write drivers all day long, so all
I need is some feedback from someone actually using these 2.5 kernels,
i.e. are they stable enough for useful work?)

thanks!

-brad

Brad Parker
Heeltoe Consulting
781-483-3101
http://www.heeltoe.com


-------------------------------------------------------
In remembrance
www.osdn.com/911/
