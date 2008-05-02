From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 04/10] acpi: adjust _acpi_{module,function}_name
	definitions
Date: Fri, 02 May 2008 16:04:35 +0200
Message-ID: <1209737075.22514.79.camel@linux-2bdv.site>
References: <200805010952.m419q3Jc031806@imap1.linux-foundation.org>
	 <1209722812.22514.28.camel@linux-2bdv.site>
	 <20080502054113.4e5839d9.akpm@linux-foundation.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42854 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364AbYEBOHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 May 2008 10:07:43 -0400
In-Reply-To: <20080502054113.4e5839d9.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, jbeulich@novell.com, "Moore, Robert" <robert.moore@intel.com>


On Fri, 2008-05-02 at 05:41 -0700, Andrew Morton wrote:
> On Fri, 02 May 2008 12:06:52 +0200 Thomas Renninger <trenn@suse.de> wrote:
> 
> > > > Andrew, IMO you can drop this and the const cleanups from -mm tree.
> > 
> > > I cannot locate a patch which matches the description "const
> > > cleanups"?
> > 
> > It's this one. It's up to Bob to merge these cleanups into acpica
> > manually (probably would make sense...), but this must go the
> > "patch/modify acpica" -> "merge into kernel" way.
> 
> ok...  But why should the patch be dropped?  afacit there's nothing
> linux-specific about it?

Yes, so that it's not forgotten it makes sense to keep it until things
find their way through acpica to the kernel.

The problem is that currently someone has to go through this by hand
because this won't patch into ACPICA code.
It would be great if someone from Len's/Bob's team could do this,
because I am sure Jan is not willing to readjust this against the ACPICA
project and he might even not be able to gain the very latest sources. 

But in future, such patches should definitely be based against ACPICA
code. Len will probably announce here where to find the very latest
sources, soon. Currently the latest official release linked to on
http://lesswatts.org is still from 2006. AFAIK things will get better
here, soon.

   Thomas
