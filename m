From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep status report
Date: Tue, 26 Aug 2003 01:25:30 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308260125.30194.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_azoS/pSZkFiWC8B"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_azoS/pSZkFiWC8B
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just found out that by 'echo sth_wrong > /sys/power/state' the kernel would 
oops in a fatal way (no clean exit from there).
The oops suggested that the code would enter an invalid fn.

You may apply the included patch to solve the bug. IMHO doing a clean exit is 
much preferrable than having BUG() there.

In the patch I also added some double checking of the fn. You may disable that  
(although sleeping is a one time fn which won't be slowed dow by that). 

Status report:  (HP Omnibook XE3GC)
S1 ('standby') works
S3, S4bios will suspend, but NOT resume.
that's the same as previous kernels I've tested so far.

I still have the ALSA-artsd deadlock I reported w. -test1 (in short, artsd 
resumes from S1 in a 'disk I/O' process state, which deadlocks maestro3)
see: http://marc.theaimsgroup.com/?l=linux-kernel&m=105836807605512&w=2



--Boundary-00=_azoS/pSZkFiWC8B
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sys-power-state.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sys-power-state.diff"

diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c /usr/src/linux/kernel/power/main.c
--- /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23 12:13:17.000000000 +0300
+++ /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300
@@ -304,6 +304,20 @@
 		goto Unlock;
 	}
 
+# if 1 		/* disable once we're sure we got it right */
+	/* double - check  code */
+	if (!s ) {
+		printk (KERN_ERR "Invalid suspend state %d\n",state);
+		error = -EINVAL;
+		goto Unlock ;
+	}
+	if (! s->fn) {
+		printk(KERN_ERR "Invalid fn for suspend state %d\n", state );
+		error = -EINVAL ;
+		goto Unlock;
+	}
+# endif
+
 	pr_debug("PM: Preparing system for suspend.\n");
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
@@ -500,7 +514,7 @@
 		if (s->name && !strcmp(buf,s->name))
 			break;
 	}
-	if (s)
+	if ( (s) && (state < PM_SUSPEND_MAX) )
 		error = enter_state(state);
 	else
 		error = -EINVAL;

--Boundary-00=_azoS/pSZkFiWC8B--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
