From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Various ACPI-Problems on Tecra S1
Date: Tue, 25 Nov 2003 15:38:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031125143836.GG7374@poupinou.org>
References: <E1ANcqB-0001cs-00@sc8-sf-list2.sourceforge.net> <20031122190338.GB19398@fqdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031122190338.GB19398-+hGXy1KyAyQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Holzt <kju-+hGXy1KyAyQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 22, 2003 at 08:03:38PM +0100, Michael Holzt wrote:
> I own a Toshiba Tecra S1 Notebook. This notebook seems to have a.) a broken
> DSDT table (seems not so uncommon) and b.) some other problem with ACPI.
> Maybe somebody can help me figure this out.
> 
> My decompiled DSDT Table is available at http://www.kju.de/data/dsdt.dsl.
> Intels Compiler iasl complains about some errors in the table:
> 
> a.) (three different times)
> 
>     dsdt.dsl   708:    Notify (\_TZ, 0x80)
>     Error    1035 -    Invalid type ^  ([Resource] found, Notify operator 
>                        requires [Device|Processor|Thermal])

For that one, you may try with 
Notify(\_TZ.THZN, 0x80) 
instead.

> 
> b.) (five different times)
> 
>     dsdt.dsl  3742:    /*** Missing EndDependentFunctions descriptor */ })
>     Error    1071 -    Missing EndDependentFn() macro in dependent 
>                        resource list                                    ^
> 
> But i guess this errors are not related to by main problem, which is that i
> get not battery status. Kernel states when loading:
> 
> evregion-0249 [22] ev_address_space_dispa: no handler for region(c12f46c8) 
>               [EmbeddedControl]
>  exfldio-0282 [21] ex_access_region      : Region EmbeddedControl(3) has no 
>               handler
>  dswexec-0422 [14] ds_exec_end_op        : [Store]: Could not resolve 
>               operands, AE_NOT_EXIST
>  psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node 
>               c12fc9e8), AE_NOT_EXIST
> 
> (Same Error repeats with same hexnumbers for \_SB_.BAT1._STA].
> 
> I get two similar problems for the Docking Interface, but having the battery
> fixed has more priority. I already googled (web+news) for problems like this
> and searched mailing lists, but i found only other people with likewise
> error messages but no information about causing reasons and how to fix
> problems like this.
> 
> I can supply more information if asked for and/or run test programs. Any
> help appreciated. 


Could you try something like that?
Also, does the faking ecdt stuff help for batteries?


--- dsdt.dsl	2003/11/25 14:31:17	1.1
+++ dsdt.dsl	2003/11/25 14:35:12
@@ -705,7 +705,7 @@
                         Sleep (0x64)
                         Store (PASL, PTMP)
                         Store (0x01, TRON)
-                        Notify (\_TZ, 0x80)
+                        Notify (\_TZ.THZN, 0x80)
                     }
                 }
             }
@@ -720,7 +720,7 @@
                         Sleep (0x64)
                         Store (PASH, PTMP)
                         Store (0x00, TRON)
-                        Notify (\_TZ, 0x80)
+                        Notify (\_TZ.THZN, 0x80)
                     }
                 }
             }
@@ -3557,7 +3557,7 @@
                         Store (APMD, CLMT)
                         CHGT (CLMT)
                         STEV (\_SB.PCI0.LPCB.EC0.CCPT)
-                        Notify (\_TZ, 0x80)
+                        Notify (\_TZ.THZN, 0x80)
                     }
 
                     Method (_Q41, 0, NotSerialized)
@@ -3739,7 +3739,7 @@
                                 IO (Decode16, 0x07BC, 0x07BC, 0x00, 0x04)
                                 DMA (Compatibility, NotBusMaster, Transfer8) {3}
                             }
-                            /*** Missing EndDependentFunctions descriptor */                        })
+                            EndDependentFn()})
                         Method (_PRS, 0, NotSerialized)
                         {
                             Return (EPRS)
@@ -3805,7 +3805,7 @@
                                 IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x04)
                                 IRQNoFlags () {7}
                             }
-                            /*** Missing EndDependentFunctions descriptor */                        })
+                            EndDependentFn()})
                         Name (PPRS, ResourceTemplate ()
                         {
                             StartDependentFnNoPri ()
@@ -3818,7 +3818,7 @@
                                 IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                                 IRQNoFlags () {5}
                             }
-                            /*** Missing EndDependentFunctions descriptor */                        })
+                            EndDependentFn()})
                         Method (_PRS, 0, NotSerialized)
                         {
                             If (LEqual (PTYP, 0x02))
@@ -4126,7 +4126,7 @@
                                 DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                 IO (Decode16, 0x0130, 0x0130, 0x00, 0x08)
                             }
-                            /*** Missing EndDependentFunctions descriptor */                        })
+                            EndDependentFn()})
                         Method (_SRS, 1, NotSerialized)
                         {
                             Store (0x01, Local0)
@@ -4193,7 +4193,7 @@
                             IO (Decode16, 0x02E8, 0x02E8, 0x00, 0x08)
                             IRQNoFlags () {7}
                         }
-                        /*** Missing EndDependentFunctions descriptor */                    })
+                        EndDependentFn()})
                     Method (USTA, 1, NotSerialized)
                     {
                         UNLK ()


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
