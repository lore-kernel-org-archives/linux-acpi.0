From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH] ibm-acpi-0.8 (was Re: 2.6.10-rc1-mm3)
Date: Mon, 29 Nov 2004 11:34:30 +1100
Message-ID: <1101688470.25347.25.camel@localhost.localdomain>
References: <200411081334.18751.annabellesgarden@yahoo.de>
	 <200411082240.02787.annabellesgarden@yahoo.de>
	 <20041108153022.N14339@build.pdx.osdl.net>
	 <20041109013013.GA21832@aero.ensim.com>
	 <20041108181224.F2357@build.pdx.osdl.net>
	 <20041109023119.GB21832@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041109023119.GB21832-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Karsten Wiese <annabellesgarden-LWAfsSFWpa4@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, lkml - Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-11-08 at 18:31 -0800, Borislav Deianov wrote:
> On Mon, Nov 08, 2004 at 06:12:24PM -0800, Chris Wright wrote:
> > 
> > Ah, even better.  Thanks Boris.  BTW, you could probably mark ibm_init()
> > and ibm_handle_init() as __init.
> 
> Good point, I'll do it in the next version.

You cannot use module_param the way you are trying to: it must be used
at the top level, and it will be called before your module's init
function.

This patch might serve as a starting point...
Rusty.

Name: Fix Parameter Handling in ibm_acpi.c
Status: Untested
Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>

You can't call module_param et al inside a function.  It doesn't make
sense, and it doesn't work.

Index: linux-2.6.10-rc2-bk11-Module/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.10-rc2-bk11-Module.orig/drivers/acpi/ibm_acpi.c	2004-11-29
11:30:51.723729720 +1100
+++ linux-2.6.10-rc2-bk11-Module/drivers/acpi/ibm_acpi.c	2004-11-29
11:31:08.757140248 +1100
@@ -1147,21 +1147,26 @@
 		object##_paths, sizeof(object##_paths)/sizeof(char*), required)
 
 
-static void ibm_param(char *feature, char *cmd)
+static int set_ibm_param(const char *val, struct kernel_param *kp)
 {
-	int i;
+	unsigned int i;
+	char arg_with_comma[32];
+
+	if (strlen(val) > 30)
+		return -ENOSPC;
+
+	strcpy(arg_with_comma, val);
+	strcat(arg_with_comma, ",");
 
-	strcat(cmd, ",");
 	for (i=0; i<NUM_IBMS; i++)
-		if (strcmp(ibms[i].name, feature) == 0)
-			ibms[i].write(&ibms[i], cmd);
-}	
-
-#define IBM_PARAM(feature) do {					\
-	static char cmd[32];					\
-	module_param_string(feature, cmd, sizeof(cmd) - 1, 0);	\
-	ibm_param(#feature, cmd);				\
-} while (0)
+		if (strcmp(ibms[i].name, kp->name) == 0)
+			return ibms[i].write(&ibms[i], arg_with_comma);
+	BUG();
+	return -EINVAL;
+} 
+
+#define IBM_PARAM(feature) \
+	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
 static void __exit acpi_ibm_exit(void)
 {
@@ -1216,16 +1221,6 @@
 		}
 	}
 
-	IBM_PARAM(hotkey);
-	IBM_PARAM(bluetooth);
-	IBM_PARAM(video);
-	IBM_PARAM(light);
-	IBM_PARAM(dock);
-	IBM_PARAM(bay);
-	IBM_PARAM(cmos);
-	IBM_PARAM(led);
-	IBM_PARAM(beep);
-
 	return 0;
 }
 
@@ -1235,3 +1230,13 @@
 MODULE_AUTHOR("Borislav Deianov");
 MODULE_DESCRIPTION(IBM_DESC);
 MODULE_LICENSE("GPL");
+
+IBM_PARAM(hotkey);
+IBM_PARAM(bluetooth);
+IBM_PARAM(video);
+IBM_PARAM(light);
+IBM_PARAM(dock);
+IBM_PARAM(bay);
+IBM_PARAM(cmos);
+IBM_PARAM(led);
+IBM_PARAM(beep);


-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
