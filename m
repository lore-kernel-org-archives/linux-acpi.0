From: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Subject: Re: GPE number associated with method _L11 is not valid
Date: Mon, 10 Mar 2003 21:29:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15980.62911.417585.825987@hotzenplotz.chateau-neukoelln.de>
References: <15980.23592.270691.101902@hotzenplotz.chateau-neukoelln.de>
	<20030310.190629.112620055.kochi@hpc.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030310.190629.112620055.kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

> I already reported the same problem.
> Please see
> http://sourceforge.net/mailarchive/message.php?msg_id=4057783
> 
> If this doesn't fix your problem, please report.

The lid switch is in fact detected again after applying your
patch. But at least parts of the error messages during ACPI
initialization remain. But maybe this is in fact caused by problems in
the DSDT.

ACPI Namespace successfully loaded at root c02e46bc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000001028
evgpeblk-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L11 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L13 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L14 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L15 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L17 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L18 is not valid
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
evgpeblk-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000102C
evgpeblk-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
evgpeblk-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid

Seems that most of the methods from GPE16 to GPE31 are correctly
detected now.

I can't decide, whether this is the right behaviour.

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
