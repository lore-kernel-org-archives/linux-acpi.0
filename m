From: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: More info on VP6 panics
Date: Sat, 17 Jan 2004 00:50:53 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4008DB4D.8090407@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Background:  I get a kernel panic when I boot 2.4.2{2,3,4} with ACPI on
my dual-processor Abit VP6.  Compiling the kernel with CONFIG_DEBUG_SLAB
turned on allows it to boot, as does booting with "idle=poll".

I do not believe that the panic occurs anywhere in the ACPI code.  From
what I can tell, the transition to ACPI mode causes the idle thread on
the other processor to panic.

I believe that I have identified the line of code that triggers the
panic.  It is the actual transition to ACPI mode at
drivers/acpi/hardware/hwacpi.c, line 143.  If I insert an infinite loop
before the call to acpi_os_write_port, the boot process simply hangs.
If I move the loop below the call to acpi_os_write_port, I get the same
old panic message.

How can I debug this further?

Thanks!
-- 
========================================================================
Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
========================================================================



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
