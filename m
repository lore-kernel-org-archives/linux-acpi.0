From: Praveen C <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: acpi on r40e
Date: Sat, 7 Feb 2004 21:50:59 +0530 (IST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0402072145280.2886-100000@aero.iisc.ernet.in>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Did you deselect thermal and processor modules to be able to boot
>without hang?
>But we need boot log of kernel with thermal and processor modules, and
>don't forget
>to get acpi debug option selected.
>
>--Luming

I select all of them as modules and load only those which work. The
moment I load processor or thermal module the system hangs and I have
to reboot. I have looked at the kernel log there is nothing related to 
processor/thermal modules. It looks like the system totally hangs so 
that kernel is not able to print any messages.

Another problem with acpi which I forgot to mention is that it makes
the special buttons for volume and brightness control ineffective. If I
boot the same kernel with acpi=off those buttons work fine.

I have selected all the options in ACPI. My kernel config file is here
http://www.flatface.net/~praveen/tp/linux-2.6.1-config.txt



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
