From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Tue, 18 Mar 2003 15:13:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030318141320.GT8319@poup.poupinou.org>
References: <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it> <20030317184333.GL8319@poup.poupinou.org> <3E761BFA.9030609@tin.it> <3E762BDD.8030108@hp.com> <3E762DED.70301@tin.it> <3E763453.1080307@hp.com> <3E7648C3.9090402@tin.it> <20030318094752.GO8319@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030318094752.GO8319-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi Marcello,

The diff is at the end of this email, and can be found
at:
ftp://ftp.poupinou.org/acpi/MSI/

There is also an .hex file (namely MSI_KT4_ULTRA.hex.bz2)
The original asl is here, and the corrected asl.

You can can use with instruction found at
http://www.poupinou.org/acpi/over.html
or any other sites which have such kind of support (Richard one,
acpi.sf.net, Faye one, etc.)


Now my comment:

1- first I made a mistake.  Instead of changing the WordAcc, I
blindly increased the size of the Operational Region(s) that
where buggy.  I think that actually it is enough to change
WordAcc by ByteAcc instead.  This is done with the attached
diff.  I also said (certainly because I needed to go to sleep)
that for example those ASL statements:

OperationRegion (U1D3, PCI_Config, 0x49, 0x01)
Field (U1D3, WordAcc, NoLock, Preserve)
{
   UR49,   3
}

mean something like
we acced as a word pci register at 0x49 and bit 3 is relevant

which is wrong (sorry).  It mean actually that only the third
bits are relevants (bit 0 to 2).

Next, what did you think now if ACPI-AC blindly do not check
any more the size of the operational region (as in Windows).
Then we can not actually provide the right thing to do, that is
the Field (..) give us faulty information.


2- the STM issue (the 'last' warning) you get is now resolved.
The problem is that this method wanted to know if it can
access some PCI configuration register at the IDE PCI bridge.
This was actually done by copying (I think) another function (the
GTM one), but is actually wrong.  A way to do it clean
is actually to check in the 2 _STM functions if we can access
the PCI configuration space of the IDE bridge, then continue
if it is OK.


A last word.  I can not promise you that all will be OK, even in a
Windows system.


--- dsdt.dsl	2003/03/17 13:41:43	1.1
+++ dsdt.dsl	2003/03/18 09:03:12
@@ -861,13 +861,13 @@
             {
                 Name (_ADR, 0x00100000)
                 OperationRegion (U1D3, PCI_Config, 0x49, 0x01)
-                Field (U1D3, WordAcc, NoLock, Preserve)
+                Field (U1D3, ByteAcc, NoLock, Preserve)
                 {
                     UR49,   3
                 }
 
                 OperationRegion (UBP1, PCI_Config, 0x84, 0x01)
-                Field (UBP1, WordAcc, NoLock, Preserve)
+                Field (UBP1, ByteAcc, NoLock, Preserve)
                 {
                     U1PE,   2
                 }
@@ -902,7 +902,7 @@
             {
                 Name (_ADR, 0x00100001)
                 OperationRegion (UBP2, PCI_Config, 0x84, 0x01)
-                Field (UBP2, WordAcc, NoLock, Preserve)
+                Field (UBP2, ByteAcc, NoLock, Preserve)
                 {
                     U2PE,   2
                 }
@@ -930,7 +930,7 @@
             {
                 Name (_ADR, 0x00100002)
                 OperationRegion (UBP3, PCI_Config, 0x84, 0x01)
-                Field (UBP3, WordAcc, NoLock, Preserve)
+                Field (UBP3, ByteAcc, NoLock, Preserve)
                 {
                     U3PE,   2
                 }
@@ -958,7 +958,7 @@
             {
                 Name (_ADR, 0x00100003)
                 OperationRegion (UBP4, PCI_Config, 0x84, 0x01)
-                Field (UBP4, WordAcc, NoLock, Preserve)
+                Field (UBP4, ByteAcc, NoLock, Preserve)
                 {
                     U4PE,   2
                 }
@@ -2653,17 +2653,24 @@
                         Store (PSUE, GSUE)
                         Store (PSUT, GSUT)
                         Store (PSCR, GSCR)
-                        STM ()
-                        Store (GMPT, PMPT)
-                        Store (GMUE, PMUE)
-                        Store (GMUT, PMUT)
-                        Store (GMCR, PMCR)
-                        Store (GSPT, PSPT)
-                        Store (GSUE, PSUE)
-                        Store (GSUT, PSUT)
-                        Store (GSCR, PSCR)
-                        Store (GTF (0x00, Arg1), ATA0)
-                        Store (GTF (0x01, Arg2), ATA1)
+			If (REGF)
+			{
+			    STM()
+                            Store (GMPT, PMPT)
+                            Store (GMUE, PMUE)
+                            Store (GMUT, PMUT)
+                            Store (GMCR, PMCR)
+                            Store (GSPT, PSPT)
+                            Store (GSUE, PSUE)
+                            Store (GSUT, PSUT)
+                            Store (GSCR, PSCR)
+                            Store (GTF (0x00, Arg1), ATA0)
+                            Store (GTF (0x01, Arg2), ATA1)
+			}
+			Else
+			{
+			    Store ("Trying to access IDE HWIF registers when not allowed", Debug)
+			}
                     }
 
                     Device (DRV0)
@@ -2707,17 +2714,24 @@
                         Store (SSUE, GSUE)
                         Store (SSUT, GSUT)
                         Store (SSCR, GSCR)
-                        STM ()
-                        Store (GMPT, SMPT)
-                        Store (GMUE, SMUE)
-                        Store (GMUT, SMUT)
-                        Store (GMCR, SMCR)
-                        Store (GSPT, SSPT)
-                        Store (GSUE, SSUE)
-                        Store (GSUT, SSUT)
-                        Store (GSCR, SSCR)
-                        Store (GTF (0x00, Arg1), ATA2)
-                        Store (GTF (0x01, Arg2), ATA3)
+			If (REGF)
+			{
+			    STM()
+                            Store (GMPT, SMPT)
+                            Store (GMUE, SMUE)
+                            Store (GMUT, SMUT)
+                            Store (GMCR, SMCR)
+                            Store (GSPT, SSPT)
+                            Store (GSUE, SSUE)
+                            Store (GSUT, SSUT)
+                            Store (GSCR, SSCR)
+                            Store (GTF (0x00, Arg1), ATA2)
+                            Store (GTF (0x01, Arg2), ATA3)
+			}
+			Else
+			{
+			    Store ("Trying to access IDE HWIF registers when not allowed", Debug)
+			}
                     }
 
                     Device (DRV0)
@@ -2796,11 +2810,11 @@
 
                 Method (STM, 0, Serialized)
                 {
-                    If (REGF) {}
-                    Else
-                    {
-                        Return (TMD0)
-                    }
+                    // If (REGF) {}
+                    // Else
+                    // {
+                    //     Return (TMD0)
+                    // }
 
                     Store (0x00, GMUE)
                     Store (0x07, GMUT)
@@ -3300,6 +3314,7 @@
             Store (0x48, SHCR)
             Store (0xFF, SHST)
         }
+	Return(Package(2) {0, 0})
     }
 
     OperationRegion (PMS0, SystemIO, 0x0800, 0x04)



Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
