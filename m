From: Matthew Wilcox <willy-+nN6oZZ19oAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Sleeping in interrupt context
Date: Fri, 6 Sep 2002 10:13:42 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020906161342.GA20665@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


We're using GFP_KERNEL where we should be using GFP_ATOMIC in
acpi_bus_generate_event().  Here's a route to it:                                      
Find an ACPI button:

acpi_button_add
|-> acpi_install_fixed_event_handler(acpi_button_notify);
    |-> acpi_gbl_fixed_event_handlers[event].handler =
acpi_button_notify
                    
Get an interrupt:

acpi_ev_sci_handler 
|-> acpi_ev_fixed_event_detect
    |-> acpi_ev_fixed_event_dispatch
        |-> acpi_gbl_fixed_event_handlers[event].handler
            |-> acpi_button_notify
                |-> acpi_bus_generate_event
                    |-> kmalloc(sizeof(struct acpi_bus_event), GFP_KERNEL);

And we get a BUG() if that slab needs a new page.  Here's a patch:

Index: drivers/acpi/bus.c
===================================================================
RCS file: /var/cvs/linux/drivers/acpi/bus.c,v
retrieving revision 1.3
diff -u -p -r1.3 bus.c
--- drivers/acpi/bus.c	19 Aug 2002 12:04:38 -0000	1.3
+++ drivers/acpi/bus.c	6 Sep 2002 16:08:35 -0000
@@ -660,7 +660,7 @@ acpi_bus_generate_event (
 	if (!event_is_open)
 		return_VALUE(0);
 
-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_KERNEL);
+	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
 	if (!event)
 		return_VALUE(-ENOMEM);
 

-- 
Due to broken mail software, I lost 100 email messages between Aug 13 and
Aug 19.  If yours was one of them, please resend.

It's always legal to use Linux (TM) systems
http://www.gnu.org/philosophy/why-free.html


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