> 
>  drivers/acpi/executer/exdump.c    |    4 +-
>  drivers/acpi/namespace/nsutils.c  |   23 ++++++------
>  drivers/acpi/utilities/utdebug.c  |   30 ++++++++--------
>  drivers/acpi/utilities/utmisc.c   |   11 +++---
>  drivers/acpi/utilities/utobject.c |    4 +-
>  include/acpi/acinterp.h           |    5 +-
>  include/acpi/aclocal.h            |    4 +-
>  include/acpi/acmacros.h           |    7 +--
>  include/acpi/acnamesp.h           |   19 +++++-----
>  include/acpi/acutils.h            |   51 ++++++++++++----------------
>  10 files changed, 78 insertions(+), 80 deletions(-)
> 
> diff -puN drivers/acpi/executer/exdump.c~acpi-adjust-_acpi_modulefunction_name-definitions drivers/acpi/executer/exdump.c
> --- a/drivers/acpi/executer/exdump.c~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/drivers/acpi/executer/exdump.c
> @@ -771,9 +771,9 @@ void acpi_ex_dump_operand(union acpi_ope
>  void
>  acpi_ex_dump_operands(union acpi_operand_object **operands,
>  		      acpi_interpreter_mode interpreter_mode,
> -		      char *ident,
> +		      const char *ident,
>  		      u32 num_levels,
> -		      char *note, char *module_name, u32 line_number)
> +		      const char *note, const char *module_name, u32 line_number)
>  {
>  	acpi_native_uint i;
>  
> diff -puN drivers/acpi/namespace/nsutils.c~acpi-adjust-_acpi_modulefunction_name-definitions drivers/acpi/namespace/nsutils.c
> --- a/drivers/acpi/namespace/nsutils.c~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/drivers/acpi/namespace/nsutils.c
> @@ -73,9 +73,9 @@ acpi_name acpi_ns_find_parent_name(struc
>   ******************************************************************************/
>  
>  void
> -acpi_ns_report_error(char *module_name,
> +acpi_ns_report_error(const char *module_name,
>  		     u32 line_number,
> -		     char *internal_name, acpi_status lookup_status)
> +		     const char *internal_name, acpi_status lookup_status)
>  {
>  	acpi_status status;
>  	u32 bad_name;
> @@ -130,11 +130,11 @@ acpi_ns_report_error(char *module_name,
>   ******************************************************************************/
>  
>  void
> -acpi_ns_report_method_error(char *module_name,
> +acpi_ns_report_method_error(const char *module_name,
>  			    u32 line_number,
> -			    char *message,
> +			    const char *message,
>  			    struct acpi_namespace_node *prefix_node,
> -			    char *path, acpi_status method_status)
> +			    const char *path, acpi_status method_status)
>  {
>  	acpi_status status;
>  	struct acpi_namespace_node *node = prefix_node;
> @@ -167,7 +167,7 @@ acpi_ns_report_method_error(char *module
>   ******************************************************************************/
>  
>  void
> -acpi_ns_print_node_pathname(struct acpi_namespace_node *node, char *message)
> +acpi_ns_print_node_pathname(struct acpi_namespace_node *node, const char *message)
>  {
>  	struct acpi_buffer buffer;
>  	acpi_status status;
> @@ -296,7 +296,7 @@ u32 acpi_ns_local(acpi_object_type type)
>  
>  void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
>  {
> -	char *next_external_char;
> +	const char *next_external_char;
>  	u32 i;
>  
>  	ACPI_FUNCTION_ENTRY();
> @@ -363,7 +363,7 @@ acpi_status acpi_ns_build_internal_name(
>  {
>  	u32 num_segments = info->num_segments;
>  	char *internal_name = info->internal_name;
> -	char *external_name = info->next_external_char;
> +	const char *external_name = info->next_external_char;
>  	char *result = NULL;
>  	acpi_native_uint i;
>  
> @@ -472,7 +472,8 @@ acpi_status acpi_ns_build_internal_name(
>   *
>   *******************************************************************************/
>  
> -acpi_status acpi_ns_internalize_name(char *external_name, char **converted_name)
> +acpi_status acpi_ns_internalize_name(const char *external_name,
> +				     char **converted_name)
>  {
>  	char *internal_name;
>  	struct acpi_namestring_info info;
> @@ -528,7 +529,7 @@ acpi_status acpi_ns_internalize_name(cha
>  
>  acpi_status
>  acpi_ns_externalize_name(u32 internal_name_length,
> -			 char *internal_name,
> +			 const char *internal_name,
>  			 u32 * converted_name_length, char **converted_name)
>  {
>  	acpi_native_uint names_index = 0;
> @@ -823,7 +824,7 @@ u32 acpi_ns_opens_scope(acpi_object_type
>  
>  acpi_status
>  acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
> -		 char *pathname,
> +		 const char *pathname,
>  		 u32 flags, struct acpi_namespace_node **return_node)
>  {
>  	union acpi_generic_state scope_info;
> diff -puN drivers/acpi/utilities/utdebug.c~acpi-adjust-_acpi_modulefunction_name-definitions drivers/acpi/utilities/utdebug.c
> --- a/drivers/acpi/utilities/utdebug.c~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/drivers/acpi/utilities/utdebug.c
> @@ -156,8 +156,8 @@ static const char *acpi_ut_trim_function
>  void ACPI_INTERNAL_VAR_XFACE
>  acpi_ut_debug_print(u32 requested_debug_level,
>  		    u32 line_number,
> -		    const char *function_name,
> -		    char *module_name, u32 component_id, char *format, ...)
> +		    const char *function_name, const char *module_name,
> +		    u32 component_id, const char *format, ...)
>  {
>  	acpi_thread_id thread_id;
>  	va_list args;
> @@ -227,8 +227,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_debug_print)
>  void ACPI_INTERNAL_VAR_XFACE
>  acpi_ut_debug_print_raw(u32 requested_debug_level,
>  			u32 line_number,
> -			const char *function_name,
> -			char *module_name, u32 component_id, char *format, ...)
> +			const char *function_name, const char *module_name,
> +			u32 component_id, const char *format, ...)
>  {
>  	va_list args;
>  
> @@ -261,7 +261,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_debug_print_r
>   ******************************************************************************/
>  void
>  acpi_ut_trace(u32 line_number,
> -	      const char *function_name, char *module_name, u32 component_id)
> +	      const char *function_name, const char *module_name, u32 component_id)
>  {
>  
>  	acpi_gbl_nesting_level++;
> @@ -293,7 +293,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_trace)
>  void
>  acpi_ut_trace_ptr(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, void *pointer)
> +		  const char *module_name, u32 component_id, void *pointer)
>  {
>  	acpi_gbl_nesting_level++;
>  	acpi_ut_track_stack_ptr();
> @@ -324,7 +324,7 @@ acpi_ut_trace_ptr(u32 line_number,
>  void
>  acpi_ut_trace_str(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, char *string)
> +		  const char *module_name, u32 component_id, const char *string)
>  {
>  
>  	acpi_gbl_nesting_level++;
> @@ -356,7 +356,7 @@ acpi_ut_trace_str(u32 line_number,
>  void
>  acpi_ut_trace_u32(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, u32 integer)
> +		  const char *module_name, u32 component_id, u32 integer)
>  {
>  
>  	acpi_gbl_nesting_level++;
> @@ -385,8 +385,8 @@ acpi_ut_trace_u32(u32 line_number,
>   ******************************************************************************/
>  
>  void
> -acpi_ut_exit(u32 line_number,
> -	     const char *function_name, char *module_name, u32 component_id)
> +acpi_ut_exit(u32 line_number, const char *function_name,
> +	     const char *module_name, u32 component_id)
>  {
>  
>  	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
> @@ -416,8 +416,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_exit)
>   ******************************************************************************/
>  void
>  acpi_ut_status_exit(u32 line_number,
> -		    const char *function_name,
> -		    char *module_name, u32 component_id, acpi_status status)
> +		    const char *function_name, const char *module_name,
> +		    u32 component_id, acpi_status status)
>  {
>  
>  	if (ACPI_SUCCESS(status)) {
> @@ -457,8 +457,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
>   ******************************************************************************/
>  void
>  acpi_ut_value_exit(u32 line_number,
> -		   const char *function_name,
> -		   char *module_name, u32 component_id, acpi_integer value)
> +		   const char *function_name, const char *module_name,
> +		   u32 component_id, acpi_integer value)
>  {
>  
>  	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
> @@ -490,7 +490,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
>  void
>  acpi_ut_ptr_exit(u32 line_number,
>  		 const char *function_name,
> -		 char *module_name, u32 component_id, u8 * ptr)
> +		 const char *module_name, u32 component_id, u8 * ptr)
>  {
>  
>  	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
> diff -puN drivers/acpi/utilities/utmisc.c~acpi-adjust-_acpi_modulefunction_name-definitions drivers/acpi/utilities/utmisc.c
> --- a/drivers/acpi/utilities/utmisc.c~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/drivers/acpi/utilities/utmisc.c
> @@ -1024,7 +1024,7 @@ acpi_ut_walk_package_tree(union acpi_ope
>   ******************************************************************************/
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
> +acpi_ut_error(const char *module_name, u32 line_number, const char *format, ...)
>  {
>  	va_list args;
>  
> @@ -1037,8 +1037,8 @@ acpi_ut_error(char *module_name, u32 lin
>  }
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_exception(char *module_name,
> -		  u32 line_number, acpi_status status, char *format, ...)
> +acpi_ut_exception(const char *module_name,
> +		  u32 line_number, acpi_status status, const char *format, ...)
>  {
>  	va_list args;
>  
> @@ -1053,7 +1053,8 @@ acpi_ut_exception(char *module_name,
>  EXPORT_SYMBOL(acpi_ut_exception);
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
> +acpi_ut_warning(const char *module_name,
> +		u32 line_number, const char *format, ...)
>  {
>  	va_list args;
>  
> @@ -1067,7 +1068,7 @@ acpi_ut_warning(char *module_name, u32 l
>  }
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_info(char *module_name, u32 line_number, char *format, ...)
> +acpi_ut_info(const char *module_name, u32 line_number, const char *format, ...)
>  {
>  	va_list args;
>  
> diff -puN drivers/acpi/utilities/utobject.c~acpi-adjust-_acpi_modulefunction_name-definitions drivers/acpi/utilities/utobject.c
> --- a/drivers/acpi/utilities/utobject.c~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/drivers/acpi/utilities/utobject.c
> @@ -83,7 +83,7 @@ acpi_ut_get_element_length(u8 object_typ
>   *
>   ******************************************************************************/
>  
> -union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
> +union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char *module_name,
>  							      u32 line_number,
>  							      u32 component_id,
>  							      acpi_object_type
> @@ -347,7 +347,7 @@ u8 acpi_ut_valid_internal_object(void *o
>   *
>   ******************************************************************************/
>  
> -void *acpi_ut_allocate_object_desc_dbg(char *module_name,
> +void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
>  				       u32 line_number, u32 component_id)
>  {
>  	union acpi_operand_object *object;
> diff -puN include/acpi/acinterp.h~acpi-adjust-_acpi_modulefunction_name-definitions include/acpi/acinterp.h
> --- a/include/acpi/acinterp.h~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/include/acpi/acinterp.h
> @@ -367,9 +367,10 @@ void acpi_ex_dump_operand(union acpi_ope
>  void
>  acpi_ex_dump_operands(union acpi_operand_object **operands,
>  		      acpi_interpreter_mode interpreter_mode,
> -		      char *ident,
> +		      const char *ident,
>  		      u32 num_levels,
> -		      char *note, char *module_name, u32 line_number);
> +		      const char *note, const char *module_name,
> +		      u32 line_number);
>  
>  #ifdef	ACPI_FUTURE_USAGE
>  void
> diff -puN include/acpi/aclocal.h~acpi-adjust-_acpi_modulefunction_name-definitions include/acpi/aclocal.h
> --- a/include/acpi/aclocal.h~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/include/acpi/aclocal.h
> @@ -282,8 +282,8 @@ struct acpi_predefined_names {
>  /* Info structure used to convert external<->internal namestrings */
>  
>  struct acpi_namestring_info {
> -	char *external_name;
> -	char *next_external_char;
> +	const char *external_name;
> +	const char *next_external_char;
>  	char *internal_name;
>  	u32 length;
>  	u32 num_segments;
> diff -puN include/acpi/acmacros.h~acpi-adjust-_acpi_modulefunction_name-definitions include/acpi/acmacros.h
> --- a/include/acpi/acmacros.h~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/include/acpi/acmacros.h
> @@ -414,7 +414,7 @@ struct acpi_integer_overlay {
>   * error messages. The __FILE__ macro is not very useful for this, because it
>   * often includes the entire pathname to the module
>   */
> -#define ACPI_MODULE_NAME(name)          static char ACPI_UNUSED_VAR *_acpi_module_name = name;
> +#define ACPI_MODULE_NAME(name)          static const char ACPI_UNUSED_VAR _acpi_module_name[] = name;
>  #else
>  #define ACPI_MODULE_NAME(name)
>  #endif
> @@ -467,8 +467,7 @@ struct acpi_integer_overlay {
>  /*
>   * If ACPI_GET_FUNCTION_NAME was not defined in the compiler-dependent header,
>   * define it now. This is the case where there the compiler does not support
> - * a __FUNCTION__ macro or equivalent. We save the function name on the
> - * local stack.
> + * a __FUNCTION__ macro or equivalent.
>   */
>  #ifndef ACPI_GET_FUNCTION_NAME
>  #define ACPI_GET_FUNCTION_NAME          _acpi_function_name
> @@ -479,7 +478,7 @@ struct acpi_integer_overlay {
>   * Note: (const char) is used to be compatible with the debug interfaces
>   * and macros such as __FUNCTION__.
>   */
> -#define ACPI_FUNCTION_NAME(name)        const char *_acpi_function_name = #name;
> +#define ACPI_FUNCTION_NAME(name)        static const char _acpi_function_name[] = #name;
>  
>  #else
>  /* Compiler supports __FUNCTION__ (or equivalent) -- Ignore this macro */
> diff -puN include/acpi/acnamesp.h~acpi-adjust-_acpi_modulefunction_name-definitions include/acpi/acnamesp.h
> --- a/include/acpi/acnamesp.h~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/include/acpi/acnamesp.h
> @@ -201,7 +201,7 @@ acpi_ns_pattern_match(struct acpi_namesp
>  
>  acpi_status
>  acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
> -		 char *external_pathname,
> +		 const char *external_pathname,
>  		 u32 flags, struct acpi_namespace_node **out_node);
>  
>  acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node);
> @@ -265,28 +265,29 @@ acpi_object_type acpi_ns_get_type(struct
>  u32 acpi_ns_local(acpi_object_type type);
>  
>  void
> -acpi_ns_report_error(char *module_name,
> +acpi_ns_report_error(const char *module_name,
>  		     u32 line_number,
> -		     char *internal_name, acpi_status lookup_status);
> +		     const char *internal_name, acpi_status lookup_status);
>  
>  void
> -acpi_ns_report_method_error(char *module_name,
> +acpi_ns_report_method_error(const char *module_name,
>  			    u32 line_number,
> -			    char *message,
> +			    const char *message,
>  			    struct acpi_namespace_node *node,
> -			    char *path, acpi_status lookup_status);
> +			    const char *path, acpi_status lookup_status);
>  
> -void acpi_ns_print_node_pathname(struct acpi_namespace_node *node, char *msg);
> +void acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
> +				 const char *msg);
>  
>  acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info);
>  
>  void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info);
>  
> -acpi_status acpi_ns_internalize_name(char *dotted_name, char **converted_name);
> +acpi_status acpi_ns_internalize_name(const char *dotted_name, char **converted_name);
>  
>  acpi_status
>  acpi_ns_externalize_name(u32 internal_name_length,
> -			 char *internal_name,
> +			 const char *internal_name,
>  			 u32 * converted_name_length, char **converted_name);
>  
>  struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle);
> diff -puN include/acpi/acutils.h~acpi-adjust-_acpi_modulefunction_name-definitions include/acpi/acutils.h
> --- a/include/acpi/acutils.h~acpi-adjust-_acpi_modulefunction_name-definitions
> +++ a/include/acpi/acutils.h
> @@ -245,85 +245,80 @@ void acpi_ut_track_stack_ptr(void);
>  
>  void
>  acpi_ut_trace(u32 line_number,
> -	      const char *function_name, char *module_name, u32 component_id);
> +	      const char *function_name, const char *module_name, u32 component_id);
>  
>  void
>  acpi_ut_trace_ptr(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, void *pointer);
> +		  const char *module_name, u32 component_id, void *pointer);
>  
>  void
>  acpi_ut_trace_u32(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, u32 integer);
> +		  const char *module_name, u32 component_id, u32 integer);
>  
>  void
>  acpi_ut_trace_str(u32 line_number,
>  		  const char *function_name,
> -		  char *module_name, u32 component_id, char *string);
> +		  const char *module_name, u32 component_id, const char *string);
>  
>  void
>  acpi_ut_exit(u32 line_number,
> -	     const char *function_name, char *module_name, u32 component_id);
> +	     const char *function_name, const char *module_name, u32 component_id);
>  
>  void
>  acpi_ut_status_exit(u32 line_number,
>  		    const char *function_name,
> -		    char *module_name, u32 component_id, acpi_status status);
> +		    const char *module_name, u32 component_id, acpi_status status);
>  
>  void
>  acpi_ut_value_exit(u32 line_number,
>  		   const char *function_name,
> -		   char *module_name, u32 component_id, acpi_integer value);
> +		   const char *module_name, u32 component_id, acpi_integer value);
>  
>  void
>  acpi_ut_ptr_exit(u32 line_number,
>  		 const char *function_name,
> -		 char *module_name, u32 component_id, u8 * ptr);
> +		 const char *module_name, u32 component_id, u8 * ptr);
>  
>  void acpi_ut_dump_buffer(u8 * buffer, u32 count, u32 display, u32 component_id);
>  
>  void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display);
>  
> -void acpi_ut_report_error(char *module_name, u32 line_number);
> -
> -void acpi_ut_report_info(char *module_name, u32 line_number);
> -
> -void acpi_ut_report_warning(char *module_name, u32 line_number);
> -
>  /* Error and message reporting interfaces */
>  
>  void ACPI_INTERNAL_VAR_XFACE
>  acpi_ut_debug_print(u32 requested_debug_level,
>  		    u32 line_number,
>  		    const char *function_name,
> -		    char *module_name,
> -		    u32 component_id, char *format, ...) ACPI_PRINTF_LIKE(6);
> +		    const char *module_name,
> +		    u32 component_id,
> +		    const char *format, ...) ACPI_PRINTF_LIKE(6);
>  
>  void ACPI_INTERNAL_VAR_XFACE
>  acpi_ut_debug_print_raw(u32 requested_debug_level,
>  			u32 line_number,
>  			const char *function_name,
> -			char *module_name,
> +			const char *module_name,
>  			u32 component_id,
> -			char *format, ...) ACPI_PRINTF_LIKE(6);
> +			const char *format, ...) ACPI_PRINTF_LIKE(6);
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_error(char *module_name,
> -	      u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
> +acpi_ut_error(const char *module_name,
> +	      u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_exception(char *module_name,
> +acpi_ut_exception(const char *module_name,
>  		  u32 line_number,
> -		  acpi_status status, char *format, ...) ACPI_PRINTF_LIKE(4);
> +		  acpi_status status, const char *format, ...) ACPI_PRINTF_LIKE(4);
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_warning(char *module_name,
> -		u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
> +acpi_ut_warning(const char *module_name,
> +		u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
>  
>  void ACPI_INTERNAL_VAR_XFACE
> -acpi_ut_info(char *module_name,
> -	     u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
> +acpi_ut_info(const char *module_name,
> +	     u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
>  
>  /*
>   * utdelete - Object deletion and reference counts
> @@ -376,13 +371,13 @@ acpi_ut_execute_sxds(struct acpi_namespa
>  /*
>   * utobject - internal object create/delete/cache routines
>   */
> -union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
> +union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char *module_name,
>  							      u32 line_number,
>  							      u32 component_id,
>  							      acpi_object_type
>  							      type);
>  
> -void *acpi_ut_allocate_object_desc_dbg(char *module_name,
> +void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
>  				       u32 line_number, u32 component_id);
>  
>  #define acpi_ut_create_internal_object(t) acpi_ut_create_internal_object_dbg (_acpi_module_name,__LINE__,_COMPONENT,t)
> _
> 

