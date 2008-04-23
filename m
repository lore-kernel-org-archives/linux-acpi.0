From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Tue, 22 Apr 2008 22:57:15 -0400
Message-ID: <200804222257.16029.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <16ff5d276b6f17288051f32accdbd675242e5282.1207973801.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39260 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbYDWC5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 22:57:34 -0400
In-Reply-To: <16ff5d276b6f17288051f32accdbd675242e5282.1207973801.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Zhang Rui <rui.zhang@intel.com>

On Saturday 12 April 2008, Len Brown wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> Implemented another change to eliminate/suppress spurious or
> stray GPEs. The AcpiEvDisableGpe function will now disable GPEs
> that are neither enabled nor disabled -- meaning that the GPE is
> unknown to the system. This will prevent future interrupts from
> that GPE. (Zhang Rui) BZ 6217
> 
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/events/evgpe.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
> index 897baed..6940f5d 100644
> --- a/drivers/acpi/events/evgpe.c
> +++ b/drivers/acpi/events/evgpe.c
> @@ -250,7 +250,14 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
>  
>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
>  
> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
> +	/*
> +	 * Ignore this if the GPE is valid and not enabled.
> +	 *
> +	 * Flags is only zero if GPE is neither enabled or disabled -- it may
> +	 * be a spurious or stray GPE -- disable it in the default case below.
> +	 */
> +	if (gpe_event_info->flags &&
> +	    (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
>  		return_ACPI_STATUS(AE_OK);
>  	}
>  


When applied to 2.6.25, the patch above causes ACPI Error messages below on my T61.
Certainly this is a case of the EC getting an interrupt (GPE x02) before it has initialized.

Perhaps it breaks the call of acpi_install_gpe_handler() to acpi_ev_disable_gpe()?

-Len


 PCI: Using MMCONFIG at f0000000 - f3ffffff
 PCI: Using configuration type 1
 evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
+ACPI Error (evregion-0316): No handler for Region [ECOR] (ffff81007d35dda0) [EmbeddedControl] [20070126]
+ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler [20070126]
+ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node ffff81007d364ab0), AE_NOT_EXIST
+ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC_.EC__.HKEY.CKC4] (Node ffff81007d364f48), AE_NOT_EXIST
+ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._L02] (Node ffff81007d376420), AE_NOT_EXIST
+ACPI Exception (evgpe-0584): AE_NOT_EXIST, while evaluating GPE method [_L02] [20070126]
 evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 9 Wake, Enabled 3 Runtime GPEs in this block
 ACPI: EC: EC description table is found, configuring boot EC
-ACPI: EC: non-query interrupt received, switching to interrupt mode
-Completing Region/Field/Buffer/Package initialization:........................................................................................................................
......................................................................................................................................................................
-Initialized 29/33 Regions 138/138 Fields 64/64 Buffers 55/72 Packages (1888 nodes)
+Completing Region/Field/Buffer/Package initialization:........................................................................................................................
.......................................................................................................................................................................
+Initialized 30/33 Regions 138/138 Fields 64/64 Buffers 55/72 Packages (1888 nodes)
 Initializing Device/Processor/Thermal objects by executing _INI methods:.<5>ACPI: BIOS _OSI(Linux) query honored via DMI
+ACPI: EC: non-query interrupt received, switching to interrupt mode
 .......
 Executed 8 _INI methods requiring 2 _STA executions (examined 88 objects)
 ACPI: Interpreter enabled
