From: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Subject: GPE number associated with method _L11 is not valid
Date: Mon, 10 Mar 2003 10:34:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15980.23592.270691.101902@hotzenplotz.chateau-neukoelln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

when using 2.4.21-pre4 and ACPI patch 20030228 I get the error mentioned
in the subject. This does not happen with 2.4.20 and 20021212. This is
on a Compaq Evo N800c with a modified DSDT.

Also the lid switch doesn't work then because this function seems to
be routed through one of these GPE methods.

Is this a known problem?

Exact log follows:

ACPI Namespace successfully loaded at root c02d815c
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000001028
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L11 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L13 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L14 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L15 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L17 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L18 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000102C
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L11 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L13 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L14 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L15 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L17 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L18 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
