From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [PATCH]: Correctly locate RSDP in EBDA
Date: Mon, 25 Jul 2005 15:13:13 -0700
Message-ID: <20050725151313.730257bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__25_Jul_2005_15_13_13_-0700_gI7bX=d/U_vh9d09"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__25_Jul_2005_15_13_13_-0700_gI7bX=d/U_vh9d09
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 20 Jul 2005 17:42:07 +0200
From: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
To: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH]: Correctly locate RSDP in EBDA



ACPI spec. states that the location of the RSDP structure is found by searching
* The first 1 KB of the Extended BIOS Data Area (EBDA).
* The BIOS read-only memory space between 0E0000h and 0FFFFFh

The EBDA scan looks wrong. The patch below against 2.6.12 should correct this.

-Udo.

---

Calculate correct EBDA address for ACPI RSDP scan. The word at BIOS Data Area
40:0E is the segment address of the EBDA.

Signed-off-by: Udo A. Steinberg <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>

--- linux-2.6.12/arch/i386/kernel/acpi/boot.c.old       2005-07-20 17:28:32.000000000 +0200
+++ linux-2.6.12/arch/i386/kernel/acpi/boot.c   2005-07-20 17:31:15.000000000 +0200
@@ -648,7 +648,7 @@
         * Scan memory looking for the RSDP signature. First search EBDA (low
         * memory) paragraphs and then search upper memory (E0000-FFFFF).
         */
-       rsdp_phys = acpi_scan_rsdp (0, 0x400);
+       rsdp_phys = acpi_scan_rsdp (*(u16*) 0x40E << 4, 0x400);
        if (!rsdp_phys)
                rsdp_phys = acpi_scan_rsdp (0xE0000, 0x20000);
 


--Multipart=_Mon__25_Jul_2005_15_13_13_-0700_gI7bX=d/U_vh9d09
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi43IChHTlUv
TGludXgpCgppRDhEQlFGQzNuRFFuaFJ6WFNNN25Ta1JBbXl2QUo5M2Vnc0s5NmNKZ08zcTNvcmVW
NFp2ZW5GcDV3Q2ZSWmVLCnNzdGRWWHZWa0QvSXU4VTZFaTBPd09NPQo9TUFSSwotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--Multipart=_Mon__25_Jul_2005_15_13_13_-0700_gI7bX=d/U_vh9d09--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
