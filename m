From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: fan control
Date: Tue, 6 May 2003 17:04:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506150400.GU2954@poup.poupinou.org>
References: <20030506092120.GA24982@lps.ens.fr> <01bb01c313be$1845afc0$b8d21b2b@ADACHIPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <01bb01c313be$1845afc0$b8d21b2b-5Bsh/8v8vXc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
Cc: '?$B%Nric Brunet' <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 06, 2003 at 07:56:06PM +0900, Adachi, Kenichi wrote:
> Hi,
> 
> > About fan control, I would love to be able to stop my fan, but it
> doesn't
> > work. I can echo anything to /proc/acpi/fan/FAN/state, it has no
> bearing
> > on the fan, and the only result is a line in the log:
> > > acpi_bus-0199 [18] acpi_bus_set_power    : Device is not power
> manageable
> > (kernel is 2.5.67)
> > 
> acpi_bus_set_power() complains that the target device is not enabled to
> be power managed as its "power_manageable" flag, which will be set for
> devices who have _PS0 or _PR0 in DSDT upon device enumeration, is
> __NOT__ set. And, indeed, your FAN device in DSDT doesn't explicitly
> list its power resource by _PR0 Object.
> 
>    5369 000034ba: Scope _TZ_ (\_TZ_)
>    5370 000034c2:   Device FAN_ (\_TZ_.FAN_)
>    5371 000034c9:     Name _HID (\_TZ_.FAN_._HID)
>    5372 000034ce:       PNP0c0b (0x0b0cd041)
>    5373 000034d3:     Method _INI (\_TZ_.FAN_._INI)
>    5374 000034d9:       ArgCount 0; NotSerialized
>    5375 000034da:       Store
>    5376 000034db:         TP1H (000032ad)
>    5377 000034df:         CTOS
>    5378 000034e3:       Store
>    5379 000034e4:         TP1L (000032b2)
>    5380 000034e8:         CTHY
> 

A way to go is to add the missing in the asl.
(Eric, I think it's better than the module I send you privately).

--- dsdt.dsl	2003/05/06 14:01:15	1.1
+++ dsdt.dsl	2003/05/06 14:11:40
@@ -319,12 +319,12 @@
     {
         Method (_MSG, 1, NotSerialized)
         {
-            Store (Local0, Local0)
+            Noop
         }
 
         Method (_SST, 1, NotSerialized)
         {
-            Store (Local0, Local0)
+            Noop
         }
     }
 
@@ -3035,7 +3035,6 @@
                         DISD (0x01)
                     }
 
-                    Store (Local0, Local0)
                 }
 
                 Method (_CRS, 0, NotSerialized)
@@ -3645,6 +3644,8 @@
         }
     }
 
+    Name (FANS, One)
+
     Method (FON, 0, NotSerialized)
     {
         SBYT (0x13, 0x46)
@@ -3653,6 +3654,7 @@
         SBYT (0x14, Local0)
         Store (GBYT (0x53), Local0)
         SBYT (0x13, Local0)
+	Store (One, FANS)
     }
 
     Method (FOFF, 0, NotSerialized)
@@ -3662,10 +3664,27 @@
         SBYT (0x14, 0xD0)
         Store (GBYT (0x13), Local0)
         SBYT (0x53, Local0)
+	Store (Zero, FANS)
     }
 
     Scope (\_TZ)
     {
+        PowerResource(PFAN,0,0)
+	{
+	    Method(_STA)
+	    {
+	        Return(\FANS)
+	    }
+	    Method(_ON)
+	    {
+	        \FON()
+	    }
+	    Method(_OFF)
+	    {
+	        \FOFF()
+	    }
+	
+	}
         Device (FAN)
         {
             Name (_HID, EisaId ("PNP0C0B"))
@@ -3674,6 +3693,7 @@
                 Store (TP1H, CTOS)
                 Store (TP1L, CTHY)
             }
+	    Name(_PR0, Package() { PFAN })
         }
 
         ThermalZone (THRM)

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
