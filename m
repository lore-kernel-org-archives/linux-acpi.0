From: Miroslav Ruda <ruda-8qz54MUs51PtwjQa/ONI9g@public.gmane.org>
Subject: Asus M2000E support
Date: Tue, 15 Oct 2002 13:48:41 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210151148.g9FBmfKQ028006@erebor.ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello All,

 I'm testing Asus M2000E laptop 
 (http://www.asus.com.tw/notebook/m2000/overview.htm, but with SiS 650 chipset
 http://www.sis.com/products/chipsets/integrated/pentium4/650.htm). I already 
 have working net, audio and video, the only missing part is APM/ACPI support.

 I'm using kernel 2.4.20pre8 + aa_patches (I'm using XFS filesystem) + 
 sis patches from http://www.winischhofer.net/linuxsis630.shtml. I also
 compiled in your ACPI patch.

 It seems to me that kenel recognise my laptop correctly:

   ACPI: have wakeup address 0xc0001000
   On node 0 totalpages: 90106
   zone(0): 4096 pages.
   zone(1): 86010 pages.
   zone(2): 0 pages.
   ACPI: RSDP (v000 ASUS                       ) @ 0x000f6370
   ACPI: RSDT (v001 ASUS   M2000E   16944.11825) @ 0x15ffa000
   ACPI: FADT (v001 ASUS   M2000E   16944.11825) @ 0x15ffa080
   ACPI: BOOT (v001 ASUS   M2000E   16944.11825) @ 0x15ffa040
   ACPI: DSDT (v001   ASUS M2000E   00000.04096) @ 0x00000000
   ACPI: BIOS passes blacklist
   ...
   ACPI: AC Adapter [AC] (on-line)
   ACPI: Battery Slot [BAT0] (battery present)
   ACPI: Power Button (FF) [PWRF]
   ACPI: Lid Switch [LID]
   ACPI: Sleep Button (CM) [SLPB]
   ACPI: Fan [FAN0] (on)
   ACPI: Processor [CPU] (supports C1 C2, 2 performance states, 4 
         throttling states)
   ACPI: Thermal Zone [THRM] (58 C)

 and also most info in /proc/acpi directory seems reasonable (batery
 status, ac_pover status ...). However, when AC is plugged in, kernel
 logs
  
   utmisc-0608 [27] Ut_acquire_mutex      : Thread 11F7 could not acquire
     Mutex [ACPI_MTX_Execute] AE_ERROR
   exutils-0102: *** Error: Could not acquire interpreter mutex
   dswexec-0404 [18] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: 
       Could not resolv e operands, AE_ERROR
   dswstate-0252 [20] Ds_result_pop_from_bot: No result objects!
       State=c19d8028
   dsutils-0456 [20] Ds_create_operand     : Missing or null operand,
       AE_AML_NO_RETURN_VALUE
   utmisc-0655 [15] Ut_release_mutex      : Mutex [ACPI_MTX_Execute] is
       not acquired, cannot release
   exutils-0140: *** Error: Could not release interpreter mutex
   evevent-0798: *** Error: AE_AML_NO_RETURN_VALUE while evaluated GPE19
       method

 And finally, it's still unclear to me how ACPI can be used to support
 suspend to memory or disk? I tried "echo [1234] >/proc/acpi/state"
 without any response. Can someone send me info what must be installed, 
 what I missed? For example, how to define which button is Sleep button :-), 
 where I can define what must be done before suspend, how to slow down
 processor, where are some user level tools etc.?

 Thanks in advance
      
                         Mirek Ruda 
-- 

+--------------------------------------+------------------------------------+
| Miroslav Ruda, system administrator  | Institute of Computer Science      |
| Phone: +420 5 41512219               | Masaryk University                 |
| Fax:   +420 5 41212747               | Botanicka 68a                      |
| E-mail: ruda-8qz54MUs51PtwjQa/ONI9g@public.gmane.org             | 602 00 Brno                        |
| WWW: http://www.fi.muni.cz/~ruda     | Czech Republic                     |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
