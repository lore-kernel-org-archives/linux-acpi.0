From: Praveen C <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: Re: acpi on r40e
Date: Tue, 10 Feb 2004 10:48:08 +0530 (IST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0402101040090.27892-100000@aero.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Interesting.
>If you boot, say with "acpi=off", your volume and brightness buttons
>work, but if you boot with ACPI enabled they have no effect?

Thats right. I know that many others with R40e are facing the same 
problems as me with acpi (hangup with processor/thermal modules and the 
special button problems). When I am booting an acpi kernel I have to 
adjust the brightness before the kernel starts. With acpi=off the 
buttons work without me doing anything extra.

There are other buttons which dont work either with or without acpi.  
For example Fn+F3 switches off the backlight in the display in Windows
but does nothing in Linux. In Linux I can switch off the backlight only
by closing the lid.

Regarding the hangup with processor/thermal modules I am not 
able to locate any messages in kernel log.

Is there any other information I can provide which help to identify the 
problem?

Thanks
praveen



 -- 
------------------------------------------------------------------------------
Praveen. C
CFD Center, Dept. of Aerospace Engg.
IISc, Bangalore - 560012, India
Phone: +91-80-3600904
http://www.cpraveen.tk
http://aero.iisc.ernet.in/~praveen
------------------------------------------------------------------------------



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
