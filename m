From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: 2.6.6 + AcerTravelMate634 suspend
Date: Thu, 27 May 2004 09:17:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16565.41998.329541.40440@aber.ac.uk>
References: <20040527013436.GA2559@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040527013436.GA2559-Kz9ENIl45+A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Emma Jane Hogbin writes:
 > Hi everyone,
 > 
 > I just thought I'd let everyone know how my system behaves with the
 > various suspend options:
 > 	echo -n "standby" > /sys/power/state  
 > 		back light stays on in X
 > 		does nothing from the console
 > 		
 > 	echo -n "mem" > /sys/power/state  
 > 		system "goes away", no back light, "Zz" light goes on
 > 		Fn-F4 should work to put the computer into this state but it just
 > 		beeps and does nothing
 > 		can't restore (tried the power button, Fn-F4, moving the mouse, etc)
 > 		have to force power off with the power button and then force restart
 > 

Similar experience here.

 > 
 > 	echo -n "disk" > /sys/power/state 
 > 	system shuts off. No "Zz" light. When I use the power button to turn
 > 	the system back on it says that it was not shut down properly.
 > 

You have to have to reboot with a restore option on the command line (don't
have my laptop running at the moment so can't tell you exactly what, but
it's in the pm.txt (IIRC) in the kernel documentation.

I've had mixed results with that and a big disk crash which was possibly
due to that so I stopped trying ;-)

 > 
 > REMINDER: when I try to use poweroff and halt the computer does not power
 > off when acpi_power_off is called at the very end.
 > 

Same here.

Fred



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
