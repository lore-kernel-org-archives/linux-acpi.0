From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 13 Oct 2003 10:09:12 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310130958540.17450-100000@cherise>
References: <20031013133837.GA9178@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031013133837.GA9178-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > That exactly my point.  And I think it should not do full save/restore
> > on only VT switch, but we may try to have a better fine grained stuff for,
> > something like 'hey, X we have to go S3, please consider'.
> 
> I second that. Sure, VT switch is necessary, but it takes quite a few
> seconds, which is unacceptable for S1 for example (Radeon M7 needs the
> restore after S1 too).

It's also unncessary for X to do a full save/restore of the video card on 
every VT switch. I personally find it annoying to wait a second or two 
when switching from X to the console. 

The proper semantics can be obtained with this patch, which I sent to Alan 
last week after asking for a solution. It calls /sbin/hotplug on suspend 
and resume, passing the state that we're entering in the environment 
variables. 

To get this working, you need the latest hotplug package, and you need to
create the directory /etc/hotplug.d/power/. Applications may install
executables, or smlinks to executables, in that directory, which will be
called during both suspend and resume.

The kernel will wait for userspace to finish, so it is free to do whatever 
it needs (shutdown 3d engines, etc). For now, the kernel will not 
recognize the return value, though there should be a patch floating around 
in the -mm tree that fixes that.. 

AFAIK, this should also generate a D-BUS event that desktop applications 
may use to hook into the suspend/resume cycle. TBH, I'm not sure of the 
status of this in the hotplug package. 

The detail that is not worked out is how to signal X to perform a suspend 
resume. Though, extending the X API to trigger a graphics and input 
save/restore should be relatively straight-forward, and might be kinda 
fun. :) 

Barring any serious objections, I'll most likely be sending this to 
Linus/Andrew in the next couple of weeks..


	Pat

===== kernel/power/main.c 1.16 vs edited =====
--- 1.16/kernel/power/main.c	Mon Sep  8 15:13:46 2003
+++ edited/kernel/power/main.c	Tue Sep 30 15:35:47 2003
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kmod.h>
 #include <linux/pm.h>
 
 
@@ -117,6 +118,59 @@
 
 
 
+#ifdef CONFIG_HOTPLUG
+
+
+/**
+ *	user_suspend - notify userspace of suspend.
+ *
+ *	Notify userspace that we're going to sleep, and wait for it to finish
+ *	shutting down whatever it needs before we proceed.
+ *
+ */
+	
+static int tell_userspace(char * state, int suspend)
+{
+	char * argv[3];
+	char * envp[5];
+	char env_action[16];
+	char env_state[16];
+	int error;
+
+	if (!hotplug_path[0])
+		return 0;
+
+	argv[0] = hotplug_path;
+	argv[1] = "power";
+	argv[2] = NULL;
+
+	snprintf(env_state,16,"STATE=%s",state);
+	snprintf(env_action,16,"ACTION=%s",suspend ? "suspend" : "resume");
+
+	envp[0] = "HOME=/";
+	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[2] = env_action;
+	envp[3] = env_state;
+	envp[4] = NULL;
+
+	pr_debug("PM: Calling userspace: %s %s\n",env_action,env_state);
+
+	error = call_usermodehelper(argv[0],argv,envp,1);
+
+	return error;
+}
+
+
+#else /* CONFIG_HOTPLUG */
+
+
+static int tell_userspace(char * state, int suspend)
+{
+	return 0;
+}
+
+#endif 
+
 
 char * pm_states[] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
@@ -150,9 +204,12 @@
 		goto Unlock;
 	}
 
+	if ((error = tell_userspace(pm_states[state],1)))
+		goto Unlock;
+
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
-		goto Unlock;
+		goto Resume;
 	}
 
 	pr_debug("PM: Preparing system for suspend\n");
@@ -164,6 +221,8 @@
 
 	pr_debug("PM: Finishing up.\n");
 	suspend_finish(state);
+ Resume:
+	tell_userspace(pm_states[state],0);
  Unlock:
 	up(&pm_sem);
 	return error;



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
