From: "Adachi, Kenichi" <aileenja_jpn-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: RE: DSDT Fix, one question ...
Date: Fri, 28 Feb 2003 00:40:25 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2de76$8f16f9b0$7c4425db@sayonara>
References: <20030227125318.GI21631@freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030227125318.GI21631-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Sander Smeenk' <ssmeenk-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Theoretically or ideally speaking, OS (IDE guy) retrieves the current
setting for IDE by running _GTM, verifies/modifies the returned buffer
from ACPI BIOS, and applies it back to IDE Controller's registers by
running _STM. However, grep'ing drivers/ide for "GTM" or "STM" didn't
come back positively with linux-2.5.51. This could mean that whole chunk
annoying you is not used by Linux yet. 

> The complete DSDT is now located at:
>   http://valor.freshdot.net/~ssmeenk/

Your "TMD0" is locally created buffer to hold the setting info for IDE.
This apparently conforms to the format of _GTM Result Code (ACPI Spec
Table 10-4).

  1663              Name(TMD0, Buffer(0x14) { })
  1664              CreateDWordField(TMD0, 0x0, PIO0)
  1665              CreateDWordField(TMD0, 0x4, DMA0)
  1666              CreateDWordField(TMD0, 0x8, PIO1)
  1667              CreateDWordField(TMD0, 0xc, DMA1)
  1668              CreateDWordField(TMD0, 0x10, CHNF)

OS calls _GTM to get the current setting, _GTM then calls "GTM_", and
"GTM_" packs requested info in corresponding fields within "TMD0". Thus,
returning "TMD0" does really make sense in this *GET* context, but does
not in *SET* context very much. To me, at a glance, sub-method "STM_"
called from _STM doesn't have to return anything in the following
sequence (didn't check iASL code as to what made him give you warning):

  1709                  Method(_STM, 3) {
  1710                      Store(Arg0, Debug)
  1711                      Store(Arg0, TMD0)  // saving the passed
buffer from OS for later use?
  1712                      Store(PMPT, GMPT)
  1713                      Store(PMUE, GMUE)
  1714                      Store(PMUT, GMUT)
  1715                      Store(PMCR, GMCR)
  1716                      Store(PSPT, GSPT)
  1717                      Store(PSUE, GSUE)
  1718                      Store(PSUT, GSUT)
  1719                      Store(PSCR, GSCR)
  1720                      STM_()
     :

> This one came from an MSI KT333 Ultra ARU (MS-6580E) 
> mainboard running the latest, or maybe the second to last 
> BIOS, not sure about that. 

Incidentally, your "REGF" flag simply tells you the availability of
"CFG2" PCI_Config OpRegion (OpRegion handler is ready or not). OpRegion
"CFG2" created at offset 0x40 - 0x60 of your IDE Controller(Bus:0,
Dev:17, Func:1)'s PCI Config Space would represent something essential
for IDE setting. For more details, you have to consult your South
Bridge's Datasheet. Don't know if VIA publishes it or not...  

  1564          Device(IDE0) {
  1565              Name(_ADR, 0x00110001)
  1566              Name(REGF, 0x1)
  1567              Method(_REG, 2) {
  1568                  If(LEqual(Arg0, 0x2)) {  
  1569                      Store(Arg1, REGF)  
  1570                  }
  1571              }
      :
  1669              OperationRegion(CFG2, PCI_Config, 0x40, 0x20)


Thanks,
- Adachi, Kenichi





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
