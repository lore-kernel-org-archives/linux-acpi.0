From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: ACPI mode change...
Date: Wed, 24 Jul 2002 19:23:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724184159.281C.T-KOUCHI@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, alex_williamson-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I checked 20020709 ACPI driver patch and David's ia64 patch and
noticed that most of changes from HP ZX1 team are already integrated
into 20020709 version.  Great!

But I also noticed that these pieces in hwacpi.c can be integrated too.

1. SMI_CMD == 0 case

ACPI 2.0 spec clarified:
 * if SMI_CMD in FADT is 0, the system don't support system management mode
 * if ACPI_ENABLE or ACPI_DISABLE in FADT is 0, the system don't support
   legacy mode

So if SMI_CMD is 0, trying to write port 0 may be a source of trouble
for many legacy-free or ia64 systems and should NEVER be permitted to do.
I don't believe there were systems that SMI_CMD port is really 0 even
before ACPI 2.0 spec so we can safely check the case.


2. ACPI_ENABLE or ACPI_DISABLE == 0 case

For the case of ACPI_ENABLE and ACPI_DISABLE, however, there might have been
some systems that one of them is really 0.  So according to ACPI 2.0 spec,
(!FADT->acpi_enable || !FADT->acpi_disable) is correct way to test
whether LEGACY mode exists but considering compatibility,
(!FADT->acpi_enable && !FADT->acpi_disable) is pretty reasonable.


3. mode == acpi_hw_get_mode() case

On typical platform, writing to SMI_CMD port involves SMI processing
and we should avoid it unless necessary.  In that sense, this checking
seems reasonable.


Andy, could you consider taking these pieces into future releases?


diff -Nura linux-0709/drivers/acpi/hardware/hwacpi.c linux-ia64-0622+0709/drivers/acpi/hardware/hwacpi.c
--- linux-0709/drivers/acpi/hardware/hwacpi.c	Tue Jul  9 20:02:07 2002
+++ linux-ia64-0622+0709/drivers/acpi/hardware/hwacpi.c	Tue Jul  9 20:54:52 2002
@@ -96,6 +96,14 @@
 
 	ACPI_FUNCTION_TRACE ("Hw_set_mode");
 
+
+	if (mode == acpi_hw_get_mode())
+		return_ACPI_STATUS (AE_OK);
+
+	/* If no SMI_CMD, system does not support SMI */
+	if (!acpi_gbl_FADT->smi_cmd)
+		return_ACPI_STATUS (AE_NO_HARDWARE_RESPONSE);
+
 	switch (mode) {
 	case ACPI_SYS_MODE_ACPI:
 
@@ -108,6 +116,10 @@
 
 	case ACPI_SYS_MODE_LEGACY:
 
+		/* If both enable/disable are zero, legacy mode is not supported */
+		if (!acpi_gbl_FADT->acpi_enable && !acpi_gbl_FADT->acpi_disable)
+			return_ACPI_STATUS (AE_NO_HARDWARE_RESPONSE);
+
 		/*
 		 * BIOS should clear all fixed status bits and restore fixed event
 		 * enable bits to default

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
