From: Mario Mikocevic <mario.mikocevic-ZeoyiJGIzEM@public.gmane.org>
Subject: IBM Thinkpad R40 problems
Date: Thu, 14 Aug 2003 10:55:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030814085537.GA26968@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I patched 2.6.0-test3 with acpi-20030730-2.6.0-test2.diff and some things are still not working quite right ->

with above patch :

 Machine check exception polling timer started.
 VFS: Disk quotas dquot_6.5.1
 Initializing Cryptographic API
-ACPI: AC Adapter [AC] (off-line)
+ACPI: AC Adapter [AC] (on-line)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Lid Switch [LID]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
-ACPI: Thermal Zone [THM0] (27 C)
+ACPI: Thermal Zone [THM0] (61 C)
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found

so at least temperature and AC outlet is detected fine but battery is still b0rked.

Next I had following errors :

ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.
EC__.BAT0._STA] (Node c12ca3a0), AE_TIME
ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.
EC__.BAT1._STA] (Node c12ca220), AE_TIME

so I patched with following (someone posted it on list)(sorry for space mangling)

--- linux/drivers/acpi/ec.c.mzg 2003-08-09 06:37:19.000000000 +0200
+++ linux/drivers/acpi/ec.c     2003-08-14 09:16:22.690872680 +0200
@@ -32,6 +32,7 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/actypes.h>


 #define _COMPONENT             ACPI_EC_COMPONENT
@@ -412,7 +413,8 @@
         * The EC object is in the handler context and is needed
         * when calling the acpi_ec_space_handler.
         */
-       *return_context = handler_context;
+       if(function == ACPI_REGION_DEACTIVATE) *return_context = NULL;
+               else *return_context = handler_context;

        return AE_OK;
 }
--- linux/drivers/acpi/events/evregion.c.mzg    2003-08-09 06:38:17.000000000 +0200
+++ linux/drivers/acpi/events/evregion.c        2003-08-14 09:17:53.245106344 +0200
@@ -382,7 +382,7 @@
        union acpi_operand_object       *obj_desc;
        union acpi_operand_object       **last_obj_ptr;
        acpi_adr_space_setup            region_setup;
-       void                            *region_context;
+       void                            **region_context;
        union acpi_operand_object       *region_obj2;
        acpi_status                     status;

@@ -394,7 +394,7 @@
        if (!region_obj2) {
                return_VOID;
        }
-       region_context = region_obj2->extra.region_context;
+       region_context = &region_obj2->extra.region_context;

        /* Get the address handler from the region object */

@@ -450,7 +450,7 @@

                        region_setup = handler_obj->address_space.setup;
                        status = region_setup (region_obj, ACPI_REGION_DEACTIVATE,
-                                         handler_obj->address_space.context, &region_context);
+                                         handler_obj->address_space.context, region_context);

                        /* Init routine may fail, Just ignore errors */

ok, after boot I've got :

 Machine check exception polling timer started.
 VFS: Disk quotas dquot_6.5.1
 Initializing Cryptographic API
 ACPI: AC Adapter [AC] (on-line)
+ACPI: Battery Slot [BAT0] (battery present)
+ACPI: Battery Slot [BAT1] (battery absent)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Lid Switch [LID]
 ACPI: Sleep Button (CM) [SLPB]

_BUT_ only _first_ attempt of cat /proc/acpi/battery/BAT0/state works,
after that it's :

ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.
EC__.GBST] (Node c12ca4a0), AE_AML_INTERNAL
ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.
EC__.BAT0._BST] (Node c12ca360), AE_AML_INTERNAL

any help ?


TIA,


-- 
Mario Mikocevic (Mozgy)
mozgy at hinet dot hr
It's never too late to have a good childhood!
      The older you are, the better the toys!
My favourite FUBAR ...


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
