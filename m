From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH][RFC] Add C3 support to P4-M / ICH-M chipsets
Date: Tue, 18 May 2004 23:14:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040518211431.GA17545@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
The following patch adds C3 (Deep Sleep) support to a Pentium 4-M / ICH-M
combinations by overriding the FADT's idea of PM2_CNT and ARB_DIS.
Note: the patch as it is is meant for initial testing only. Using it for
anything serious is asking for troubles (possibly fs corruption if
something goes wrong). You have been warned.

Rationale: There seems to be a number of OEMs who forget to supply the
proper PM2_CNT block address in the FADT, while at the same time supplying
proper P_LVL3_LAT. If we stick to the specification, this means that C3 is
supported only through WBINVD instruction. As it turns out, such an
implementation is tricky and unreliable. However, the ICH3-M docs
explicitly specify the location of the PM2_CNT block and the ARB_DIS needed
to disable bus master arbitration for C3. Moreover, speedstep-ich uses the
hardcoded ARB_DIS location to control SpeedStep transitions for all ICH-M
chipsets. Therefore, overriding the ARB_DIS location with a hardcoded value
(PMBASE + 0x20, according to the spec and speedstep-ich.c) should be quite
harmless and yield working C3.

What are the requirements?
- Intel Pentium 4-M processor
- ICH3-M southbridge (though it may work with other ICH-M chipsets)
- FADT version 1 (i.e. 32-bit, AFAIK)
- valid (i.e. < 1000) P_LVL3_LAT entry in FADT
- invalid (i.e. 0) PM2_CNT_BLK and PM2_CNT_LEN

Please use acpitbl < /proc/acpi/fadt from pmtools package to verify you
meet all the reqs.

Note: it should be fairly trivial to both override the P_LVL3_LAT value
(not that I recommend that) and to move the code so that it works for FADT
version 2.

What are the benefits?
On my system (P4-M 1.7 GHz on a i845MP+ICH3-M chipset), C3 reduces idle
power consumption by about 1.5 W (some 7% of idle power consumption) and
idle temperature by about 3-4°C, which in turn facilitates passive cooling
and allows for greater power savings. YMMV, however.

Future?
It seems that in spite of what the ACPI spec says, some ICH-M chipsets have
a 7-byte long PBLK to support DeeperSleep (C4). With ARB_DIS present, C4
implementation seems fairly trivial (assuming the patch to extend the
processor module's support beyond C3 ever gets merged). Additionally, there
are other chipset-specific features that could be implemented to improve
power savings. Now, for the tricky part:

1) Is it actually worth it? Do the power savings justify the effort? Are
   there many people who might benefit from this patch?
2) Are there any chances on merging such chipset-specific quirks?
   Obviously, not in the current form, but possibly as a separate object
   surrounded by pci_find_subsys() or anything appropriate?

Any comments are welcome.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


--- a/drivers/acpi/tables/tbconvrt.c	2004-05-18 10:53:34.000000000 +0200
+++ b/drivers/acpi/tables/tbconvrt.c	2004-05-18 10:53:10.000000000 +0200
@@ -257,6 +257,14 @@ acpi_tb_convert_fadt1 (
 	local_fadt->iapc_boot_arch = BAF_LEGACY_DEVICES;
 
 	/*
+	 * Override PM2_CNT_BLK and PM2_CNT_LEN to get proper ARB_DIS address; 
+	 * valid for ICH-M chipsets.
+	 */
+	local_fadt->V1_pm2_cnt_blk = (acpi_physical_address) 
+		(local_fadt->V1_pm1a_evt_blk + 0x20);
+	local_fadt->pm2_cnt_len = 0x1;
+
+	/*
 	 * Convert the V1.0 block addresses to V2.0 GAS structures
 	 */
 	acpi_tb_init_generic_address (&local_fadt->xpm1a_evt_blk, local_fadt->pm1_evt_len,


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
