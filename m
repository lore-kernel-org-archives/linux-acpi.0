From: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Subject: S4 suspend update on Toshiba Satellite 5105-S501
Date: Tue, 25 Mar 2003 21:53:00 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030326055300.GA582@budgie.we1.client2.attbi.com>
References: <200303252152.h2PLqcP25841@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303252152.h2PLqcP25841-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>; from bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org on Tue, Mar 25, 2003 at 13:52:38 -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I updated my 2.5.65 kernel with the acpi-20030321 patches and tried
doing a s4 suspend from within X.  I was able to repeatedly suspend/
resume without having to disable DMA on the hard drive (this would
not work under previously).  However, on the second and subsequent
suspends, the machine failed to shut down in the s5 state.  Instead,
the console displayed the following and hung (copied by hand):

.....
Suspend Machine: Trying to power down
shift_state: 0000
Shutting down devices
acpi_power_off called
  hwsleep-257 [S4:] acpi_enter_sleep_state: Entering sleep state [S5]

I waited about 20 seconds after the second hang before cycling power
and rebooting.  On reboot, the CPU can immediately came on (it is not
controlled via ACPI) and the kernel indicated it was running pretty hot
(about 80C).  So apparently after hanging, it certainly wasn't
sleeping.

In addition (and I'm not sure this is an ACPI problem), the PCMCIA
card manager was dead upon resume; restarting it indicated that one
of the sockets was already in use so it couldn't resume.

Ken


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
