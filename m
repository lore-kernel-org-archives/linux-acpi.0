From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: OperationRegion outside scope
Date: Fri, 12 Nov 2004 16:32:16 +0100
Message-ID: <20041112153216.GF31422@poupinou.org>
References: <20041112104755.50219.qmail@web41113.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041112104755.50219.qmail-azSxi+4N0UiA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 12, 2004 at 02:47:54AM -0800, Paulo da Silva wrote:
> Hello,
> 
> my DSDT has some operation regions defined outside a
> scope and when I compile with iasl I see that the size
> of the operation region is not considered and is set
> to zero. Because of that I get lots of errors during
> boot. One of the messages is shown below.
> kernel:  exfldio-0143 [54] ex_setup_region       :
> Field [CMD_] access width (1 bytes) too large for
> region [MNVS] (length 0)
> kernel:  exfldio-0155 [54] ex_setup_region       :
> Field [CMD_] Base+Offset+Width FC0+0+1 is beyond end
> of region [MNVS] (length 0)

I guess you forced the compilation of the DSDT, right?

> 
> The original dsdt is at
> http://cern.ch/paulo/dsdt.dsl.orig
> 

You may try this patch which should allow you to recompile without
errors:

--- dsdt.dsl.old	2004-10-12 15:58:19.000000000 +0200
+++ dsdt.dsl	2004-11-12 16:28:15.000000000 +0100
@@ -190,7 +190,7 @@
     }
 
     OperationRegion (PORT, SystemIO, 0x80, 0x01)
-    Field (PORT, WordAcc, NoLock, Preserve)
+    Field (PORT, ByteAcc, NoLock, Preserve)
     {
         P80H,   8
     }
@@ -991,7 +991,7 @@
                 {
                     Name (_ADR, 0x00)
                     OperationRegion (EVGR, PCI_Config, 0x00, 0x02)
-                    Field (EVGR, DWordAcc, NoLock, Preserve)
+                    Field (EVGR, WordAcc, NoLock, Preserve)
                     {
                         EVID,   16
                     }
@@ -3272,7 +3272,7 @@
                             Store (Arg1, SMAD)
                             Store (Arg0, SMPR)
                             Store (0xC8, Local2)
-                            While (Local1)
+                            While (Local2)
                             {
                                 Sleep (0x05)
                                 Store (SMPR, Local1)
@@ -4941,6 +4941,7 @@
         {
             If (LEqual (Arg0, 0x03)) {}
         }
+        Return(Package(){0,0})
     }
 }
 


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
