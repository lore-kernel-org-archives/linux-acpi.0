From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/15] ACPICA: Linuxize: reduce divergences for 20160422 release
Date: Wed, 04 May 2016 23:37:51 +0200
Message-ID: <3430757.oQjUZYhhVi@vostro.rjw.lan>
References: <cover.1462331120.git.lv.zheng@intel.com> <eb15d96bad1b4dd98f24fc249c8a540d0469cb7b.1462331121.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51044 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752124AbcEDVek (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2016 17:34:40 -0400
In-Reply-To: <eb15d96bad1b4dd98f24fc249c8a540d0469cb7b.1462331121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, May 04, 2016 01:48:07 PM Lv Zheng wrote:
> The patch reduces source code differences between the Linux kernel and the
> ACPICA upstream so that the linuxized ACPICA 20160422 release can be
> applied with reduced human intervention.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Like previously, this adds white space where it shouldn't.

> ---
>  drivers/acpi/acpica/aclocal.h  |    2 +-
>  drivers/acpi/acpica/acresrc.h  |    2 +-
>  drivers/acpi/acpica/actables.h |    2 +-
>  drivers/acpi/acpica/dsfield.c  |    4 ++--
>  drivers/acpi/acpica/dswstate.c |    2 +-
>  drivers/acpi/acpica/exconfig.c |    2 +-
>  drivers/acpi/acpica/exregion.c |    2 +-
>  drivers/acpi/acpica/exresop.c  |    2 +-
>  drivers/acpi/acpica/hwgpe.c    |   10 +++++-----
>  drivers/acpi/acpica/hwregs.c   |    4 ++--
>  drivers/acpi/acpica/hwxface.c  |    2 +-
>  drivers/acpi/acpica/nspredef.c |    2 +-
>  drivers/acpi/acpica/nsxfname.c |    2 +-
>  drivers/acpi/acpica/rscalc.c   |    2 +-
>  drivers/acpi/acpica/tbxface.c  |    2 +-
>  drivers/acpi/acpica/utcopy.c   |    8 ++++----
>  drivers/acpi/acpica/utlock.c   |    4 ++--
>  drivers/acpi/acpica/utmath.c   |    4 ++--
>  include/acpi/acpiosxf.h        |    2 +-
>  19 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 083b16a..379797e 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -541,7 +541,7 @@ struct acpi_gpe_device_info {
>  
>  typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
>  					 gpe_xrupt_info,
> -					 struct acpi_gpe_block_info *gpe_block,
> +					 struct acpi_gpe_block_info * gpe_block,
>  					 void *context);

No, please don't add that white space.

>  /* Information about each particular fixed event */
> diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
> index 83e9a29..baacde8 100644
> --- a/drivers/acpi/acpica/acresrc.h
> +++ b/drivers/acpi/acpica/acresrc.h
> @@ -223,7 +223,7 @@ acpi_rs_get_aei_method_data(struct acpi_namespace_node *node,
>   * rscalc
>   */
>  acpi_status
> -acpi_rs_get_list_length(u8 * aml_buffer,
> +acpi_rs_get_list_length(u8 *aml_buffer,
>  			u32 aml_buffer_length, acpi_size * size_needed);

Why do you fix one and not the other?

>  
>  acpi_status
> diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
> index 848ad3a..fa81099 100644
> --- a/drivers/acpi/acpica/actables.h
> +++ b/drivers/acpi/acpica/actables.h
> @@ -131,7 +131,7 @@ acpi_status acpi_tb_allocate_owner_id(u32 table_index);
>  
>  acpi_status acpi_tb_release_owner_id(u32 table_index);
>  
> -acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id);
> +acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id);

The added white space does not adhere to the kernel coding style.

>  /*
>   * tbutils - table manager utilities
> diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> index 6a4b603..0cd777f 100644
> --- a/drivers/acpi/acpica/dsfield.c
> +++ b/drivers/acpi/acpica/dsfield.c
> @@ -147,8 +147,8 @@ acpi_ds_create_external_region(acpi_status lookup_status,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_ds_create_buffer_field(union acpi_parse_object *op,
> -			    struct acpi_walk_state *walk_state)
> +acpi_ds_create_buffer_field(union acpi_parse_object * op,
> +			    struct acpi_walk_state * walk_state)

Same here.

>  {
>  	union acpi_parse_object *arg;
>  	struct acpi_namespace_node *node;
> diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
> index 3a26ddb..6ec8dca 100644
> --- a/drivers/acpi/acpica/dswstate.c
> +++ b/drivers/acpi/acpica/dswstate.c
> @@ -143,7 +143,7 @@ acpi_ds_result_pop(union acpi_operand_object **object,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_ds_result_push(union acpi_operand_object * object,
> +acpi_ds_result_push(union acpi_operand_object *object,
>  		    struct acpi_walk_state * walk_state)

Why do you fix one and not the other?

>  {
>  	union acpi_generic_state *state;
> diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
> index a1d177d..03d2eb0 100644
> --- a/drivers/acpi/acpica/exconfig.c
> +++ b/drivers/acpi/acpica/exconfig.c
> @@ -334,7 +334,7 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
>  acpi_status
>  acpi_ex_load_op(union acpi_operand_object *obj_desc,
>  		union acpi_operand_object *target,
> -		struct acpi_walk_state *walk_state)
> +		struct acpi_walk_state * walk_state)

More damaged white space.

>  {
>  	union acpi_operand_object *ddb_handle;
>  	struct acpi_table_header *table_header;
> diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> index 076074d..3bcea59 100644
> --- a/drivers/acpi/acpica/exregion.c
> +++ b/drivers/acpi/acpica/exregion.c
> @@ -333,7 +333,7 @@ acpi_ex_system_io_space_handler(u32 function,
>  	case ACPI_WRITE:
>  
>  		status = acpi_hw_write_port((acpi_io_address) address,
> -					    (u32) * value, bit_width);
> +					    (u32)*value, bit_width);
>  		break;
>  
>  	default:
> diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
> index cc2c26c..da6bf0e 100644
> --- a/drivers/acpi/acpica/exresop.c
> +++ b/drivers/acpi/acpica/exresop.c
> @@ -131,7 +131,7 @@ acpi_ex_check_object_type(acpi_object_type type_needed,
>  
>  acpi_status
>  acpi_ex_resolve_operands(u16 opcode,
> -			 union acpi_operand_object ** stack_ptr,
> +			 union acpi_operand_object **stack_ptr,
>  			 struct acpi_walk_state * walk_state)

Why do you fix one and not the other?

>  {
>  	union acpi_operand_object *obj_desc;
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> index 1c4f451..8cc5cc0 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -315,8 +315,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
> -			  struct acpi_gpe_block_info *gpe_block, void *context)
> +acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
> +			  struct acpi_gpe_block_info * gpe_block, void *context)

More damaged white space.

And analogously below.

I'm assuming that the rest of the series won't apply without this patch,
so I'm not going to try to apply it.

Please revise and resend.

Thanks,
Rafael


>  {
>  	u32 i;
>  	acpi_status status;
> @@ -352,8 +352,8 @@ acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
> -			struct acpi_gpe_block_info *gpe_block, void *context)
> +acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
> +			struct acpi_gpe_block_info * gpe_block, void *context)
>  {
>  	u32 i;
>  	acpi_status status;
> @@ -390,7 +390,7 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
> +acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
>  				 struct acpi_gpe_block_info * gpe_block,
>  				 void *context)
>  {
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 035fb52..65b300d 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -157,7 +157,7 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
>   *
>   ******************************************************************************/
>  
> -acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
> +acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
>  {
>  	u64 address;
>  	u64 value64;
> @@ -214,7 +214,7 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
>   *
>   ******************************************************************************/
>  
> -acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
> +acpi_status acpi_hw_write(u32 value, struct acpi_generic_address * reg)
>  {
>  	u64 address;
>  	acpi_status status;
> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
> index 7caaaf3..312769d 100644
> --- a/drivers/acpi/acpica/hwxface.c
> +++ b/drivers/acpi/acpica/hwxface.c
> @@ -212,7 +212,7 @@ ACPI_EXPORT_SYMBOL(acpi_read)
>   * DESCRIPTION: Write to either memory or IO space.
>   *
>   ******************************************************************************/
> -acpi_status acpi_write(u64 value, struct acpi_generic_address *reg)
> +acpi_status acpi_write(u64 value, struct acpi_generic_address * reg)
>  {
>  	u32 width;
>  	u64 address;
> diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
> index 6d78445..bd7ddcc 100644
> --- a/drivers/acpi/acpica/nspredef.c
> +++ b/drivers/acpi/acpica/nspredef.c
> @@ -220,7 +220,7 @@ exit:
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_ns_check_object_type(struct acpi_evaluate_info *info,
> +acpi_ns_check_object_type(struct acpi_evaluate_info * info,
>  			  union acpi_operand_object **return_object_ptr,
>  			  u32 expected_btypes, u32 package_index)
>  {
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
> index 285b820..41f97e8 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -278,7 +278,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
>  
>  acpi_status
>  acpi_get_object_info(acpi_handle handle,
> -		     struct acpi_device_info **return_buffer)
> +		     struct acpi_device_info ** return_buffer)
>  {
>  	struct acpi_namespace_node *node;
>  	struct acpi_device_info *info;
> diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
> index 2b1209d..8763ce6 100644
> --- a/drivers/acpi/acpica/rscalc.c
> +++ b/drivers/acpi/acpica/rscalc.c
> @@ -397,7 +397,7 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
>   ******************************************************************************/
>  
>  acpi_status
> -acpi_rs_get_list_length(u8 * aml_buffer,
> +acpi_rs_get_list_length(u8 *aml_buffer,
>  			u32 aml_buffer_length, acpi_size * size_needed)
>  {
>  	acpi_status status;
> diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
> index 326df65..72a239e 100644
> --- a/drivers/acpi/acpica/tbxface.c
> +++ b/drivers/acpi/acpica/tbxface.c
> @@ -328,7 +328,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
>  
>  acpi_status
>  acpi_get_table(char *signature,
> -	       u32 instance, struct acpi_table_header **out_table)
> +	       u32 instance, struct acpi_table_header ** out_table)
>  {
>  	acpi_size tbl_size;
>  
> diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
> index 98d53e5..5ba8cb8 100644
> --- a/drivers/acpi/acpica/utcopy.c
> +++ b/drivers/acpi/acpica/utcopy.c
> @@ -53,7 +53,7 @@ ACPI_MODULE_NAME("utcopy")
>  static acpi_status
>  acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
>  				union acpi_object *external_object,
> -				u8 * data_space, acpi_size * buffer_space_used);
> +				u8 *data_space, acpi_size * buffer_space_used);
>  
>  static acpi_status
>  acpi_ut_copy_ielement_to_ielement(u8 object_type,
> @@ -63,7 +63,7 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
>  
>  static acpi_status
>  acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
> -				  u8 * buffer, acpi_size * space_used);
> +				  u8 *buffer, acpi_size * space_used);
>  
>  static acpi_status
>  acpi_ut_copy_esimple_to_isimple(union acpi_object *user_obj,
> @@ -111,7 +111,7 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
>  static acpi_status
>  acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
>  				union acpi_object *external_object,
> -				u8 * data_space, acpi_size * buffer_space_used)
> +				u8 *data_space, acpi_size * buffer_space_used)
>  {
>  	acpi_status status = AE_OK;
>  
> @@ -331,7 +331,7 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
>  
>  static acpi_status
>  acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
> -				  u8 * buffer, acpi_size * space_used)
> +				  u8 *buffer, acpi_size * space_used)
>  {
>  	union acpi_object *external_object;
>  	acpi_status status;
> diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
> index 3cd0978..9cc64b6 100644
> --- a/drivers/acpi/acpica/utlock.c
> +++ b/drivers/acpi/acpica/utlock.c
> @@ -124,7 +124,7 @@ acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock)
>  	return (status);
>  }
>  
> -acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
> +acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock * lock)
>  {
>  	acpi_status status;
>  
> @@ -160,7 +160,7 @@ acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
>   *
>   ******************************************************************************/
>  
> -acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock *lock)
> +acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock * lock)
>  {
>  	acpi_status status;
>  
> diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
> index 6673720..2fbc682 100644
> --- a/drivers/acpi/acpica/utmath.c
> +++ b/drivers/acpi/acpica/utmath.c
> @@ -236,8 +236,8 @@ acpi_ut_divide(u64 in_dividend,
>  			}
>  
>  			remainder.full = remainder.full - dividend.full;
> -			remainder.part.hi = (u32) - ((s32) remainder.part.hi);
> -			remainder.part.lo = (u32) - ((s32) remainder.part.lo);
> +			remainder.part.hi = (u32)-((s32) remainder.part.hi);
> +			remainder.part.lo = (u32)-((s32) remainder.part.lo);
>  
>  			if (remainder.part.lo) {
>  				remainder.part.hi--;
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 6026308..dfdcf5a 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -96,7 +96,7 @@ acpi_physical_address acpi_os_get_root_pointer(void);
>  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
>  acpi_status
>  acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
> -			    acpi_string *new_val);
> +			    acpi_string * new_val);
>  #endif
>  
>  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
> 

