From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Fri, 13 Sep 2013 13:07:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31431 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3IMNHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Sep 2013 09:07:45 -0400
In-Reply-To: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

NOT_IMPLEMENTED refers to the software only; therefore AE_SUPPORT should be returned.

Otherwise, seems like this may be a good idea.


> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Friday, September 13, 2013 3:06 AM
> To: Rafael J. Wysocki; Len Brown
> Cc: Zheng, Lv; Moore, Robert; linux-acpi@vger.kernel.org;
> patches@linaro.org; linaro-kernel@lists.linaro.org; linaro-
> acpi@lists.linaro.org; Hanjun Guo
> Subject: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
> accessing PM registers
> 
> On hardware reduced platforms, there is no support for the following:
>  - PM Event and Control registers
>  - SCI interrupt (and handler)
>  - Fixed Events
>  - General Purpose Events (GPEs)
>  - Global Lock
>  - ACPI PM timer
>  - FACS table (Waking vectors and Global Lock)
> 
> acpi_gbl_reduced_hardware is a global flag and can be used to prevent
> misbehavior on hardware reduced platforms, and this flag is initialized at
> the very beginning of the system boot when FADT is parsed, this flag is
> set to 1 when the FACP Hardware Reduced flag is set, so we can use it to
> prevent accessing registers which do not exist on reduced hardware
> platform.
> 
> but when FACP Hardware Reduced flag is set, ACPI drivers will still access
> some registers directly which do not exist on reduced hardware platform
> and cause boot failure:
> 
> [    9.024370] Unable to handle kernel paging request at virtual address
> ffffffbffbe00001
> [    9.024423] pgd = ffffffc00007d000
> [    9.024468] [ffffffbffbe00001] *pgd=000000008007f003,
> *pmd=0000000000000000
> [    9.024538] Internal error: Oops: 96000006 [#1] SMP
> [    9.024577] Modules linked in:
> [    9.024627] CPU: 0    Not tainted  (3.9.0+ #3)
> [    9.024691] PC is at acpi_os_read_port+0x58/0xc8
> [    9.024753] LR is at acpi_hw_read_port+0x4c/0xc4
> [    9.024810] pc : [<ffffffc0002810cc>] lr : [<ffffffc0002a4fc4>] pstate:
> 600003c5
> ....
> [    9.031956] Call trace:
> [    9.032021] [<ffffffc0002810cc>] acpi_os_read_port+0x58/0xc8
> [    9.032094] [<ffffffc0002a4fc4>] acpi_hw_read_port+0x4c/0xc4
> [    9.032165] [<ffffffc0002a4198>] acpi_hw_read+0x6c/0x100
> [    9.032237] [<ffffffc0002a4250>] acpi_hw_read_multiple+0x24/0x70
> [    9.032312] [<ffffffc0002a457c>] acpi_hw_register_read+0xa8/0x164
> [    9.032386] [<ffffffc0002a52dc>] acpi_write_bit_register+0x9c/0x194
> [    9.032472] [<ffffffc0002bffb4>]
> acpi_processor_get_power_info+0x6c4/0x748
> [    9.032550] [<ffffffc000565220>] acpi_processor_power_init+0xac/0x138
> [    9.032630] [<ffffffc0003f3c00>] acpi_processor_start+0x48/0x138
> [    9.032704] [<ffffffc000565118>] acpi_processor_add+0x43c/0x498
> [    9.032784] [<ffffffc000283a74>] acpi_device_probe+0x3c/0x198
> [    9.032862] [<ffffffc0002ef0fc>] driver_probe_device+0x90/0x348
> [    9.032940] [<ffffffc0002ef450>] __driver_attach+0x9c/0xa0
> [    9.033015] [<ffffffc0002ed40c>] bus_for_each_dev+0x4c/0x8c
> [    9.033090] [<ffffffc0002eeb98>] driver_attach+0x20/0x28
> [    9.033166] [<ffffffc0002ee6e0>] bus_add_driver+0xfc/0x254
> [    9.033244] [<ffffffc0002ef8b0>] driver_register+0x6c/0x184
> [    9.033325] [<ffffffc000284894>] acpi_bus_register_driver+0x34/0x44
> [    9.033400] [<ffffffc000559c60>] acpi_processor_init+0x28/0x40
> [    9.033469] [<ffffffc000081438>] do_one_initcall+0x100/0x138
> [    9.033544] [<ffffffc0005448c8>] kernel_init_freeable+0x128/0x1cc
> [    9.033620] [<ffffffc0003f2f90>] kernel_init+0x10/0xcc
> [    9.033700] Code: d2bf7c02 f2dff7e2 f2ffffe2 8b020000 (79400000)
> [    9.033843] ---[ end trace 64376967e6bc20a9 ]---
> [    9.033995] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 
> So acpi_gbl_reduced_hardware should be used to check if reduced hardware
> or not, if it is reduced hardware, just return with some error and do not
> access the no-existent registers.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/acpica/hwregs.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 8d2e866..4c270c3 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -265,6 +265,11 @@ acpi_status acpi_hw_clear_acpi_status(void)
> 
>  	ACPI_FUNCTION_TRACE(hw_clear_acpi_status);
> 
> +	/* If Hardware Reduced flag is set, there are no GPEs */
> +	if (acpi_gbl_reduced_hardware) {
> +		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
> +	}
> +
>  	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %8.8X%8.8X\n",
>  			  ACPI_BITMASK_ALL_FIXED_STATUS,
>  			  ACPI_FORMAT_UINT64(acpi_gbl_xpm1a_status.address)));
> @@ -305,6 +310,10 @@ struct acpi_bit_register_info
> *acpi_hw_get_bit_register_info(u32 register_id)  {
>  	ACPI_FUNCTION_ENTRY();
> 
> +	if (acpi_gbl_reduced_hardware) {
> +		return (NULL);
> +	}
> +
>  	if (register_id > ACPI_BITREG_MAX) {
>  		ACPI_ERROR((AE_INFO, "Invalid BitRegister ID: 0x%X",
>  			    register_id));
> @@ -337,6 +346,11 @@ acpi_status acpi_hw_write_pm1_control(u32
> pm1a_control, u32 pm1b_control)
> 
>  	ACPI_FUNCTION_TRACE(hw_write_pm1_control);
> 
> +	/* If Hardware Reduced flag is set, there are no PM Control
> registers */
> +	if (acpi_gbl_reduced_hardware) {
> +		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
> +	}
> +
>  	status =
>  	    acpi_hw_write(pm1a_control, &acpi_gbl_FADT.xpm1a_control_block);
>  	if (ACPI_FAILURE(status)) {
> @@ -370,6 +384,11 @@ acpi_status acpi_hw_register_read(u32 register_id,
> u32 *return_value)
> 
>  	ACPI_FUNCTION_TRACE(hw_register_read);
> 
> +	/* If Hardware Reduced flag is set, there are no PM Control
> registers */
> +	if (acpi_gbl_reduced_hardware) {
> +		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
> +	}
> +
>  	switch (register_id) {
>  	case ACPI_REGISTER_PM1_STATUS:	/* PM1 A/B: 16-bit access each
> */
> 
> @@ -465,6 +484,11 @@ acpi_status acpi_hw_register_write(u32 register_id,
> u32 value)
> 
>  	ACPI_FUNCTION_TRACE(hw_register_write);
> 
> +	/* If Hardware Reduced flag is set, there are no PM Control
> registers */
> +	if (acpi_gbl_reduced_hardware) {
> +		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
> +	}
> +
>  	switch (register_id) {
>  	case ACPI_REGISTER_PM1_STATUS:	/* PM1 A/B: 16-bit access each
> */
>  		/*
> --
> 1.7.9.5

