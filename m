From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Mon, 17 Mar 2003 19:43:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317184333.GL8319@poup.poupinou.org>
References: <3E75C4A6.6000507@tin.it> <20030317134809.GF8319@poup.poupinou.org> <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E7611EB.2050805-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2003 at 07:20:27PM +0100, Marci wrote:
> For ASL I  think you mean the Source of the disassembled code, so, I 
> attach this to you
> 
> Thanks very much again
> 
> Marcello


Attached then is a quick fix for the size issue, and for the _WAK method.

I will look for the STM one.  Actually, this method is called by two
reserved methods by ACPI (_STM) and is used for setting IDE interface.

Since linux do not support this method, I guess it is not so vital to
correct it (but I will take a look more).

Basically, all the size issue looked like this (I take the first one) :

OperationRegion (U1D3, PCI_Config, 0x49, 0x01)
Field (U1D3, WordAcc, NoLock, Preserve)
{
	UR49, 3
}

The OperationRegion () say:

'This is an operational region for this device.  It in the
PCI Configuration space, begin to register 0x49, and the size
is exactly one byte'

The Field (...) stuff say:

Here are all the register(s) I know about, and how to access them.
You have to access them as Word (*ouch*, actually the size _is_ one
byte, not two!), and the only register known is named UR49, and the
bit relevant for this one is '3'.

Well, trouble then, since we want to access a register which is word
sized, but the operational region 'contain' only one byte...

Then the only things that we have to fix is to increase the size:

OperationRegion (U1D3, PCI_Config, 0x49, 0x02)

so that when we refer now to UR49, we now that we want
to read/write (etc) to bit 3 of the 49th register for this pci
configuration space.

I also corrected the _WAK method as a 'bonus'.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-sizes_and_wak.diff"

--- dsdt.dsl	2003/03/17 13:41:43	1.1
+++ dsdt.dsl	2003/03/17 13:50:08
@@ -860,13 +860,13 @@
             Device (USB1)
             {
                 Name (_ADR, 0x00100000)
-                OperationRegion (U1D3, PCI_Config, 0x49, 0x01)
+                OperationRegion (U1D3, PCI_Config, 0x49, 0x02)
                 Field (U1D3, WordAcc, NoLock, Preserve)
                 {
                     UR49,   3
                 }
 
-                OperationRegion (UBP1, PCI_Config, 0x84, 0x01)
+                OperationRegion (UBP1, PCI_Config, 0x84, 0x02)
                 Field (UBP1, WordAcc, NoLock, Preserve)
                 {
                     U1PE,   2
@@ -901,7 +901,7 @@
             Device (USB2)
             {
                 Name (_ADR, 0x00100001)
-                OperationRegion (UBP2, PCI_Config, 0x84, 0x01)
+                OperationRegion (UBP2, PCI_Config, 0x84, 0x02)
                 Field (UBP2, WordAcc, NoLock, Preserve)
                 {
                     U2PE,   2
@@ -929,7 +929,7 @@
             Device (USB3)
             {
                 Name (_ADR, 0x00100002)
-                OperationRegion (UBP3, PCI_Config, 0x84, 0x01)
+                OperationRegion (UBP3, PCI_Config, 0x84, 0x02)
                 Field (UBP3, WordAcc, NoLock, Preserve)
                 {
                     U3PE,   2
@@ -957,7 +957,7 @@
             Device (EHCI)
             {
                 Name (_ADR, 0x00100003)
-                OperationRegion (UBP4, PCI_Config, 0x84, 0x01)
+                OperationRegion (UBP4, PCI_Config, 0x84, 0x02)
                 Field (UBP4, WordAcc, NoLock, Preserve)
                 {
                     U4PE,   2
@@ -3300,6 +3300,7 @@
             Store (0x48, SHCR)
             Store (0xFF, SHST)
         }
+	Return(Package(2) {0, 0})
     }
 
     OperationRegion (PMS0, SystemIO, 0x0800, 0x04)

--3V7upXqbjpZ4EhLz--


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
