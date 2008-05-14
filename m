From: Len Brown <lenb@kernel.org>
Subject: Re: Subject:ACPI: Send the reserved AC notification event to user space
Date: Wed, 14 May 2008 19:04:18 -0400
Message-ID: <200805141904.18579.lenb@kernel.org>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com> <200805132055.28148.lenb@kernel.org> <1210733239.7932.10.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59073 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbYENXEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 19:04:32 -0400
In-Reply-To: <1210733239.7932.10.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 13 May 2008, Zhao Yakui wrote:
> On Tue, 2008-05-13 at 20:55 -0400, Len Brown wrote:
> > On Friday 09 May 2008, Zhao Yakui wrote:
> > > Subject:ACPI: Send the reserved AC notification event to user space 
> > > >From : Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > > On some laptops the bogus bios sends the reserved AC notification event(0x81)
> > > when the AC adapter is plugged/unplugged .It can't be sent to 
> > > user space, which causes that user space application can't 
> > > receive the AC adapter event. 
> > > So the reserved AC adapter event(0x81) is still sent to the user space 
> > > so that user space can receive the notification event.
> > > 
> > > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > > ---
> > >  drivers/acpi/ac.c |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > Index: linux-2.6/drivers/acpi/ac.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/ac.c
> > > +++ linux-2.6/drivers/acpi/ac.c
> > > @@ -42,6 +42,7 @@
> > >  #define ACPI_AC_DEVICE_NAME		"AC Adapter"
> > >  #define ACPI_AC_FILE_STATE		"state"
> > >  #define ACPI_AC_NOTIFY_STATUS		0x80
> > > +#define ACPI_AC_NOTIFY_RESERVED		0x81
> > >  #define ACPI_AC_STATUS_OFFLINE		0x00
> > >  #define ACPI_AC_STATUS_ONLINE		0x01
> > >  #define ACPI_AC_STATUS_UNKNOWN		0xFF
> > > @@ -233,6 +234,9 @@ static void acpi_ac_notify(acpi_handle h
> > >  
> > >  	device = ac->device;
> > >  	switch (event) {
> > > +	case ACPI_AC_NOTIFY_RESERVED:
> > 
> > shouldn't this line above be "default:"
> If the follwing debug info is not needed, it will be OK to put it above
> the "default" branch.
>   > "Unsupported event [0x%x]\n", event. 
> When this line is put above the "AC_NOTIFY_STATUS" branch, it can send
> the notification event to user space while printing the debug info. 
> > and the default: below this patch be removed?
> Had better not remove the default branch. If other type of notification
> event is sent to AC device, the debug info can be printed. It will be
> helpful to find the root cause.
> > -Len
> > 
> > > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > > +				  "Unsupported event [0x%x]\n", event));
> > >  	case ACPI_AC_NOTIFY_STATUS:
> > >  	case ACPI_NOTIFY_BUS_CHECK:
> > >  	case ACPI_NOTIFY_DEVICE_CHECK:
> > > 
> > > 

Maybe I'm too tired to parse what you're saying.
What is the matter with doing it this way:
(this is now bugzilla 10695, btw.


diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 5b73f6a..831883b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -233,6 +233,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 
 	device = ac->device;
 	switch (event) {
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -244,11 +247,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 #endif
-		break;
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
-		break;
 	}
 
 	return;

