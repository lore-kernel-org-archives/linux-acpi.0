From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Integrating OS power management with the X server
Date: Mon, 25 Oct 2004 10:26:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417D372C.3000107@root.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050502030500080001080607"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: xorg-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org
Cc: Linux ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050502030500080001080607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Apologies for cross-posting this to two lists.  I am the FreeBSD ACPI 
maintainer and recently someone brought to my attention that the X 
server expects notification/control over the suspend/resume process. 
This event is implemented in this file:

xc/programs/Xserver/hw/xfree86/os-support/bsd/bsd_apm.c

This interface works for apm (except that it only has NetBSD defines 
currently) but is not implemented for ACPI.  I'd like more information 
as to what the X server actually does with this event.  Is there any 
situation where it actually needs to veto a suspend?  Does it 
potentially take seconds to save state?  Does it need to access other 
running subsystems or is it self-contained?

I've started by adding some compat defines for FreeBSD, in the attached 
patch.  Please let me know more about the expected semantics of this 
event and any caveats.

Thanks,
Nate

--------------050502030500080001080607
Content-Type: text/plain;
 name="bsd_apm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bsd_apm.diff"

--- bsd_apm.c.orig	Sat Oct  9 12:14:26 2004
+++ bsd_apm.c	Sat Oct  9 12:24:32 2004
@@ -8,12 +8,36 @@
 #include "xf86_OSproc.h"
 #include "xf86_OSlib.h"
 
+#ifdef __FreeBSD__
+#include <machine/apm_bios.h>
+#else
 #include <machine/apmvar.h>
+#endif
 
 #define APM_DEVICE "/dev/apm"
 
 static pointer APMihPtr = NULL;
 static void bsdCloseAPM(void);
+
+/* Compat defines for FreeBSD APM. */
+#ifdef __FreeBSD__
+#define APM_STANDBY_REQ		PMEV_STANDBYREQ
+#define APM_SUSPEND_REQ		PMEV_SUSPENDREQ
+#define APM_NORMAL_RESUME	PMEV_NORMALRESUME
+#define APM_CRIT_RESUME		PMEV_CRITRESUME
+#define APM_BATTERY_LOW		PMEV_BATTERYLOW
+#define APM_POWER_CHANGE	PMEV_POWERCHANGE
+#define APM_UPDATE_TIME		PMEV_UPDATETIME
+#define APM_CRIT_SUSPEND_REQ	PMEV_CRITSUSPENDREQ
+#define APM_USER_STANDBY_REQ	PMEV_USERSTANDBYREQ
+#define APM_USER_SUSPEND_REQ	PMEV_USERSUSPENDREQ
+#define APM_SYS_STANDBY_RESUME	PMEV_STANDBYRESUME
+#define APM_CAPABILITY_CHANGE	PMEV_CAPABILITIESCHANGE
+
+#define APM_IOC_NEXTEVENT	APMIO_NEXTEVENT
+#define APM_IOC_STANDBY		APMIO_STANDBY
+#define APM_IOC_SUSPEND		APMIO_SUSPEND
+#endif /* __FreeBSD__ */
 
 static struct {
     u_int apmBsd;

--------------050502030500080001080607--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
