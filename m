From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Wed, 3 Mar 2004 11:35:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040303103528.GG2869@poupinou.org>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40449D8E.4060402-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2004 at 03:43:26PM +0100, Luca Capello wrote:
> Hash: SHA1
> 
> Hello,
> 

Thanks.  Sound like that I send only an half patch, sorry.


--- linux-2.6-bk/include/acpi/processor.h	2004/03/03 10:17:39	1.1
+++ linux-2.6-bk/include/acpi/processor.h	2004/03/03 10:31:20
@@ -15,6 +15,16 @@
 
 /* Power Management */
 
+struct acpi_power_register {
+	u8			descriptor;
+	u16			length;
+	u8			space_id;
+	u8			bit_width;
+	u8			bit_offset;
+	u8			reserved;
+	u64			address;
+} __attribute__ ((packed));
+
 struct acpi_processor_cx_policy {
 	u32			count;
 	int			state;
@@ -32,6 +42,7 @@ struct acpi_processor_cx {
 	u32			latency;
 	u32			latency_ticks;
 	u32			power;
+	u32			type;
 	u32			usage;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
@@ -40,6 +51,7 @@ struct acpi_processor_cx {
 struct acpi_processor_power {
 	int			state;
 	int			default_state;
+	int			count;
 	u32			bm_activity;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
