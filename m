From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Wed, 12 Feb 2003 15:08:19 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302121437110.1479-100000@localhost.localdomain>
References: <20030212203637.GA32274@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030212203637.GA32274-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Erik van Pienbroek <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org>, ACPI Mailinglist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 12 Feb 2003, Karol Kozimor wrote:

> Thus wrote Patrick Mochel:
> > ACPI should not allow a user to write '5' to that file. It used to be that 
> > way, but someone clever decided that that interface should support _all_ 
> > sleep states. (It might have been me, in one of my finer moments). 
> 
> May I ask: why? Is it really dangerous to leave it like it is now? Does it
> break anything? I actually used it a couple of times, not bothering to hold
> my poweroff button for the time needed to poweroff the machine completely.
> As for potential dangers, I see many other ways of using the /proc 
> interface that can be really *much* more harmful to the system, yet they
> don't cease to exist. However confusing it might be now, it is fully
> functional, at least. I can't really see any reason for crippling that
> functionality. Please, do leave it the way it is.

It's another chance to shoot yourself in the foot, and it should be 
removed. 

There is an explicit shutdown sequence that the kernel normally goes 
through. This does vitally important things like flushing disk buffers, 
etc. Circumventing this is asking for trouble, not to mention disk 
corruption. 

The fact that S5 is a sleep state is slightly confusing, but a decent 
design decision of the spec, since you can trigger a system to wake up. 
But that in no way justifies the mechanism to arbitrarily use it. 

The following patch removes support for triggering an S5 transition from 
proc/acpi/sleep. It also fixes an unchecked array reference with the value 
written to the file. 

It's for 2.5, though should be conceptually identical to anything in 2.4.  
Andy, you may apply manually, or wait a couple of days and I'll have a
bkbits.net tree you can pull from with a few other fixes in it..

	-pat

===== drivers/acpi/sleep.c 1.11 vs edited =====
--- 1.11/drivers/acpi/sleep.c	Mon Dec 30 06:29:15 2002
+++ edited/drivers/acpi/sleep.c	Wed Feb 12 14:58:09 2003
@@ -318,14 +318,14 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	acpi_status		status = AE_OK;
+	acpi_status		status = AE_ERROR;
 	char			state_string[12] = {'\0'};
 	u32			state = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_system_write_sleep");
 
 	if (count > sizeof(state_string) - 1)
-		return_VALUE(-EINVAL);
+		goto Done;
 
 	if (copy_from_user(state_string, buffer, count))
 		return_VALUE(-EFAULT);
@@ -333,22 +333,25 @@
 	state_string[count] = '\0';
 	
 	state = simple_strtoul(state_string, NULL, 0);
-	
+
+	if (state < 1 || state > 4)
+		goto Done;
+
 	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
 		software_suspend();
-		return_VALUE(count);
+		goto Done;
 	}
 #endif
 	status = acpi_suspend(state);
-
+ Done:
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
-	
-	return_VALUE(count);
+		return_VALUE(-EINVAL);
+	else
+		return_VALUE(count);
 }
 
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
