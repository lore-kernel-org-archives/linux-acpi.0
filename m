From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: S5 Powerdown problem on TX150 servers
Date: Tue, 16 Sep 2003 09:12:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309160912.15060.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I have an issue with TX150 servers. Basically, they don't power down in 
ACPI. I press the power button, and I can see the system shutting down, but, 
although it clears the screen and kinda makes a clunking noise as if the HDDs 
are being stopped, the fans stay running, and the power light stays on.

I want the system to enter S5 when I press the power button.

I added some debug to the hwsleep.c/acpi_enter_sleep_state() function. The 
last thing it executes is:

status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, 
ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);

<-- DOES NOT GET HERE on button press.

        if (ACPI_FAILURE (status)) {
                return_ACPI_STATUS (status);
        }

Which kinda makes sense as this is the write of the PM1B value that completes 
powerdown.

However, if I press the power button once again, I can see that it RETURNS 
from this call, and displays the tracing I put after it. Its almost as if the 
system is going into S1 and not S5.

I've checked in the DSDT, and the values for PM1a_CNT.SLP_TYP and 
PM1b_CNT.SLP_TYP are correctly for entering an S5 state.

Anyone have any suggestions?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
