From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 09/15] ACPICA: Debugger: Major update for the
 Disassemble<method> command.
Date: Tue, 27 Nov 2012 03:58:37 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828D4CEC6@FMSMSX108.amr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <073b1736284df7e732a93f7d3b2032f331d108ff.1353491653.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52547 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156Ab2K0D6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 22:58:42 -0500
In-Reply-To: <073b1736284df7e732a93f7d3b2032f331d108ff.1353491653.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



> -----Original Message-----
> From: Zheng, Lv
> Sent: Wednesday, November 21, 2012 5:08 AM
> To: Brown, Len; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org; Moore, Robert; Zheng, Lv
> Subject: [PATCH 09/15] ACPICA: Debugger: Major update for the Disassemble<method> command.
> 
> From: Bob Moore <robert.moore@intel.com>
> 
> This command was downreved and did not properly disassemble control methods with any reasonable
> complexity. This fix brings the command up to the same level as the rest of the disassembler.  Adds
> one new file, dmdeferred.c, which is existing code that is now common with the main disassembler and
> the debugger disassembl command.
> 
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/acdisasm.h |   10 ++++--
>  drivers/acpi/acpica/acutils.h  |    7 ++--
>  drivers/acpi/acpica/rscalc.c   |    4 ++-
>  drivers/acpi/acpica/rscreate.c |    4 +--
>  drivers/acpi/acpica/rslist.c   |    7 ++--
>  drivers/acpi/acpica/utresrc.c  |   74 +++++++++++++++++++++-------------------
>  6 files changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acdisasm.h b/drivers/acpi/acpica/acdisasm.h index 4294f58..5dcedba
> 100644
> --- a/drivers/acpi/acpica/acdisasm.h
> +++ b/drivers/acpi/acpica/acdisasm.h
> @@ -490,9 +490,13 @@ u8 acpi_dm_is_string_buffer(union acpi_parse_object *op);
>  u8 acpi_dm_is_pld_buffer(union acpi_parse_object *op);
> 
>  /*
> - * dmextern
> + * dmdeferred
>   */
> +acpi_status acpi_dm_parse_deferred_ops(union acpi_parse_object *root);
> 
> +/*
> + * dmextern
> + */
>  acpi_status acpi_dm_add_to_external_file_list(char *path_list);
> 
>  void acpi_dm_clear_external_file_list(void);
> @@ -525,7 +529,9 @@ acpi_dm_resource_template(struct acpi_op_walk_info *info,
>  			  union acpi_parse_object *op,
>  			  u8 *byte_data, u32 byte_count);
> 
> -acpi_status acpi_dm_is_resource_template(union acpi_parse_object *op);
> +acpi_status
> +acpi_dm_is_resource_template(struct acpi_walk_state *walk_state,
> +			     union acpi_parse_object *op);
> 
>  void acpi_dm_bit_list(u16 mask);
> 
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h index b0f5f92..6e51d193
> 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -535,12 +535,15 @@ acpi_ut_display_init_pathname(u8 type,
>   * utresrc
>   */
>  acpi_status
> -acpi_ut_walk_aml_resources(u8 *aml,
> +acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
> +			   u8 *aml,
>  			   acpi_size aml_length,
>  			   acpi_walk_aml_callback user_function,
>  			   void **context);
> 
> -acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index);
> +acpi_status
> +acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
> +			  void *aml, u8 *return_index);
> 
>  u32 acpi_ut_get_descriptor_length(void *aml);
> 
> diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c index 4f39bd6..da178b4 100644
> --- a/drivers/acpi/acpica/rscalc.c
> +++ b/drivers/acpi/acpica/rscalc.c
> @@ -407,7 +407,9 @@ acpi_rs_get_list_length(u8 * aml_buffer,
> 
>  		/* Validate the Resource Type and Resource Length */
> 
> -		status = acpi_ut_validate_resource(aml_buffer, &resource_index);
> +		status =
> +		    acpi_ut_validate_resource(NULL, aml_buffer,
> +					      &resource_index);
>  		if (ACPI_FAILURE(status)) {
>  			/*
>  			 * Exit on failure. Cannot continue because the descriptor length diff --git
> a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c index 8133326..55e0908 100644
> --- a/drivers/acpi/acpica/rscreate.c
> +++ b/drivers/acpi/acpica/rscreate.c
> @@ -98,7 +98,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
> 
>  	/* Perform the AML-to-Resource conversion */
> 
> -	status = acpi_ut_walk_aml_resources(aml_buffer, aml_buffer_length,
> +	status = acpi_ut_walk_aml_resources(NULL, aml_buffer,
> +aml_buffer_length,
>  					    acpi_rs_convert_aml_to_resources,
>  					    &current_resource_ptr);
>  	if (status == AE_AML_NO_RESOURCE_END_TAG) { @@ -174,7 +174,7 @@
> acpi_rs_create_resource_list(union acpi_operand_object *aml_buffer,
>  	/* Do the conversion */
> 
>  	resource = output_buffer->pointer;
> -	status = acpi_ut_walk_aml_resources(aml_start, aml_buffer_length,
> +	status = acpi_ut_walk_aml_resources(NULL, aml_start,
> +aml_buffer_length,

This syntax change makes things worse instead of better.
Please find out how it happened and prevent it from happening again.

thanks,
-Len

