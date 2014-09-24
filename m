From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPICA: Update to GPIO region handler interface.
Date: Wed, 24 Sep 2014 23:22:23 +0200
Message-ID: <5707708.TigUPKXQSO@vostro.rjw.lan>
References: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59864 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753314AbaIXVCf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2014 17:02:35 -0400
In-Reply-To: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <Robert.Moore@intel.com>, Bob Moore <robert.moore@intel.com>

On Tuesday, September 23, 2014 10:35:47 AM Lv Zheng wrote:
> From: Bob Moore <Robert.Moore@intel.com>
> 
> Changes to correct several GPIO issues:
> 
> 1) The update_rule in a GPIO field definition is now ignored;
> a read-modify-write operation is never performed for GPIO fields.
> (Internally, this means that the field assembly/disassembly
> code is completely bypassed for GPIO.)
> 
> 2) The Address parameter passed to a GPIO region handler is
> now the bit offset of the field from a previous Connection()
> operator. Thus, it becomes a "Pin Number Index" into the
> Connection() resource descriptor.
> 
> 3) The bit_width parameter passed to a GPIO region handler is
> now the exact bit width of the GPIO field. Thus, it can be
> interpreted as "number of pins".
> 
> Overall, we can now say that the region handler interface
> to GPIO handlers is a raw "bit/pin" addressed interface, not
> a byte-addressed interface like the system_memory handler interface.
> 
> For Linux, this patch will need to be applied simultaneously
> with the Linux GPIO handler patch that supports it.
> 
> Signed-off-by: Bob Moore <robert.moore@intel.com>

Both patches applied, thanks!


