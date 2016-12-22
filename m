From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] acpi: Fix format string type mistakes
Date: Thu, 22 Dec 2016 06:52:10 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE19857@SHSMSX101.ccr.corp.intel.com>
References: <20161216215137.GA96800@beast>
 <1AE640813FDE7649BE1B193DEA596E886CDFF331@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE14340@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE153A3@SHSMSX101.ccr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E5493D9@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5103 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755602AbcLVGwP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Dec 2016 01:52:15 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5493D9@ORSMSX110.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Kees Cook <keescook@chromium.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, "devel@acpica.org" <devel@acpica.org>

The original change doesn't handle ACPI_SIZE (which can be UINT64/UINT32 for different architectures) correctly.
I changed it when it is back ported.
This sounds like a different problem.

Thanks and best regards
Lv

> From: Moore, Robert
> Subject: RE: [PATCH] acpi: Fix format string type mistakes
> 
> These formatting changes will not compile under:
> 
> Gcc 4.4.5
> Gcc 5.4.0
> 
> The printf formatting stuff is very delicate, as ACPICA has to be compiled under many different
> compilers.
> 
> Bob
> 
> > From: Zheng, Lv
> > Subject: RE: [PATCH] acpi: Fix format string type mistakes
> >
> > Hi, Kees and Emese
> >
> > The pull request is under rebasing.
> > So if you cannot reach the URL, find the commit here:
> > https://github.com/acpica/acpica/pull/196
> >
> > Thanks and best regards
> > Lv
> >
> > > From: Zheng, Lv
> > > Subject: RE: [PATCH] acpi: Fix format string type mistakes
> > >
> > > Hi, Kees and Emese
> > >
> > > I just helped to back port the commit here:
> > > https://github.com/acpica/acpica/pull/196/commits/5e64857f
> > > If you can see something wrong in it, please let me know.
> > >
> > > Thanks and best regards
> > > Lv
> > >
> > > > From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> > > > Subject: Re: [Devel] [PATCH] acpi: Fix format string type mistakes
> > > >
> > > > Hi,
> > > >
> > > > > From: Kees Cook [mailto:keescook@chromium.org]
> > > > > Subject: [PATCH] acpi: Fix format string type mistakes
> > > > >
> > > > > From: Emese Revfy <re.emese@gmail.com>
> > > > >
> > > > > This adds the missing __printf attribute which allows compile time
> > > > > format string checking (and will be used by the coming initify gcc
> > > > > plugin). Additionally, this fixes the warnings exposed by the
> > attribute.
> > > > >
> > > > > Signed-off-by: Emese Revfy <re.emese@gmail.com>
> > > > > [kees: split scsi/acpi, merged attr and fix, new commit messages]
> > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > ---
> > > > >  drivers/acpi/acpica/dbhistry.c |  2 +-
> > > > > drivers/acpi/acpica/dbinput.c  | 10 ++---
> > > > > drivers/acpi/acpica/dbstats.c  | 88
> > > > > +++++++++++++++++++++---------------------
> > > > >  drivers/acpi/acpica/utdebug.c  |  2 +-
> > > > >  include/acpi/acpiosxf.h        |  3 +-
> > > > >  5 files changed, 53 insertions(+), 52 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/dbhistry.c
> > > > > b/drivers/acpi/acpica/dbhistry.c index 46bd65d38df9..ec9da4830f6a
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/dbhistry.c
> > > > > +++ b/drivers/acpi/acpica/dbhistry.c
> > > > > @@ -155,7 +155,7 @@ void acpi_db_display_history(void)
> > > > >
> > > > >  	for (i = 0; i < acpi_gbl_num_history; i++) {
> > > > >  		if (acpi_gbl_history_buffer[history_index].command) {
> > > > > -			acpi_os_printf("%3ld %s\n",
> > > > > +			acpi_os_printf("%3u %s\n",
> > > > >
> > acpi_gbl_history_buffer[history_index].
> > > > >  				       cmd_num,
> > > > >
> > acpi_gbl_history_buffer[history_index].
> > > > > diff --git a/drivers/acpi/acpica/dbinput.c
> > > > > b/drivers/acpi/acpica/dbinput.c index 068214f9cc9d..43be06bdb790
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/dbinput.c
> > > > > +++ b/drivers/acpi/acpica/dbinput.c
> > > > > @@ -608,7 +608,7 @@ static u32 acpi_db_get_line(char
> > *input_buffer)
> > > > >  	    (acpi_gbl_db_parsed_buf, sizeof(acpi_gbl_db_parsed_buf),
> > > > >  	     input_buffer)) {
> > > > >  		acpi_os_printf
> > > > > -		    ("Buffer overflow while parsing input line (max %u
> > characters)\n",
> > > > > +		    ("Buffer overflow while parsing input line (max %lu
> > > > > +characters)\n",
> > > > >  		     sizeof(acpi_gbl_db_parsed_buf));
> > > > >  		return (0);
> > > > >  	}
> > > > > @@ -864,24 +864,24 @@ acpi_db_command_dispatch(char *input_buffer,
> > > > >
> > > > >  		if (param_count == 0) {
> > > > >  			acpi_os_printf
> > > > > -			    ("Current debug level for file output is:
> > %8.8lX\n",
> > > > > +			    ("Current debug level for file output is:
> > %8.8X\n",
> > > > >  			     acpi_gbl_db_debug_level);
> > > > >  			acpi_os_printf
> > > > > -			    ("Current debug level for console output is:
> > %8.8lX\n",
> > > > > +			    ("Current debug level for console output is:
> > %8.8X\n",
> > > > >  			     acpi_gbl_db_console_debug_level);
> > > > >  		} else if (param_count == 2) {
> > > > >  			temp = acpi_gbl_db_console_debug_level;
> > > > >  			acpi_gbl_db_console_debug_level =
> > > > >  			    strtoul(acpi_gbl_db_args[1], NULL, 16);
> > > > >  			acpi_os_printf
> > > > > -			    ("Debug Level for console output was %8.8lX,
> > now %8.8lX\n",
> > > > > +			    ("Debug Level for console output was %8.8X, now
> > %8.8X\n",
> > > > >  			     temp, acpi_gbl_db_console_debug_level);
> > > > >  		} else {
> > > > >  			temp = acpi_gbl_db_debug_level;
> > > > >  			acpi_gbl_db_debug_level =
> > > > >  			    strtoul(acpi_gbl_db_args[1], NULL, 16);
> > > > >  			acpi_os_printf
> > > > > -			    ("Debug Level for file output was %8.8lX, now
> > %8.8lX\n",
> > > > > +			    ("Debug Level for file output was %8.8X, now
> > %8.8X\n",
> > > > >  			     temp, acpi_gbl_db_debug_level);
> > > > >  		}
> > > > >  		break;
> > > > > diff --git a/drivers/acpi/acpica/dbstats.c
> > > > > b/drivers/acpi/acpica/dbstats.c index a414e1fa6f9d..de7023024b12
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/dbstats.c
> > > > > +++ b/drivers/acpi/acpica/dbstats.c
> > > > > @@ -377,17 +377,17 @@ acpi_status acpi_db_display_statistics(char
> > *type_arg)
> > > > >  			       "ACPI_TYPE", "NODES", "OBJECTS");
> > > > >
> > > > >  		for (i = 0; i < ACPI_TYPE_NS_NODE_MAX; i++) {
> > > > > -			acpi_os_printf("%16.16s % 10ld% 10ld\n",
> > > > > +			acpi_os_printf("%16.16s % 10d% 10d\n",
> > > > >  				       acpi_ut_get_type_name(i),
> > > > >  				       acpi_gbl_node_type_count[i],
> > > > >  				       acpi_gbl_obj_type_count[i]);
> > > > >  		}
> > > > >
> > > > > -		acpi_os_printf("%16.16s % 10ld% 10ld\n", "Misc/Unknown",
> > > > > +		acpi_os_printf("%16.16s % 10d% 10d\n", "Misc/Unknown",
> > > > >  			       acpi_gbl_node_type_count_misc,
> > > > >  			       acpi_gbl_obj_type_count_misc);
> > > > >
> > > > > -		acpi_os_printf("%16.16s % 10ld% 10ld\n", "TOTALS:",
> > > > > +		acpi_os_printf("%16.16s % 10d% 10d\n", "TOTALS:",
> > > > >  			       acpi_gbl_num_nodes, acpi_gbl_num_objects);
> > > > >  		break;
> > > > >
> > > > > @@ -415,16 +415,16 @@ acpi_status acpi_db_display_statistics(char
> > *type_arg)
> > > > >  	case CMD_STAT_MISC:
> > > > >
> > > > >  		acpi_os_printf("\nMiscellaneous Statistics:\n\n");
> > > > > -		acpi_os_printf("Calls to AcpiPsFind:.. ........% 7ld\n",
> > > > > +		acpi_os_printf("Calls to AcpiPsFind:.. ........% 7u\n",
> > > > >  			       acpi_gbl_ps_find_count);
> > > > > -		acpi_os_printf("Calls to AcpiNsLookup:..........%
> > 7ld\n",
> > > > > +		acpi_os_printf("Calls to AcpiNsLookup:..........% 7u\n",
> > > > >  			       acpi_gbl_ns_lookup_count);
> > > > >
> > > > >  		acpi_os_printf("\n");
> > > > >
> > > > >  		acpi_os_printf("Mutex usage:\n\n");
> > > > >  		for (i = 0; i < ACPI_NUM_MUTEX; i++) {
> > > > > -			acpi_os_printf("%-28s:     % 7ld\n",
> > > > > +			acpi_os_printf("%-28s:     % 7u\n",
> > > > >  				       acpi_ut_get_mutex_name(i),
> > > > >  				       acpi_gbl_mutex_info[i].use_count);
> > > > >  		}
> > > > > @@ -434,87 +434,87 @@ acpi_status acpi_db_display_statistics(char
> > > > > *type_arg)
> > > > >
> > > > >  		acpi_os_printf("\nInternal object sizes:\n\n");
> > > > >
> > > > > -		acpi_os_printf("Common         %3d\n",
> > > > > +		acpi_os_printf("Common         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_common));
> > > > > -		acpi_os_printf("Number         %3d\n",
> > > > > +		acpi_os_printf("Number         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_integer));
> > > > > -		acpi_os_printf("String         %3d\n",
> > > > > +		acpi_os_printf("String         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_string));
> > > > > -		acpi_os_printf("Buffer         %3d\n",
> > > > > +		acpi_os_printf("Buffer         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_buffer));
> > > > > -		acpi_os_printf("Package        %3d\n",
> > > > > +		acpi_os_printf("Package        %3lu\n",
> > > > >  			       sizeof(struct acpi_object_package));
> > > > > -		acpi_os_printf("BufferField    %3d\n",
> > > > > +		acpi_os_printf("BufferField    %3lu\n",
> > > > >  			       sizeof(struct acpi_object_buffer_field));
> > > > > -		acpi_os_printf("Device         %3d\n",
> > > > > +		acpi_os_printf("Device         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_device));
> > > > > -		acpi_os_printf("Event          %3d\n",
> > > > > +		acpi_os_printf("Event          %3lu\n",
> > > > >  			       sizeof(struct acpi_object_event));
> > > > > -		acpi_os_printf("Method         %3d\n",
> > > > > +		acpi_os_printf("Method         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_method));
> > > > > -		acpi_os_printf("Mutex          %3d\n",
> > > > > +		acpi_os_printf("Mutex          %3lu\n",
> > > > >  			       sizeof(struct acpi_object_mutex));
> > > > > -		acpi_os_printf("Region         %3d\n",
> > > > > +		acpi_os_printf("Region         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_region));
> > > > > -		acpi_os_printf("PowerResource  %3d\n",
> > > > > +		acpi_os_printf("PowerResource  %3lu\n",
> > > > >  			       sizeof(struct acpi_object_power_resource));
> > > > > -		acpi_os_printf("Processor      %3d\n",
> > > > > +		acpi_os_printf("Processor      %3lu\n",
> > > > >  			       sizeof(struct acpi_object_processor));
> > > > > -		acpi_os_printf("ThermalZone    %3d\n",
> > > > > +		acpi_os_printf("ThermalZone    %3lu\n",
> > > > >  			       sizeof(struct acpi_object_thermal_zone));
> > > > > -		acpi_os_printf("RegionField    %3d\n",
> > > > > +		acpi_os_printf("RegionField    %3lu\n",
> > > > >  			       sizeof(struct acpi_object_region_field));
> > > > > -		acpi_os_printf("BankField      %3d\n",
> > > > > +		acpi_os_printf("BankField      %3lu\n",
> > > > >  			       sizeof(struct acpi_object_bank_field));
> > > > > -		acpi_os_printf("IndexField     %3d\n",
> > > > > +		acpi_os_printf("IndexField     %3lu\n",
> > > > >  			       sizeof(struct acpi_object_index_field));
> > > > > -		acpi_os_printf("Reference      %3d\n",
> > > > > +		acpi_os_printf("Reference      %3lu\n",
> > > > >  			       sizeof(struct acpi_object_reference));
> > > > > -		acpi_os_printf("Notify         %3d\n",
> > > > > +		acpi_os_printf("Notify         %3lu\n",
> > > > >  			       sizeof(struct acpi_object_notify_handler));
> > > > > -		acpi_os_printf("AddressSpace   %3d\n",
> > > > > +		acpi_os_printf("AddressSpace   %3lu\n",
> > > > >  			       sizeof(struct acpi_object_addr_handler));
> > > > > -		acpi_os_printf("Extra          %3d\n",
> > > > > +		acpi_os_printf("Extra          %3lu\n",
> > > > >  			       sizeof(struct acpi_object_extra));
> > > > > -		acpi_os_printf("Data           %3d\n",
> > > > > +		acpi_os_printf("Data           %3lu\n",
> > > > >  			       sizeof(struct acpi_object_data));
> > > > >
> > > > >  		acpi_os_printf("\n");
> > > > >
> > > > > -		acpi_os_printf("ParseObject    %3d\n",
> > > > > +		acpi_os_printf("ParseObject    %3lu\n",
> > > > >  			       sizeof(struct acpi_parse_obj_common));
> > > > > -		acpi_os_printf("ParseObjectNamed %3d\n",
> > > > > +		acpi_os_printf("ParseObjectNamed %3lu\n",
> > > > >  			       sizeof(struct acpi_parse_obj_named));
> > > > > -		acpi_os_printf("ParseObjectAsl %3d\n",
> > > > > +		acpi_os_printf("ParseObjectAsl %3lu\n",
> > > > >  			       sizeof(struct acpi_parse_obj_asl));
> > > > > -		acpi_os_printf("OperandObject  %3d\n",
> > > > > +		acpi_os_printf("OperandObject  %3lu\n",
> > > > >  			       sizeof(union acpi_operand_object));
> > > > > -		acpi_os_printf("NamespaceNode  %3d\n",
> > > > > +		acpi_os_printf("NamespaceNode  %3lu\n",
> > > > >  			       sizeof(struct acpi_namespace_node));
> > > > > -		acpi_os_printf("AcpiObject     %3d\n",
> > > > > +		acpi_os_printf("AcpiObject     %3lu\n",
> > > > >  			       sizeof(union acpi_object));
> > > > >
> > > > >  		acpi_os_printf("\n");
> > > > >
> > > > > -		acpi_os_printf("Generic State  %3d\n",
> > > > > +		acpi_os_printf("Generic State  %3lu\n",
> > > > >  			       sizeof(union acpi_generic_state));
> > > > > -		acpi_os_printf("Common State   %3d\n",
> > > > > +		acpi_os_printf("Common State   %3lu\n",
> > > > >  			       sizeof(struct acpi_common_state));
> > > > > -		acpi_os_printf("Control State  %3d\n",
> > > > > +		acpi_os_printf("Control State  %3lu\n",
> > > > >  			       sizeof(struct acpi_control_state));
> > > > > -		acpi_os_printf("Update State   %3d\n",
> > > > > +		acpi_os_printf("Update State   %3lu\n",
> > > > >  			       sizeof(struct acpi_update_state));
> > > > > -		acpi_os_printf("Scope State    %3d\n",
> > > > > +		acpi_os_printf("Scope State    %3lu\n",
> > > > >  			       sizeof(struct acpi_scope_state));
> > > > > -		acpi_os_printf("Parse Scope    %3d\n",
> > > > > +		acpi_os_printf("Parse Scope    %3lu\n",
> > > > >  			       sizeof(struct acpi_pscope_state));
> > > > > -		acpi_os_printf("Package State  %3d\n",
> > > > > +		acpi_os_printf("Package State  %3lu\n",
> > > > >  			       sizeof(struct acpi_pkg_state));
> > > > > -		acpi_os_printf("Thread State   %3d\n",
> > > > > +		acpi_os_printf("Thread State   %3lu\n",
> > > > >  			       sizeof(struct acpi_thread_state));
> > > > > -		acpi_os_printf("Result Values  %3d\n",
> > > > > +		acpi_os_printf("Result Values  %3lu\n",
> > > > >  			       sizeof(struct acpi_result_values));
> > > > > -		acpi_os_printf("Notify Info    %3d\n",
> > > > > +		acpi_os_printf("Notify Info    %3lu\n",
> > > > >  			       sizeof(struct acpi_notify_info));
> > > > >  		break;
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/utdebug.c
> > > > > b/drivers/acpi/acpica/utdebug.c index 044df9b0356e..b4cdb9c14a87
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/utdebug.c
> > > > > +++ b/drivers/acpi/acpica/utdebug.c
> > > > > @@ -189,7 +189,7 @@ acpi_debug_print(u32 requested_debug_level,
> > > > >  	 * Display the module name, current line number, thread ID
> > (if requested),
> > > > >  	 * current procedure nesting level, and the current procedure
> > name
> > > > >  	 */
> > > > > -	acpi_os_printf("%9s-%04ld ", module_name, line_number);
> > > > > +	acpi_os_printf("%9s-%04u ", module_name, line_number);
> > > > >
> > > > >  #ifdef ACPI_APPLICATION
> > > > >  	/*
> > > >
> > > > Please split above changes into a separate patch.
> > > > I'm not sure if the changes can break other compilers.
> > > > Please clone https://github.com/acpica/acpica, and submit a pull
> > > > request there to have more ACPICA reviewers.
> > > >
> > > > > diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> > > > > index f3414c83abb1..48b21490bbeb 100644
> > > > > --- a/include/acpi/acpiosxf.h
> > > > > +++ b/include/acpi/acpiosxf.h
> > > > > @@ -337,11 +337,12 @@ acpi_status acpi_os_signal(u32 function,
> > void *info);
> > > > >   * Debug print routines
> > > > >   */
> > > > >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_printf
> > > > > +__printf(1, 2)
> > > > >  void ACPI_INTERNAL_VAR_XFACE acpi_os_printf(const char *format,
> > > > > ...);  #endif
> > > > >
> > > > >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_vprintf
> > > > > -void acpi_os_vprintf(const char *format, va_list args);
> > > > > +__printf(1, 0) void acpi_os_vprintf(const char *format, va_list
> > > > > +args);
> > > > >  #endif
> > > > >
> > > > >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
> > > >
> > > > You can use ACPI_PRINTF_LIKE macro instead.
> > > > This can directly go into Linux upstream.
> > > > You can prepare a different pull request for ACPICA upstream or I
> > > > can help to back port the change.
> > > >
> > > > Thanks
> > > > Lv
> > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > > > > --
> > > > > Kees Cook
> > > > > Nexus Security
> > > > _______________________________________________
> > > > Devel mailing list
> > > > Devel@acpica.org
> > > > https://lists.acpica.org/mailman/listinfo/devel
