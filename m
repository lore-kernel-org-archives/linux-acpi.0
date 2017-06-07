From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: acpica: dsutils: fix an off-by-one index
Date: Wed, 7 Jun 2017 15:14:46 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BF38C@ORSMSX110.amr.corp.intel.com>
References: <20170606215951.3429-1-kirkseraph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1146 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdFGPOs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jun 2017 11:14:48 -0400
In-Reply-To: <20170606215951.3429-1-kirkseraph@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seraphime Kirkovski <kirkseraph@gmail.com>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

I believe that the rationale for this is that at that point in the code, it is *guaranteed* that there is at least one operand; therefore the -1 would always be valid.

In the end, we just deleted that call to acpi_db_display_argument_object.

I don't know if this change has made it into Linux yet.

Bob


> -----Original Message-----
> From: Seraphime Kirkovski [mailto:kirkseraph@gmail.com]
> Sent: Tuesday, June 6, 2017 3:00 PM
> To: devel@acpica.org; linux-acpi@vger.kernel.org
> Cc: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> lenb@kernel.org; linux-kernel@vger.kernel.org; Seraphime Kirkovski
> <kirkseraph@gmail.com>
> Subject: [PATCH] acpi: acpica: dsutils: fix an off-by-one index
> 
> This was detected by UBSAN.
> Fix it by checking whether there are any arguments prior to indexing the
> array.
> 
> [    0.222775] UBSAN: Undefined behaviour in
> drivers/acpi/acpica/dsutils.c:640:16
> [    0.222778] index -1 is out of range for type
> 'acpi_operand_object*[9]'
> [    0.222781] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc4-
> dirty #32
> [    0.222782] Hardware name: Hewlett-Packard HP EliteBook 2560p/162B,
> BIOS 68SSU Ver. F.02 07/26/2011
> [    0.222783] Call Trace:
> [    0.222790]  dump_stack+0x4e/0x78
> [    0.222792]  ubsan_epilogue+0xd/0x40
> [    0.222794]  __ubsan_handle_out_of_bounds+0x68/0x80
> [    0.222795]  ? perf_trace_sys_exit+0x12d/0x170
> [    0.222797]  ? kmem_cache_alloc+0x1e6/0x2e0
> [    0.222800]  acpi_ds_create_operand+0x20b/0x2a6
> [    0.222801]  acpi_ds_eval_data_object_operands+0x58/0x16c
> [    0.222803]  acpi_ds_exec_end_op+0x424/0x582
> [    0.222805]  acpi_ps_parse_loop+0x730/0x792
> [    0.222807]  acpi_ps_parse_aml+0xac/0x2eb
> [    0.222809]  acpi_ds_execute_arguments+0x129/0x14d
> [    0.222810]  acpi_ds_get_buffer_arguments+0x62/0x65
> [    0.222812]  acpi_ns_init_one_object+0xe0/0x13b
> [    0.222814]  acpi_ns_walk_namespace+0x121/0x1ef
> [    0.222815]  ? acpi_ns_exec_module_code_list+0x1b7/0x1b7
> [    0.222817]  ? acpi_ns_exec_module_code_list+0x1b7/0x1b7
> [    0.222818]  acpi_walk_namespace+0xa0/0xd5
> [    0.222820]  acpi_ns_initialize_objects+0x37/0x5a
> [    0.222823]  acpi_initialize_objects+0x34/0x54
> [    0.222824]  ? acpi_sleep_proc_init+0x2d/0x2d
> [    0.222826]  acpi_init+0xcb/0x34d
> [    0.222828]  ? __class_create+0x54/0x80
> [    0.222830]  ? fbmem_init+0x7f/0xd4
> [    0.222831]  ? acpi_sleep_proc_init+0x2d/0x2d
> [    0.222832]  do_one_initcall+0x52/0x1d0
> [    0.222835]  kernel_init_freeable+0x314/0x3a6
> [    0.222837]  ? rest_init+0x80/0x80
> [    0.222838]  kernel_init+0xf/0x120
> [    0.222839]  ? rest_init+0x80/0x80
> [    0.222841]  ret_from_fork+0x22/0x30
> 
> Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> ---
>  drivers/acpi/acpica/dsutils.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/dsutils.c
> b/drivers/acpi/acpica/dsutils.c index 406edec20de7..b66eddd3df6e 100644
> --- a/drivers/acpi/acpica/dsutils.c
> +++ b/drivers/acpi/acpica/dsutils.c
> @@ -636,11 +636,10 @@ acpi_ds_create_operand(struct acpi_walk_state
> *walk_state,
>  			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
>  					  "Argument previously created, already
> stacked\n"));
> 
> -			acpi_db_display_argument_object(walk_state->
> -							operands[walk_state->
> -								 num_operands -
> -								 1],
> -							walk_state);
> +			if (walk_state->num_operands)
> +				acpi_db_display_argument_object(walk_state->
> +					operands[walk_state->num_operands - 1],
> +					walk_state);
> 
>  			/*
>  			 * Use value that was already previously returned
> --
> 2.11.0