> ---
>  drivers/acpi/acpica/aclocal.h  |    1 +
>  drivers/acpi/acpica/acobject.h |    1 +
>  drivers/acpi/acpica/dsfield.c  |    2 ++
>  drivers/acpi/acpica/evregion.c |   47 ++++++++++++++++++----------
>  drivers/acpi/acpica/exfield.c  |   67 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/acpica/exprep.c   |    2 ++
>  6 files changed, 104 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 1f9aba5..2747279 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -254,6 +254,7 @@ struct acpi_create_field_info {
>  	u32 field_bit_position;
>  	u32 field_bit_length;
>  	u16 resource_length;
> +	u16 pin_number_index;
>  	u8 field_flags;
>  	u8 attribute;
>  	u8 field_type;
> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
> index 22fb644..8abb393 100644
> --- a/drivers/acpi/acpica/acobject.h
> +++ b/drivers/acpi/acpica/acobject.h
> @@ -264,6 +264,7 @@ struct acpi_object_region_field {
>  	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_length;
>  	union acpi_operand_object *region_obj;	/* Containing op_region object */
>  	u8 *resource_buffer;	/* resource_template for serial regions/fields */
> +	u16 pin_number_index;	/* Index relative to previous Connection/Template */
>  };
>  
>  struct acpi_object_bank_field {
> diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> index 3661c8e..c576661 100644
> --- a/drivers/acpi/acpica/dsfield.c
> +++ b/drivers/acpi/acpica/dsfield.c
> @@ -360,6 +360,7 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
>  			 */
>  			info->resource_buffer = NULL;
>  			info->connection_node = NULL;
> +			info->pin_number_index = 0;
>  
>  			/*
>  			 * A Connection() is either an actual resource descriptor (buffer)
> @@ -437,6 +438,7 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
>  			}
>  
>  			info->field_bit_position += info->field_bit_length;
> +			info->pin_number_index++;	/* Index relative to previous Connection() */
>  			break;
>  
>  		default:
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
> index 9957297..8eb8575 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -142,6 +142,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	union acpi_operand_object *region_obj2;
>  	void *region_context = NULL;
>  	struct acpi_connection_info *context;
> +	acpi_physical_address address;
>  
>  	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
>  
> @@ -231,25 +232,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	/* We have everything we need, we can invoke the address space handler */
>  
>  	handler = handler_desc->address_space.handler;
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
> -			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
> -			  &region_obj->region.handler->address_space, handler,
> -			  ACPI_FORMAT_NATIVE_UINT(region_obj->region.address +
> -						  region_offset),
> -			  acpi_ut_get_region_name(region_obj->region.
> -						  space_id)));
> +	address = (region_obj->region.address + region_offset);
>  
>  	/*
>  	 * Special handling for generic_serial_bus and general_purpose_io:
>  	 * There are three extra parameters that must be passed to the
>  	 * handler via the context:
> -	 *   1) Connection buffer, a resource template from Connection() op.
> -	 *   2) Length of the above buffer.
> -	 *   3) Actual access length from the access_as() op.
> +	 *   1) Connection buffer, a resource template from Connection() op
> +	 *   2) Length of the above buffer
> +	 *   3) Actual access length from the access_as() op
> +	 *
> +	 * In addition, for general_purpose_io, the Address and bit_width fields
> +	 * are defined as follows:
> +	 *   1) Address is the pin number index of the field (bit offset from
> +	 *      the previous Connection)
> +	 *   2) bit_width is the actual bit length of the field (number of pins)
>  	 */
> -	if (((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) ||
> -	     (region_obj->region.space_id == ACPI_ADR_SPACE_GPIO)) &&
> +	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) &&
>  	    context && field_obj) {
>  
>  		/* Get the Connection (resource_template) buffer */
> @@ -258,6 +257,24 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  		context->length = field_obj->field.resource_length;
>  		context->access_length = field_obj->field.access_length;
>  	}
> +	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
> +	    context && field_obj) {
> +
> +		/* Get the Connection (resource_template) buffer */
> +
> +		context->connection = field_obj->field.resource_buffer;
> +		context->length = field_obj->field.resource_length;
> +		context->access_length = field_obj->field.access_length;
> +		address = field_obj->field.pin_number_index;
> +		bit_width = field_obj->field.bit_length;
> +	}
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
> +			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
> +			  &region_obj->region.handler->address_space, handler,
> +			  ACPI_FORMAT_NATIVE_UINT(address),
> +			  acpi_ut_get_region_name(region_obj->region.
> +						  space_id)));
>  
>  	if (!(handler_desc->address_space.handler_flags &
>  	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
> @@ -271,9 +288,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  
>  	/* Call the handler */
>  
> -	status = handler(function,
> -			 (region_obj->region.address + region_offset),
> -			 bit_width, value, context,
> +	status = handler(function, address, bit_width, value, context,
>  			 region_obj2->extra.region_context);
>  
>  	if (ACPI_FAILURE(status)) {
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index 6907ce0..b994845 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -253,6 +253,37 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
>  		buffer = &buffer_desc->integer.value;
>  	}
>  
> +	if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
> +	    (obj_desc->field.region_obj->region.space_id ==
> +	     ACPI_ADR_SPACE_GPIO)) {
> +		/*
> +		 * For GPIO (general_purpose_io), the Address will be the bit offset
> +		 * from the previous Connection() operator, making it effectively a
> +		 * pin number index. The bit_length is the length of the field, which
> +		 * is thus the number of pins.
> +		 */
> +		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
> +				  "GPIO FieldRead [FROM]:  Pin %u Bits %u\n",
> +				  obj_desc->field.pin_number_index,
> +				  obj_desc->field.bit_length));
> +
> +		/* Lock entire transaction if requested */
> +
> +		acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
> +
> +		/* Perform the write */
> +
> +		status = acpi_ex_access_region(obj_desc, 0,
> +					       (u64 *)buffer, ACPI_READ);
> +		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
> +		if (ACPI_FAILURE(status)) {
> +			acpi_ut_remove_reference(buffer_desc);
> +		} else {
> +			*ret_buffer_desc = buffer_desc;
> +		}
> +		return_ACPI_STATUS(status);
> +	}
> +
>  	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
>  			  "FieldRead [TO]:   Obj %p, Type %X, Buf %p, ByteLen %X\n",
>  			  obj_desc, obj_desc->common.type, buffer,
> @@ -413,6 +444,42 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
>  
>  		*result_desc = buffer_desc;
>  		return_ACPI_STATUS(status);
> +	} else if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
> +		   (obj_desc->field.region_obj->region.space_id ==
> +		    ACPI_ADR_SPACE_GPIO)) {
> +		/*
> +		 * For GPIO (general_purpose_io), we will bypass the entire field
> +		 * mechanism and handoff the bit address and bit width directly to
> +		 * the handler. The Address will be the bit offset
> +		 * from the previous Connection() operator, making it effectively a
> +		 * pin number index. The bit_length is the length of the field, which
> +		 * is thus the number of pins.
> +		 */
> +		if (source_desc->common.type != ACPI_TYPE_INTEGER) {
> +			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
> +		}
> +
> +		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
> +				  "GPIO FieldWrite [FROM]: (%s:%X), Val %.8X  [TO]:  Pin %u Bits %u\n",
> +				  acpi_ut_get_type_name(source_desc->common.
> +							type),
> +				  source_desc->common.type,
> +				  (u32)source_desc->integer.value,
> +				  obj_desc->field.pin_number_index,
> +				  obj_desc->field.bit_length));
> +
> +		buffer = &source_desc->integer.value;
> +
> +		/* Lock entire transaction if requested */
> +
> +		acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
> +
> +		/* Perform the write */
> +
> +		status = acpi_ex_access_region(obj_desc, 0,
> +					       (u64 *)buffer, ACPI_WRITE);
> +		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
> +		return_ACPI_STATUS(status);
>  	}
>  
>  	/* Get a pointer to the data to be written */
> diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
> index ee3f872..118e942 100644
> --- a/drivers/acpi/acpica/exprep.c
> +++ b/drivers/acpi/acpica/exprep.c
> @@ -484,6 +484,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
>  			obj_desc->field.resource_length = info->resource_length;
>  		}
>  
> +		obj_desc->field.pin_number_index = info->pin_number_index;
> +
>  		/* Allow full data read from EC address space */
>  
>  		if ((obj_desc->field.region_obj->region.space_id ==
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
