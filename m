From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/28] ACPICA: acpidump: Add support to generate acpidump release.
Date: Fri,  4 Apr 2014 12:39:42 +0800
Message-ID: <b43ba7cd43df86fe14bf364090bc05bb4ea4ca7f.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaDDEjy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:54 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The acpidump is initiated by Bob Moore and Chao Guan, fixed and completed
by Lv Zheng.

This patch is a generation of the commit that adds acpidump release
automation into ACPICA release process. Lv Zheng.

Note that this patch doesn't replace the kernel shipped acpidump with the
new acpidump.  The replacement is done by further patches.

Original-by: Chao Guan <guanchao@mail.ustc.edu.cn>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h                       |  170 +++
 tools/power/acpi/common/getopt.c                   |  239 ++++
 .../acpi/os_specific/service_layers/oslinuxtbl.c   | 1275 ++++++++++++++++++++
 .../acpi/os_specific/service_layers/osunixdir.c    |  204 ++++
 .../acpi/os_specific/service_layers/osunixmap.c    |  151 +++
 tools/power/acpi/tools/acpidump/acpidump.h         |  131 ++
 tools/power/acpi/tools/acpidump/apdump.c           |  451 +++++++
 tools/power/acpi/tools/acpidump/apfiles.c          |  228 ++++
 tools/power/acpi/tools/acpidump/apmain.c           |  340 ++++++
 9 files changed, 3189 insertions(+)
 create mode 100644 drivers/acpi/acpica/acapps.h
 create mode 100644 tools/power/acpi/common/getopt.c
 create mode 100644 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
 create mode 100644 tools/power/acpi/os_specific/service_layers/osunixdir.c
 create mode 100644 tools/power/acpi/os_specific/service_layers/osunixmap.c
 create mode 100644 tools/power/acpi/tools/acpidump/acpidump.h
 create mode 100644 tools/power/acpi/tools/acpidump/apdump.c
 create mode 100644 tools/power/acpi/tools/acpidump/apfiles.c
 create mode 100644 tools/power/acpi/tools/acpidump/apmain.c

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
new file mode 100644
index 0000000..8698ffb
--- /dev/null
+++ b/drivers/acpi/acpica/acapps.h
@@ -0,0 +1,170 @@
+/******************************************************************************
+ *
+ * Module Name: acapps - common include for ACPI applications/tools
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#ifndef _ACAPPS
+#define _ACAPPS
+
+/* Common info for tool signons */
+
+#define ACPICA_NAME                 "Intel ACPI Component Architecture"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2014 Intel Corporation"
+
+#if ACPI_MACHINE_WIDTH == 64
+#define ACPI_WIDTH          "-64"
+
+#elif ACPI_MACHINE_WIDTH == 32
+#define ACPI_WIDTH          "-32"
+
+#else
+#error unknown ACPI_MACHINE_WIDTH
+#define ACPI_WIDTH          "-??"
+
+#endif
+
+/* Macros for signons and file headers */
+
+#define ACPI_COMMON_SIGNON(utility_name) \
+	"\n%s\n%s version %8.8X%s [%s]\n%s\n\n", \
+	ACPICA_NAME, \
+	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
+	ACPICA_COPYRIGHT
+
+#define ACPI_COMMON_HEADER(utility_name, prefix) \
+	"%s%s\n%s%s version %8.8X%s [%s]\n%s%s\n%s\n", \
+	prefix, ACPICA_NAME, \
+	prefix, utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
+	prefix, ACPICA_COPYRIGHT, \
+	prefix
+
+/* Macros for usage messages */
+
+#define ACPI_USAGE_HEADER(usage) \
+	printf ("Usage: %s\nOptions:\n", usage);
+
+#define ACPI_OPTION(name, description) \
+	printf ("  %-18s%s\n", name, description);
+
+#define FILE_SUFFIX_DISASSEMBLY     "dsl"
+#define ACPI_TABLE_FILE_SUFFIX      ".dat"
+
+/*
+ * getopt
+ */
+int acpi_getopt(int argc, char **argv, char *opts);
+
+int acpi_getopt_argument(int argc, char **argv);
+
+extern int acpi_gbl_optind;
+extern int acpi_gbl_opterr;
+extern int acpi_gbl_sub_opt_char;
+extern char *acpi_gbl_optarg;
+
+/*
+ * cmfsize - Common get file size function
+ */
+u32 cm_get_file_size(FILE * file);
+
+#ifndef ACPI_DUMP_APP
+/*
+ * adisasm
+ */
+acpi_status
+ad_aml_disassemble(u8 out_to_file,
+		   char *filename, char *prefix, char **out_filename);
+
+void ad_print_statistics(void);
+
+acpi_status ad_find_dsdt(u8 **dsdt_ptr, u32 *dsdt_length);
+
+void ad_dump_tables(void);
+
+acpi_status ad_get_local_tables(void);
+
+acpi_status
+ad_parse_table(struct acpi_table_header *table,
+	       acpi_owner_id * owner_id, u8 load_table, u8 external);
+
+acpi_status ad_display_tables(char *filename, struct acpi_table_header *table);
+
+acpi_status ad_display_statistics(void);
+
+/*
+ * adwalk
+ */
+void
+acpi_dm_cross_reference_namespace(union acpi_parse_object *parse_tree_root,
+				  struct acpi_namespace_node *namespace_root,
+				  acpi_owner_id owner_id);
+
+void acpi_dm_dump_tree(union acpi_parse_object *origin);
+
+void acpi_dm_find_orphan_methods(union acpi_parse_object *origin);
+
+void
+acpi_dm_finish_namespace_load(union acpi_parse_object *parse_tree_root,
+			      struct acpi_namespace_node *namespace_root,
+			      acpi_owner_id owner_id);
+
+void
+acpi_dm_convert_resource_indexes(union acpi_parse_object *parse_tree_root,
+				 struct acpi_namespace_node *namespace_root);
+
+/*
+ * adfile
+ */
+acpi_status ad_initialize(void);
+
+char *fl_generate_filename(char *input_filename, char *suffix);
+
+acpi_status
+fl_split_input_pathname(char *input_path,
+			char **out_directory_path, char **out_filename);
+
+char *ad_generate_filename(char *prefix, char *table_id);
+
+void
+ad_write_table(struct acpi_table_header *table,
+	       u32 length, char *table_name, char *oem_table_id);
+#endif
+
+#endif				/* _ACAPPS */
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
new file mode 100644
index 0000000..a302f52
--- /dev/null
+++ b/tools/power/acpi/common/getopt.c
@@ -0,0 +1,239 @@
+/******************************************************************************
+ *
+ * Module Name: getopt
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+/*
+ * ACPICA getopt() implementation
+ *
+ * Option strings:
+ *    "f"       - Option has no arguments
+ *    "f:"      - Option requires an argument
+ *    "f^"      - Option has optional single-char sub-options
+ *    "f|"      - Option has required single-char sub-options
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acapps.h"
+
+#define ACPI_OPTION_ERROR(msg, badchar) \
+	if (acpi_gbl_opterr) {fprintf (stderr, "%s%c\n", msg, badchar);}
+
+int acpi_gbl_opterr = 1;
+int acpi_gbl_optind = 1;
+int acpi_gbl_sub_opt_char = 0;
+char *acpi_gbl_optarg;
+
+static int current_char_ptr = 1;
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_getopt_argument
+ *
+ * PARAMETERS:  argc, argv          - from main
+ *
+ * RETURN:      0 if an argument was found, -1 otherwise. Sets acpi_gbl_Optarg
+ *              to point to the next argument.
+ *
+ * DESCRIPTION: Get the next argument. Used to obtain arguments for the
+ *              two-character options after the original call to acpi_getopt.
+ *              Note: Either the argument starts at the next character after
+ *              the option, or it is pointed to by the next argv entry.
+ *              (After call to acpi_getopt, we need to backup to the previous
+ *              argv entry).
+ *
+ ******************************************************************************/
+
+int acpi_getopt_argument(int argc, char **argv)
+{
+	acpi_gbl_optind--;
+	current_char_ptr++;
+
+	if (argv[acpi_gbl_optind][(int)(current_char_ptr + 1)] != '\0') {
+		acpi_gbl_optarg =
+		    &argv[acpi_gbl_optind++][(int)(current_char_ptr + 1)];
+	} else if (++acpi_gbl_optind >= argc) {
+		ACPI_OPTION_ERROR("Option requires an argument: -", 'v');
+
+		current_char_ptr = 1;
+		return (-1);
+	} else {
+		acpi_gbl_optarg = argv[acpi_gbl_optind++];
+	}
+
+	current_char_ptr = 1;
+	return (0);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_getopt
+ *
+ * PARAMETERS:  argc, argv          - from main
+ *              opts                - options info list
+ *
+ * RETURN:      Option character or EOF
+ *
+ * DESCRIPTION: Get the next option
+ *
+ ******************************************************************************/
+
+int acpi_getopt(int argc, char **argv, char *opts)
+{
+	int current_char;
+	char *opts_ptr;
+
+	if (current_char_ptr == 1) {
+		if (acpi_gbl_optind >= argc ||
+		    argv[acpi_gbl_optind][0] != '-' ||
+		    argv[acpi_gbl_optind][1] == '\0') {
+			return (EOF);
+		} else if (strcmp(argv[acpi_gbl_optind], "--") == 0) {
+			acpi_gbl_optind++;
+			return (EOF);
+		}
+	}
+
+	/* Get the option */
+
+	current_char = argv[acpi_gbl_optind][current_char_ptr];
+
+	/* Make sure that the option is legal */
+
+	if (current_char == ':' ||
+	    (opts_ptr = strchr(opts, current_char)) == NULL) {
+		ACPI_OPTION_ERROR("Illegal option: -", current_char);
+
+		if (argv[acpi_gbl_optind][++current_char_ptr] == '\0') {
+			acpi_gbl_optind++;
+			current_char_ptr = 1;
+		}
+
+		return ('?');
+	}
+
+	/* Option requires an argument? */
+
+	if (*++opts_ptr == ':') {
+		if (argv[acpi_gbl_optind][(int)(current_char_ptr + 1)] != '\0') {
+			acpi_gbl_optarg =
+			    &argv[acpi_gbl_optind++][(int)
+						     (current_char_ptr + 1)];
+		} else if (++acpi_gbl_optind >= argc) {
+			ACPI_OPTION_ERROR("Option requires an argument: -",
+					  current_char);
+
+			current_char_ptr = 1;
+			return ('?');
+		} else {
+			acpi_gbl_optarg = argv[acpi_gbl_optind++];
+		}
+
+		current_char_ptr = 1;
+	}
+
+	/* Option has an optional argument? */
+
+	else if (*opts_ptr == '+') {
+		if (argv[acpi_gbl_optind][(int)(current_char_ptr + 1)] != '\0') {
+			acpi_gbl_optarg =
+			    &argv[acpi_gbl_optind++][(int)
+						     (current_char_ptr + 1)];
+		} else if (++acpi_gbl_optind >= argc) {
+			acpi_gbl_optarg = NULL;
+		} else {
+			acpi_gbl_optarg = argv[acpi_gbl_optind++];
+		}
+
+		current_char_ptr = 1;
+	}
+
+	/* Option has optional single-char arguments? */
+
+	else if (*opts_ptr == '^') {
+		if (argv[acpi_gbl_optind][(int)(current_char_ptr + 1)] != '\0') {
+			acpi_gbl_optarg =
+			    &argv[acpi_gbl_optind][(int)(current_char_ptr + 1)];
+		} else {
+			acpi_gbl_optarg = "^";
+		}
+
+		acpi_gbl_sub_opt_char = acpi_gbl_optarg[0];
+		acpi_gbl_optind++;
+		current_char_ptr = 1;
+	}
+
+	/* Option has a required single-char argument? */
+
+	else if (*opts_ptr == '|') {
+		if (argv[acpi_gbl_optind][(int)(current_char_ptr + 1)] != '\0') {
+			acpi_gbl_optarg =
+			    &argv[acpi_gbl_optind][(int)(current_char_ptr + 1)];
+		} else {
+			ACPI_OPTION_ERROR
+			    ("Option requires a single-character suboption: -",
+			     current_char);
+
+			current_char_ptr = 1;
+			return ('?');
+		}
+
+		acpi_gbl_sub_opt_char = acpi_gbl_optarg[0];
+		acpi_gbl_optind++;
+		current_char_ptr = 1;
+	}
+
+	/* Option with no arguments */
+
+	else {
+		if (argv[acpi_gbl_optind][++current_char_ptr] == '\0') {
+			current_char_ptr = 1;
+			acpi_gbl_optind++;
+		}
+
+		acpi_gbl_optarg = NULL;
+	}
+
+	return (current_char);
+}
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
new file mode 100644
index 0000000..e975aa9
--- /dev/null
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -0,0 +1,1275 @@
+/******************************************************************************
+ *
+ * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include "acpidump.h"
+
+#define _COMPONENT          ACPI_OS_SERVICES
+ACPI_MODULE_NAME("oslinuxtbl")
+
+#ifndef PATH_MAX
+#define PATH_MAX 256
+#endif
+/* List of information about obtained ACPI tables */
+typedef struct osl_table_info {
+	struct osl_table_info *next;
+	u32 instance;
+	char signature[ACPI_NAME_SIZE];
+
+} osl_table_info;
+
+/* Local prototypes */
+
+static acpi_status osl_table_initialize(void);
+
+static acpi_status
+osl_table_name_from_file(char *filename, char *signature, u32 *instance);
+
+static acpi_status osl_add_table_to_list(char *signature, u32 instance);
+
+static acpi_status
+osl_read_table_from_file(char *filename,
+			 acpi_size file_offset,
+			 char *signature, struct acpi_table_header **table);
+
+static acpi_status
+osl_map_table(acpi_size address,
+	      char *signature, struct acpi_table_header **table);
+
+static void osl_unmap_table(struct acpi_table_header *table);
+
+static acpi_physical_address osl_find_rsdp_via_efi(void);
+
+static acpi_status osl_load_rsdp(void);
+
+static acpi_status osl_list_customized_tables(char *directory);
+
+static acpi_status
+osl_get_customized_table(char *pathname,
+			 char *signature,
+			 u32 instance,
+			 struct acpi_table_header **table,
+			 acpi_physical_address * address);
+
+static acpi_status osl_list_bios_tables(void);
+
+static acpi_status
+osl_get_bios_table(char *signature,
+		   u32 instance,
+		   struct acpi_table_header **table,
+		   acpi_physical_address * address);
+
+static acpi_status osl_get_last_status(acpi_status default_status);
+
+/* File locations */
+
+#define DYNAMIC_TABLE_DIR   "/sys/firmware/acpi/tables/dynamic"
+#define STATIC_TABLE_DIR    "/sys/firmware/acpi/tables"
+#define EFI_SYSTAB          "/sys/firmware/efi/systab"
+
+/* Should we get dynamically loaded SSDTs from DYNAMIC_TABLE_DIR? */
+
+u8 gbl_dump_dynamic_tables = TRUE;
+
+/* Initialization flags */
+
+u8 gbl_table_list_initialized = FALSE;
+
+/* Local copies of main ACPI tables */
+
+struct acpi_table_rsdp gbl_rsdp;
+struct acpi_table_fadt *gbl_fadt = NULL;
+struct acpi_table_rsdt *gbl_rsdt = NULL;
+struct acpi_table_xsdt *gbl_xsdt = NULL;
+
+/* Table addresses */
+
+acpi_physical_address gbl_fadt_address = 0;
+acpi_physical_address gbl_rsdp_address = 0;
+
+/* Revision of RSD PTR */
+
+u8 gbl_revision = 0;
+
+struct osl_table_info *gbl_table_list_head = NULL;
+u32 gbl_table_count = 0;
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_get_last_status
+ *
+ * PARAMETERS:  default_status  - Default error status to return
+ *
+ * RETURN:      Status; Converted from errno.
+ *
+ * DESCRIPTION: Get last errno and conver it to acpi_status.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_get_last_status(acpi_status default_status)
+{
+
+	switch (errno) {
+	case EACCES:
+	case EPERM:
+
+		return (AE_ACCESS);
+
+	case ENOENT:
+
+		return (AE_NOT_FOUND);
+
+	case ENOMEM:
+
+		return (AE_NO_MEMORY);
+
+	default:
+
+		return (default_status);
+	}
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_table_by_address
+ *
+ * PARAMETERS:  address         - Physical address of the ACPI table
+ *              table           - Where a pointer to the table is returned
+ *
+ * RETURN:      Status; Table buffer is returned if AE_OK.
+ *              AE_NOT_FOUND: A valid table was not found at the address
+ *
+ * DESCRIPTION: Get an ACPI table via a physical memory address.
+ *
+ *****************************************************************************/
+
+acpi_status
+acpi_os_get_table_by_address(acpi_physical_address address,
+			     struct acpi_table_header ** table)
+{
+	u32 table_length;
+	struct acpi_table_header *mapped_table;
+	struct acpi_table_header *local_table = NULL;
+	acpi_status status = AE_OK;
+
+	/* Get main ACPI tables from memory on first invocation of this function */
+
+	status = osl_table_initialize();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Map the table and validate it */
+
+	status = osl_map_table(address, NULL, &mapped_table);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Copy table to local buffer and return it */
+
+	table_length = ap_get_table_length(mapped_table);
+	if (table_length == 0) {
+		status = AE_BAD_HEADER;
+		goto exit;
+	}
+
+	local_table = calloc(1, table_length);
+	if (!local_table) {
+		status = AE_NO_MEMORY;
+		goto exit;
+	}
+
+	ACPI_MEMCPY(local_table, mapped_table, table_length);
+
+exit:
+	osl_unmap_table(mapped_table);
+	*table = local_table;
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_table_by_name
+ *
+ * PARAMETERS:  signature       - ACPI Signature for desired table. Must be
+ *                                a null terminated 4-character string.
+ *              instance        - Multiple table support for SSDT/UEFI (0...n)
+ *                                Must be 0 for other tables.
+ *              table           - Where a pointer to the table is returned
+ *              address         - Where the table physical address is returned
+ *
+ * RETURN:      Status; Table buffer and physical address returned if AE_OK.
+ *              AE_LIMIT: Instance is beyond valid limit
+ *              AE_NOT_FOUND: A table with the signature was not found
+ *
+ * NOTE:        Assumes the input signature is uppercase.
+ *
+ *****************************************************************************/
+
+acpi_status
+acpi_os_get_table_by_name(char *signature,
+			  u32 instance,
+			  struct acpi_table_header ** table,
+			  acpi_physical_address * address)
+{
+	acpi_status status;
+
+	/* Get main ACPI tables from memory on first invocation of this function */
+
+	status = osl_table_initialize();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Not a main ACPI table, attempt to extract it from the RSDT/XSDT */
+
+	if (!gbl_dump_customized_tables) {
+
+		/* Attempt to get the table from the memory */
+
+		status =
+		    osl_get_bios_table(signature, instance, table, address);
+	} else {
+		/* Attempt to get the table from the static directory */
+
+		status = osl_get_customized_table(STATIC_TABLE_DIR, signature,
+						  instance, table, address);
+	}
+
+	if (ACPI_FAILURE(status) && status == AE_LIMIT) {
+		if (gbl_dump_dynamic_tables) {
+
+			/* Attempt to get a dynamic table */
+
+			status =
+			    osl_get_customized_table(DYNAMIC_TABLE_DIR,
+						     signature, instance, table,
+						     address);
+		}
+	}
+
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_add_table_to_list
+ *
+ * PARAMETERS:  signature       - Table signature
+ *              instance        - Table instance
+ *
+ * RETURN:      Status; Successfully added if AE_OK.
+ *              AE_NO_MEMORY: Memory allocation error
+ *
+ * DESCRIPTION: Insert a table structure into OSL table list.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_add_table_to_list(char *signature, u32 instance)
+{
+	struct osl_table_info *new_info;
+	struct osl_table_info *next;
+	u32 next_instance = 0;
+	u8 found = FALSE;
+
+	new_info = calloc(1, sizeof(struct osl_table_info));
+	if (!new_info) {
+		return (AE_NO_MEMORY);
+	}
+
+	ACPI_MOVE_NAME(new_info->signature, signature);
+
+	if (!gbl_table_list_head) {
+		gbl_table_list_head = new_info;
+	} else {
+		next = gbl_table_list_head;
+		while (1) {
+			if (ACPI_COMPARE_NAME(next->signature, signature)) {
+				if (next->instance == instance) {
+					found = TRUE;
+				}
+				if (next->instance >= next_instance) {
+					next_instance = next->instance + 1;
+				}
+			}
+
+			if (!next->next) {
+				break;
+			}
+			next = next->next;
+		}
+		next->next = new_info;
+	}
+
+	if (found) {
+		if (instance) {
+			fprintf(stderr,
+				"%4.4s: Warning unmatched table instance %d, expected %d\n",
+				signature, instance, next_instance);
+		}
+		instance = next_instance;
+	}
+
+	new_info->instance = instance;
+	gbl_table_count++;
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_table_by_index
+ *
+ * PARAMETERS:  index           - Which table to get
+ *              table           - Where a pointer to the table is returned
+ *              instance        - Where a pointer to the table instance no. is
+ *                                returned
+ *              address         - Where the table physical address is returned
+ *
+ * RETURN:      Status; Table buffer and physical address returned if AE_OK.
+ *              AE_LIMIT: Index is beyond valid limit
+ *
+ * DESCRIPTION: Get an ACPI table via an index value (0 through n). Returns
+ *              AE_LIMIT when an invalid index is reached. Index is not
+ *              necessarily an index into the RSDT/XSDT.
+ *
+ *****************************************************************************/
+
+acpi_status
+acpi_os_get_table_by_index(u32 index,
+			   struct acpi_table_header ** table,
+			   u32 *instance, acpi_physical_address * address)
+{
+	struct osl_table_info *info;
+	acpi_status status;
+	u32 i;
+
+	/* Get main ACPI tables from memory on first invocation of this function */
+
+	status = osl_table_initialize();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Validate Index */
+
+	if (index >= gbl_table_count) {
+		return (AE_LIMIT);
+	}
+
+	/* Point to the table list entry specified by the Index argument */
+
+	info = gbl_table_list_head;
+	for (i = 0; i < index; i++) {
+		info = info->next;
+	}
+
+	/* Now we can just get the table via the signature */
+
+	status = acpi_os_get_table_by_name(info->signature, info->instance,
+					   table, address);
+
+	if (ACPI_SUCCESS(status)) {
+		*instance = info->instance;
+	}
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_find_rsdp_via_efi
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      RSDP address if found
+ *
+ * DESCRIPTION: Find RSDP address via EFI.
+ *
+ *****************************************************************************/
+
+static acpi_physical_address osl_find_rsdp_via_efi(void)
+{
+	FILE *file;
+	char buffer[80];
+	unsigned long address = 0;
+
+	file = fopen(EFI_SYSTAB, "r");
+	if (file) {
+		while (fgets(buffer, 80, file)) {
+			if (sscanf(buffer, "ACPI20=0x%lx", &address) == 1) {
+				break;
+			}
+		}
+		fclose(file);
+	}
+
+	return ((acpi_physical_address) (address));
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_load_rsdp
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Scan and load RSDP.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_load_rsdp(void)
+{
+	struct acpi_table_header *mapped_table;
+	u8 *rsdp_address;
+	acpi_physical_address rsdp_base;
+	acpi_size rsdp_size;
+
+	/* Get RSDP from memory */
+
+	rsdp_size = sizeof(struct acpi_table_rsdp);
+	if (gbl_rsdp_base) {
+		rsdp_base = gbl_rsdp_base;
+	} else {
+		rsdp_base = osl_find_rsdp_via_efi();
+	}
+
+	if (!rsdp_base) {
+		rsdp_base = ACPI_HI_RSDP_WINDOW_BASE;
+		rsdp_size = ACPI_HI_RSDP_WINDOW_SIZE;
+	}
+
+	rsdp_address = acpi_os_map_memory(rsdp_base, rsdp_size);
+	if (!rsdp_address) {
+		return (osl_get_last_status(AE_BAD_ADDRESS));
+	}
+
+	/* Search low memory for the RSDP */
+
+	mapped_table = ACPI_CAST_PTR(struct acpi_table_header,
+				     acpi_tb_scan_memory_for_rsdp(rsdp_address,
+								  rsdp_size));
+	if (!mapped_table) {
+		acpi_os_unmap_memory(rsdp_address, rsdp_size);
+		return (AE_NOT_FOUND);
+	}
+
+	gbl_rsdp_address =
+	    rsdp_base + (ACPI_CAST8(mapped_table) - rsdp_address);
+
+	ACPI_MEMCPY(&gbl_rsdp, mapped_table, sizeof(struct acpi_table_rsdp));
+	acpi_os_unmap_memory(rsdp_address, rsdp_size);
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_table_initialize
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize ACPI table data. Get and store main ACPI tables to
+ *              local variables. Main ACPI tables include RSDT, FADT, RSDT,
+ *              and/or XSDT.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_table_initialize(void)
+{
+	acpi_status status;
+	acpi_physical_address address;
+
+	if (gbl_table_list_initialized) {
+		return (AE_OK);
+	}
+
+	/* Get RSDP from memory */
+
+	status = osl_load_rsdp();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Get XSDT from memory */
+
+	if (gbl_rsdp.revision) {
+		if (gbl_xsdt) {
+			free(gbl_xsdt);
+			gbl_xsdt = NULL;
+		}
+
+		gbl_revision = 2;
+		status = osl_get_bios_table(ACPI_SIG_XSDT, 0,
+					    ACPI_CAST_PTR(struct
+							  acpi_table_header *,
+							  &gbl_xsdt), &address);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	/* Get RSDT from memory */
+
+	if (gbl_rsdp.rsdt_physical_address) {
+		if (gbl_rsdt) {
+			free(gbl_rsdt);
+			gbl_rsdt = NULL;
+		}
+
+		status = osl_get_bios_table(ACPI_SIG_RSDT, 0,
+					    ACPI_CAST_PTR(struct
+							  acpi_table_header *,
+							  &gbl_rsdt), &address);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	/* Get FADT from memory */
+
+	if (gbl_fadt) {
+		free(gbl_fadt);
+		gbl_fadt = NULL;
+	}
+
+	status = osl_get_bios_table(ACPI_SIG_FADT, 0,
+				    ACPI_CAST_PTR(struct acpi_table_header *,
+						  &gbl_fadt),
+				    &gbl_fadt_address);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	if (!gbl_dump_customized_tables) {
+
+		/* Add mandatory tables to global table list first */
+
+		status = osl_add_table_to_list(ACPI_RSDP_NAME, 0);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		status = osl_add_table_to_list(ACPI_SIG_RSDT, 0);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		if (gbl_revision == 2) {
+			status = osl_add_table_to_list(ACPI_SIG_XSDT, 0);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		}
+
+		status = osl_add_table_to_list(ACPI_SIG_DSDT, 0);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		status = osl_add_table_to_list(ACPI_SIG_FACS, 0);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Add all tables found in the memory */
+
+		status = osl_list_bios_tables();
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	} else {
+		/* Add all tables found in the static directory */
+
+		status = osl_list_customized_tables(STATIC_TABLE_DIR);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	if (gbl_dump_dynamic_tables) {
+
+		/* Add all dynamically loaded tables in the dynamic directory */
+
+		status = osl_list_customized_tables(DYNAMIC_TABLE_DIR);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	gbl_table_list_initialized = TRUE;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_list_bios_tables
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status; Table list is initialized if AE_OK.
+ *
+ * DESCRIPTION: Add ACPI tables to the table list from memory.
+ *
+ * NOTE:        This works on Linux as table customization does not modify the
+ *              addresses stored in RSDP/RSDT/XSDT/FADT.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_list_bios_tables(void)
+{
+	struct acpi_table_header *mapped_table = NULL;
+	u8 *table_data;
+	u8 number_of_tables;
+	u8 item_size;
+	acpi_physical_address table_address = 0;
+	acpi_status status = AE_OK;
+	u32 i;
+
+	if (gbl_revision) {
+		item_size = sizeof(u64);
+		table_data =
+		    ACPI_CAST8(gbl_xsdt) + sizeof(struct acpi_table_header);
+		number_of_tables =
+		    (u8)((gbl_xsdt->header.length -
+			  sizeof(struct acpi_table_header))
+			 / item_size);
+	} else {		/* Use RSDT if XSDT is not available */
+
+		item_size = sizeof(u32);
+		table_data =
+		    ACPI_CAST8(gbl_rsdt) + sizeof(struct acpi_table_header);
+		number_of_tables =
+		    (u8)((gbl_rsdt->header.length -
+			  sizeof(struct acpi_table_header))
+			 / item_size);
+	}
+
+	/* Search RSDT/XSDT for the requested table */
+
+	for (i = 0; i < number_of_tables; ++i, table_data += item_size) {
+		if (gbl_revision) {
+			table_address =
+			    (acpi_physical_address) (*ACPI_CAST64(table_data));
+		} else {
+			table_address =
+			    (acpi_physical_address) (*ACPI_CAST32(table_data));
+		}
+
+		status = osl_map_table(table_address, NULL, &mapped_table);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		osl_add_table_to_list(mapped_table->signature, 0);
+		osl_unmap_table(mapped_table);
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_get_bios_table
+ *
+ * PARAMETERS:  signature       - ACPI Signature for common table. Must be
+ *                                a null terminated 4-character string.
+ *              instance        - Multiple table support for SSDT/UEFI (0...n)
+ *                                Must be 0 for other tables.
+ *              table           - Where a pointer to the table is returned
+ *              address         - Where the table physical address is returned
+ *
+ * RETURN:      Status; Table buffer and physical address returned if AE_OK.
+ *              AE_LIMIT: Instance is beyond valid limit
+ *              AE_NOT_FOUND: A table with the signature was not found
+ *
+ * DESCRIPTION: Get a BIOS provided ACPI table
+ *
+ * NOTE:        Assumes the input signature is uppercase.
+ *
+ *****************************************************************************/
+
+static acpi_status
+osl_get_bios_table(char *signature,
+		   u32 instance,
+		   struct acpi_table_header **table,
+		   acpi_physical_address * address)
+{
+	struct acpi_table_header *local_table = NULL;
+	struct acpi_table_header *mapped_table = NULL;
+	u8 *table_data;
+	u8 number_of_tables;
+	u8 item_size;
+	u32 current_instance = 0;
+	acpi_physical_address table_address = 0;
+	u32 table_length = 0;
+	acpi_status status = AE_OK;
+	u32 i;
+
+	/* Handle special tables whose addresses are not in RSDT/XSDT */
+
+	if (ACPI_COMPARE_NAME(signature, ACPI_RSDP_NAME) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
+		/*
+		 * Get the appropriate address, either 32-bit or 64-bit. Be very
+		 * careful about the FADT length and validate table addresses.
+		 * Note: The 64-bit addresses have priority.
+		 */
+		if (ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT)) {
+			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XDSDT) &&
+			    gbl_fadt->Xdsdt) {
+				table_address =
+				    (acpi_physical_address) gbl_fadt->Xdsdt;
+			} else
+			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_DSDT)
+				&& gbl_fadt->dsdt) {
+				table_address =
+				    (acpi_physical_address) gbl_fadt->dsdt;
+			}
+		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
+			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XFACS) &&
+			    gbl_fadt->Xfacs) {
+				table_address =
+				    (acpi_physical_address) gbl_fadt->Xfacs;
+			} else
+			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_FACS)
+				&& gbl_fadt->facs) {
+				table_address =
+				    (acpi_physical_address) gbl_fadt->facs;
+			}
+		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT)) {
+			if (!gbl_revision) {
+				return (AE_BAD_SIGNATURE);
+			}
+			table_address =
+			    (acpi_physical_address) gbl_rsdp.
+			    xsdt_physical_address;
+		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT)) {
+			table_address =
+			    (acpi_physical_address) gbl_rsdp.
+			    rsdt_physical_address;
+		} else {
+			table_address =
+			    (acpi_physical_address) gbl_rsdp_address;
+			signature = ACPI_SIG_RSDP;
+		}
+
+		/* Now we can get the requested special table */
+
+		status = osl_map_table(table_address, signature, &mapped_table);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		table_length = ap_get_table_length(mapped_table);
+	} else {		/* Case for a normal ACPI table */
+
+		if (gbl_revision) {
+			item_size = sizeof(u64);
+			table_data =
+			    ACPI_CAST8(gbl_xsdt) +
+			    sizeof(struct acpi_table_header);
+			number_of_tables =
+			    (u8)((gbl_xsdt->header.length -
+				  sizeof(struct acpi_table_header))
+				 / item_size);
+		} else {	/* Use RSDT if XSDT is not available */
+
+			item_size = sizeof(u32);
+			table_data =
+			    ACPI_CAST8(gbl_rsdt) +
+			    sizeof(struct acpi_table_header);
+			number_of_tables =
+			    (u8)((gbl_rsdt->header.length -
+				  sizeof(struct acpi_table_header))
+				 / item_size);
+		}
+
+		/* Search RSDT/XSDT for the requested table */
+
+		for (i = 0; i < number_of_tables; ++i, table_data += item_size) {
+			if (gbl_revision) {
+				table_address =
+				    (acpi_physical_address) (*ACPI_CAST64
+							     (table_data));
+			} else {
+				table_address =
+				    (acpi_physical_address) (*ACPI_CAST32
+							     (table_data));
+			}
+
+			status =
+			    osl_map_table(table_address, NULL, &mapped_table);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+			table_length = mapped_table->length;
+
+			/* Does this table match the requested signature? */
+
+			if (!ACPI_COMPARE_NAME
+			    (mapped_table->signature, signature)) {
+				osl_unmap_table(mapped_table);
+				mapped_table = NULL;
+				continue;
+			}
+
+			/* Match table instance (for SSDT/UEFI tables) */
+
+			if (current_instance != instance) {
+				osl_unmap_table(mapped_table);
+				mapped_table = NULL;
+				current_instance++;
+				continue;
+			}
+
+			break;
+		}
+	}
+
+	if (!mapped_table) {
+		return (AE_LIMIT);
+	}
+
+	if (table_length == 0) {
+		status = AE_BAD_HEADER;
+		goto exit;
+	}
+
+	/* Copy table to local buffer and return it */
+
+	local_table = calloc(1, table_length);
+	if (!local_table) {
+		status = AE_NO_MEMORY;
+		goto exit;
+	}
+
+	ACPI_MEMCPY(local_table, mapped_table, table_length);
+	*address = table_address;
+	*table = local_table;
+
+exit:
+	osl_unmap_table(mapped_table);
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_list_customized_tables
+ *
+ * PARAMETERS:  directory           - Directory that contains the tables
+ *
+ * RETURN:      Status; Table list is initialized if AE_OK.
+ *
+ * DESCRIPTION: Add ACPI tables to the table list from a directory.
+ *
+ *****************************************************************************/
+
+static acpi_status osl_list_customized_tables(char *directory)
+{
+	void *table_dir;
+	u32 instance;
+	char temp_name[ACPI_NAME_SIZE];
+	char *filename;
+	acpi_status status = AE_OK;
+
+	/* Open the requested directory */
+
+	table_dir = acpi_os_open_directory(directory, "*", REQUEST_FILE_ONLY);
+	if (!table_dir) {
+		return (osl_get_last_status(AE_NOT_FOUND));
+	}
+
+	/* Examine all entries in this directory */
+
+	while ((filename = acpi_os_get_next_filename(table_dir))) {
+
+		/* Extract table name and instance number */
+
+		status =
+		    osl_table_name_from_file(filename, temp_name, &instance);
+
+		/* Ignore meaningless files */
+
+		if (ACPI_FAILURE(status)) {
+			continue;
+		}
+
+		/* Add new info node to global table list */
+
+		status = osl_add_table_to_list(temp_name, instance);
+		if (ACPI_FAILURE(status)) {
+			break;
+		}
+	}
+
+	acpi_os_close_directory(table_dir);
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_map_table
+ *
+ * PARAMETERS:  address             - Address of the table in memory
+ *              signature           - Optional ACPI Signature for desired table.
+ *                                    Null terminated 4-character string.
+ *              table               - Where a pointer to the mapped table is
+ *                                    returned
+ *
+ * RETURN:      Status; Mapped table is returned if AE_OK.
+ *              AE_NOT_FOUND: A valid table was not found at the address
+ *
+ * DESCRIPTION: Map entire ACPI table into caller's address space.
+ *
+ *****************************************************************************/
+
+static acpi_status
+osl_map_table(acpi_size address,
+	      char *signature, struct acpi_table_header **table)
+{
+	struct acpi_table_header *mapped_table;
+	u32 length;
+
+	if (!address) {
+		return (AE_BAD_ADDRESS);
+	}
+
+	/*
+	 * Map the header so we can get the table length.
+	 * Use sizeof (struct acpi_table_header) as:
+	 * 1. it is bigger than 24 to include RSDP->Length
+	 * 2. it is smaller than sizeof (struct acpi_table_rsdp)
+	 */
+	mapped_table =
+	    acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!mapped_table) {
+		fprintf(stderr, "Could not map table header at 0x%8.8X%8.8X\n",
+			ACPI_FORMAT_UINT64(address));
+		return (osl_get_last_status(AE_BAD_ADDRESS));
+	}
+
+	/* If specified, signature must match */
+
+	if (signature && !ACPI_COMPARE_NAME(signature, mapped_table->signature)) {
+		acpi_os_unmap_memory(mapped_table,
+				     sizeof(struct acpi_table_header));
+		return (AE_BAD_SIGNATURE);
+	}
+
+	/* Map the entire table */
+
+	length = ap_get_table_length(mapped_table);
+	acpi_os_unmap_memory(mapped_table, sizeof(struct acpi_table_header));
+	if (length == 0) {
+		return (AE_BAD_HEADER);
+	}
+
+	mapped_table = acpi_os_map_memory(address, length);
+	if (!mapped_table) {
+		fprintf(stderr,
+			"Could not map table at 0x%8.8X%8.8X length %8.8X\n",
+			ACPI_FORMAT_UINT64(address), length);
+		return (osl_get_last_status(AE_INVALID_TABLE_LENGTH));
+	}
+
+	(void)ap_is_valid_checksum(mapped_table);
+
+	*table = mapped_table;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_unmap_table
+ *
+ * PARAMETERS:  table               - A pointer to the mapped table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Unmap entire ACPI table.
+ *
+ *****************************************************************************/
+
+static void osl_unmap_table(struct acpi_table_header *table)
+{
+	if (table) {
+		acpi_os_unmap_memory(table, ap_get_table_length(table));
+	}
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_table_name_from_file
+ *
+ * PARAMETERS:  filename            - File that contains the desired table
+ *              signature           - Pointer to 4-character buffer to store
+ *                                    extracted table signature.
+ *              instance            - Pointer to integer to store extracted
+ *                                    table instance number.
+ *
+ * RETURN:      Status; Table name is extracted if AE_OK.
+ *
+ * DESCRIPTION: Extract table signature and instance number from a table file
+ *              name.
+ *
+ *****************************************************************************/
+
+static acpi_status
+osl_table_name_from_file(char *filename, char *signature, u32 *instance)
+{
+
+	/* Ignore meaningless files */
+
+	if (strlen(filename) < ACPI_NAME_SIZE) {
+		return (AE_BAD_SIGNATURE);
+	}
+
+	/* Extract instance number */
+
+	if (isdigit((int)filename[ACPI_NAME_SIZE])) {
+		sscanf(&filename[ACPI_NAME_SIZE], "%d", instance);
+	} else if (strlen(filename) != ACPI_NAME_SIZE) {
+		return (AE_BAD_SIGNATURE);
+	} else {
+		*instance = 0;
+	}
+
+	/* Extract signature */
+
+	ACPI_MOVE_NAME(signature, filename);
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_read_table_from_file
+ *
+ * PARAMETERS:  filename            - File that contains the desired table
+ *              file_offset         - Offset of the table in file
+ *              signature           - Optional ACPI Signature for desired table.
+ *                                    A null terminated 4-character string.
+ *              table               - Where a pointer to the table is returned
+ *
+ * RETURN:      Status; Table buffer is returned if AE_OK.
+ *
+ * DESCRIPTION: Read a ACPI table from a file.
+ *
+ *****************************************************************************/
+
+static acpi_status
+osl_read_table_from_file(char *filename,
+			 acpi_size file_offset,
+			 char *signature, struct acpi_table_header **table)
+{
+	FILE *table_file;
+	struct acpi_table_header header;
+	struct acpi_table_header *local_table = NULL;
+	u32 table_length;
+	s32 count;
+	u32 total = 0;
+	acpi_status status = AE_OK;
+
+	/* Open the file */
+
+	table_file = fopen(filename, "rb");
+	if (table_file == NULL) {
+		fprintf(stderr, "Could not open table file: %s\n", filename);
+		return (osl_get_last_status(AE_NOT_FOUND));
+	}
+
+	fseek(table_file, file_offset, SEEK_SET);
+
+	/* Read the Table header to get the table length */
+
+	count = fread(&header, 1, sizeof(struct acpi_table_header), table_file);
+	if (count != sizeof(struct acpi_table_header)) {
+		fprintf(stderr, "Could not read table header: %s\n", filename);
+		status = AE_BAD_HEADER;
+		goto exit;
+	}
+
+	/* If signature is specified, it must match the table */
+
+	if (signature && !ACPI_COMPARE_NAME(signature, header.signature)) {
+		fprintf(stderr,
+			"Incorrect signature: Expecting %4.4s, found %4.4s\n",
+			signature, header.signature);
+		status = AE_BAD_SIGNATURE;
+		goto exit;
+	}
+
+	table_length = ap_get_table_length(&header);
+	if (table_length == 0) {
+		status = AE_BAD_HEADER;
+		goto exit;
+	}
+
+	/* Read the entire table into a local buffer */
+
+	local_table = calloc(1, table_length);
+	if (!local_table) {
+		fprintf(stderr,
+			"%4.4s: Could not allocate buffer for table of length %X\n",
+			header.signature, table_length);
+		status = AE_NO_MEMORY;
+		goto exit;
+	}
+
+	fseek(table_file, file_offset, SEEK_SET);
+
+	while (!feof(table_file) && total < table_length) {
+		count = fread(local_table + total, 1, table_length - total, table_file);
+		if (count < 0) {
+			fprintf(stderr, "%4.4s: Could not read table content\n",
+				header.signature);
+			status = AE_INVALID_TABLE_LENGTH;
+			goto exit;
+		}
+
+		total += count;
+	}
+
+	/* Validate checksum */
+
+	(void)ap_is_valid_checksum(local_table);
+
+exit:
+	fclose(table_file);
+	*table = local_table;
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    osl_get_customized_table
+ *
+ * PARAMETERS:  pathname        - Directory to find Linux customized table
+ *              signature       - ACPI Signature for desired table. Must be
+ *                                a null terminated 4-character string.
+ *              instance        - Multiple table support for SSDT/UEFI (0...n)
+ *                                Must be 0 for other tables.
+ *              table           - Where a pointer to the table is returned
+ *              address         - Where the table physical address is returned
+ *
+ * RETURN:      Status; Table buffer is returned if AE_OK.
+ *              AE_LIMIT: Instance is beyond valid limit
+ *              AE_NOT_FOUND: A table with the signature was not found
+ *
+ * DESCRIPTION: Get an OS customized table.
+ *
+ *****************************************************************************/
+
+static acpi_status
+osl_get_customized_table(char *pathname,
+			 char *signature,
+			 u32 instance,
+			 struct acpi_table_header **table,
+			 acpi_physical_address * address)
+{
+	void *table_dir;
+	u32 current_instance = 0;
+	char temp_name[ACPI_NAME_SIZE];
+	char table_filename[PATH_MAX];
+	char *filename;
+	acpi_status status;
+
+	/* Open the directory for customized tables */
+
+	table_dir = acpi_os_open_directory(pathname, "*", REQUEST_FILE_ONLY);
+	if (!table_dir) {
+		return (osl_get_last_status(AE_NOT_FOUND));
+	}
+
+	/* Attempt to find the table in the directory */
+
+	while ((filename = acpi_os_get_next_filename(table_dir))) {
+
+		/* Ignore meaningless files */
+
+		if (!ACPI_COMPARE_NAME(filename, signature)) {
+			continue;
+		}
+
+		/* Extract table name and instance number */
+
+		status =
+		    osl_table_name_from_file(filename, temp_name,
+					     &current_instance);
+
+		/* Ignore meaningless files */
+
+		if (ACPI_FAILURE(status) || current_instance != instance) {
+			continue;
+		}
+
+		/* Create the table pathname */
+
+		if (instance != 0) {
+			sprintf(table_filename, "%s/%4.4s%d", pathname,
+				temp_name, instance);
+		} else {
+			sprintf(table_filename, "%s/%4.4s", pathname,
+				temp_name);
+		}
+		break;
+	}
+
+	acpi_os_close_directory(table_dir);
+
+	if (!filename) {
+		return (AE_LIMIT);
+	}
+
+	/* There is no physical address saved for customized tables, use zero */
+
+	*address = 0;
+	status = osl_read_table_from_file(table_filename, 0, NULL, table);
+
+	return (status);
+}
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
new file mode 100644
index 0000000..733f9e4
--- /dev/null
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -0,0 +1,204 @@
+/******************************************************************************
+ *
+ * Module Name: osunixdir - Unix directory access interfaces
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+#include <fnmatch.h>
+#include <ctype.h>
+#include <sys/stat.h>
+
+/*
+ * Allocated structure returned from os_open_directory
+ */
+typedef struct external_find_info {
+	char *dir_pathname;
+	DIR *dir_ptr;
+	char temp_buffer[256];
+	char *wildcard_spec;
+	char requested_file_type;
+
+} external_find_info;
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_open_directory
+ *
+ * PARAMETERS:  dir_pathname        - Full pathname to the directory
+ *              wildcard_spec       - string of the form "*.c", etc.
+ *
+ * RETURN:      A directory "handle" to be used in subsequent search operations.
+ *              NULL returned on failure.
+ *
+ * DESCRIPTION: Open a directory in preparation for a wildcard search
+ *
+ ******************************************************************************/
+
+void *acpi_os_open_directory(char *dir_pathname,
+			     char *wildcard_spec, char requested_file_type)
+{
+	struct external_find_info *external_info;
+	DIR *dir;
+
+	/* Allocate the info struct that will be returned to the caller */
+
+	external_info = calloc(1, sizeof(struct external_find_info));
+	if (!external_info) {
+		return (NULL);
+	}
+
+	/* Get the directory stream */
+
+	dir = opendir(dir_pathname);
+	if (!dir) {
+		fprintf(stderr, "Cannot open directory - %s\n", dir_pathname);
+		free(external_info);
+		return (NULL);
+	}
+
+	/* Save the info in the return structure */
+
+	external_info->wildcard_spec = wildcard_spec;
+	external_info->requested_file_type = requested_file_type;
+	external_info->dir_pathname = dir_pathname;
+	external_info->dir_ptr = dir;
+	return (external_info);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_next_filename
+ *
+ * PARAMETERS:  dir_handle          - Created via acpi_os_open_directory
+ *
+ * RETURN:      Next filename matched. NULL if no more matches.
+ *
+ * DESCRIPTION: Get the next file in the directory that matches the wildcard
+ *              specification.
+ *
+ ******************************************************************************/
+
+char *acpi_os_get_next_filename(void *dir_handle)
+{
+	struct external_find_info *external_info = dir_handle;
+	struct dirent *dir_entry;
+	char *temp_str;
+	int str_len;
+	struct stat temp_stat;
+	int err;
+
+	while ((dir_entry = readdir(external_info->dir_ptr))) {
+		if (!fnmatch
+		    (external_info->wildcard_spec, dir_entry->d_name, 0)) {
+			if (dir_entry->d_name[0] == '.') {
+				continue;
+			}
+
+			str_len = strlen(dir_entry->d_name) +
+			    strlen(external_info->dir_pathname) + 2;
+
+			temp_str = calloc(str_len, 1);
+			if (!temp_str) {
+				fprintf(stderr,
+					"Could not allocate buffer for temporary string\n");
+				return (NULL);
+			}
+
+			strcpy(temp_str, external_info->dir_pathname);
+			strcat(temp_str, "/");
+			strcat(temp_str, dir_entry->d_name);
+
+			err = stat(temp_str, &temp_stat);
+			if (err == -1) {
+				fprintf(stderr,
+					"Cannot stat file (should not happen) - %s\n",
+					temp_str);
+				free(temp_str);
+				return (NULL);
+			}
+
+			free(temp_str);
+
+			if ((S_ISDIR(temp_stat.st_mode)
+			     && (external_info->requested_file_type ==
+				 REQUEST_DIR_ONLY))
+			    || ((!S_ISDIR(temp_stat.st_mode)
+				 && external_info->requested_file_type ==
+				 REQUEST_FILE_ONLY))) {
+
+				/* copy to a temp buffer because dir_entry struct is on the stack */
+
+				strcpy(external_info->temp_buffer,
+				       dir_entry->d_name);
+				return (external_info->temp_buffer);
+			}
+		}
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_close_directory
+ *
+ * PARAMETERS:  dir_handle          - Created via acpi_os_open_directory
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Close the open directory and cleanup.
+ *
+ ******************************************************************************/
+
+void acpi_os_close_directory(void *dir_handle)
+{
+	struct external_find_info *external_info = dir_handle;
+
+	/* Close the directory and free allocations */
+
+	closedir(external_info->dir_ptr);
+	free(dir_handle);
+}
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
new file mode 100644
index 0000000..99b47b6
--- /dev/null
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -0,0 +1,151 @@
+/******************************************************************************
+ *
+ * Module Name: osunixmap - Unix OSL for file mappings
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include "acpidump.h"
+#include <unistd.h>
+#include <sys/mman.h>
+#ifdef _free_BSD
+#include <sys/param.h>
+#endif
+
+#define _COMPONENT          ACPI_OS_SERVICES
+ACPI_MODULE_NAME("osunixmap")
+
+#ifndef O_BINARY
+#define O_BINARY 0
+#endif
+#ifdef _free_BSD
+#define MMAP_FLAGS          MAP_SHARED
+#else
+#define MMAP_FLAGS          MAP_PRIVATE
+#endif
+#define SYSTEM_MEMORY       "/dev/mem"
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_page_size
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Page size of the platform.
+ *
+ * DESCRIPTION: Obtain page size of the platform.
+ *
+ ******************************************************************************/
+static acpi_size acpi_os_get_page_size(void)
+{
+
+#ifdef PAGE_SIZE
+	return PAGE_SIZE;
+#else
+	return sysconf(_SC_PAGESIZE);
+#endif
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os_map_memory
+ *
+ * PARAMETERS:  where               - Physical address of memory to be mapped
+ *              length              - How much memory to map
+ *
+ * RETURN:      Pointer to mapped memory. Null on error.
+ *
+ * DESCRIPTION: Map physical memory into local address space.
+ *
+ *****************************************************************************/
+
+void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
+{
+	u8 *mapped_memory;
+	acpi_physical_address offset;
+	acpi_size page_size;
+	int fd;
+
+	fd = open(SYSTEM_MEMORY, O_RDONLY | O_BINARY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s\n", SYSTEM_MEMORY);
+		return (NULL);
+	}
+
+	/* Align the offset to use mmap */
+
+	page_size = acpi_os_get_page_size();
+	offset = where % page_size;
+
+	/* Map the table header to get the length of the full table */
+
+	mapped_memory = mmap(NULL, (length + offset), PROT_READ, MMAP_FLAGS,
+			     fd, (where - offset));
+	if (mapped_memory == MAP_FAILED) {
+		fprintf(stderr, "Cannot map %s\n", SYSTEM_MEMORY);
+		close(fd);
+		return (NULL);
+	}
+
+	close(fd);
+	return (ACPI_CAST8(mapped_memory + offset));
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os_unmap_memory
+ *
+ * PARAMETERS:  where               - Logical address of memory to be unmapped
+ *              length              - How much memory to unmap
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Delete a previously created mapping. Where and Length must
+ *              correspond to a previous mapping exactly.
+ *
+ *****************************************************************************/
+
+void acpi_os_unmap_memory(void *where, acpi_size length)
+{
+	acpi_physical_address offset;
+	acpi_size page_size;
+
+	page_size = acpi_os_get_page_size();
+	offset = (acpi_physical_address) where % page_size;
+	munmap((u8 *)where - offset, (length + offset));
+}
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
new file mode 100644
index 0000000..3361b9e
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -0,0 +1,131 @@
+/******************************************************************************
+ *
+ * Module Name: acpidump.h - Include file for acpi_dump utility
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "actables.h"
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+/*
+ * Global variables. Defined in main.c only, externed in all other files
+ */
+#ifdef _DECLARE_GLOBALS
+#define EXTERN
+#define INIT_GLOBAL(a,b)        a=b
+#else
+#define EXTERN                  extern
+#define INIT_GLOBAL(a,b)        a
+#endif
+
+/* Globals */
+
+EXTERN u8 INIT_GLOBAL(gbl_summary_mode, FALSE);
+EXTERN u8 INIT_GLOBAL(gbl_verbose_mode, FALSE);
+EXTERN u8 INIT_GLOBAL(gbl_binary_mode, FALSE);
+EXTERN u8 INIT_GLOBAL(gbl_dump_customized_tables, FALSE);
+EXTERN FILE INIT_GLOBAL(*gbl_output_file, NULL);
+EXTERN char INIT_GLOBAL(*gbl_output_filename, NULL);
+EXTERN u64 INIT_GLOBAL(gbl_rsdp_base, 0);
+
+/* Globals required for use with ACPICA modules */
+
+#ifdef _DECLARE_GLOBALS
+u8 acpi_gbl_enable_interpreter_slack = FALSE;
+u8 acpi_gbl_integer_byte_width = 8;
+u32 acpi_dbg_level = 0;
+u32 acpi_dbg_layer = 0;
+#endif
+
+/* Action table used to defer requested options */
+
+struct ap_dump_action {
+	char *argument;
+	u32 to_be_done;
+};
+
+#define AP_MAX_ACTIONS              32
+
+#define AP_DUMP_ALL_TABLES          0
+#define AP_DUMP_TABLE_BY_ADDRESS    1
+#define AP_DUMP_TABLE_BY_NAME       2
+#define AP_DUMP_TABLE_BY_FILE       3
+
+#define AP_MAX_ACPI_FILES           256	/* Prevent infinite loops */
+
+/* Minimum FADT sizes for various table addresses */
+
+#define MIN_FADT_FOR_DSDT           (ACPI_FADT_OFFSET (dsdt) + sizeof (u32))
+#define MIN_FADT_FOR_FACS           (ACPI_FADT_OFFSET (facs) + sizeof (u32))
+#define MIN_FADT_FOR_XDSDT          (ACPI_FADT_OFFSET (Xdsdt) + sizeof (u64))
+#define MIN_FADT_FOR_XFACS          (ACPI_FADT_OFFSET (Xfacs) + sizeof (u64))
+
+/*
+ * apdump - Table get/dump routines
+ */
+int ap_dump_table_from_file(char *pathname);
+
+int ap_dump_table_by_name(char *signature);
+
+int ap_dump_table_by_address(char *ascii_address);
+
+int ap_dump_all_tables(void);
+
+u8 ap_is_valid_header(struct acpi_table_header *table);
+
+u8 ap_is_valid_checksum(struct acpi_table_header *table);
+
+u32 ap_get_table_length(struct acpi_table_header *table);
+
+/*
+ * apfiles - File I/O utilities
+ */
+int ap_open_output_file(char *pathname);
+
+int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance);
+
+struct acpi_table_header *ap_get_table_from_file(char *pathname,
+						 u32 *file_size);
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
new file mode 100644
index 0000000..3cac123
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -0,0 +1,451 @@
+/******************************************************************************
+ *
+ * Module Name: apdump - Dump routines for ACPI tables (acpidump)
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include "acpidump.h"
+
+/* Local prototypes */
+
+static int
+ap_dump_table_buffer(struct acpi_table_header *table,
+		     u32 instance, acpi_physical_address address);
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_is_valid_header
+ *
+ * PARAMETERS:  table               - Pointer to table to be validated
+ *
+ * RETURN:      TRUE if the header appears to be valid. FALSE otherwise
+ *
+ * DESCRIPTION: Check for a valid ACPI table header
+ *
+ ******************************************************************************/
+
+u8 ap_is_valid_header(struct acpi_table_header *table)
+{
+
+	if (!ACPI_VALIDATE_RSDP_SIG(table->signature)) {
+
+		/* Make sure signature is all ASCII and a valid ACPI name */
+
+		if (!acpi_ut_valid_acpi_name(table->signature)) {
+			fprintf(stderr,
+				"Table signature (0x%8.8X) is invalid\n",
+				*(u32 *)table->signature);
+			return (FALSE);
+		}
+
+		/* Check for minimum table length */
+
+		if (table->length < sizeof(struct acpi_table_header)) {
+			fprintf(stderr, "Table length (0x%8.8X) is invalid\n",
+				table->length);
+			return (FALSE);
+		}
+	}
+
+	return (TRUE);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_is_valid_checksum
+ *
+ * PARAMETERS:  table               - Pointer to table to be validated
+ *
+ * RETURN:      TRUE if the checksum appears to be valid. FALSE otherwise.
+ *
+ * DESCRIPTION: Check for a valid ACPI table checksum.
+ *
+ ******************************************************************************/
+
+u8 ap_is_valid_checksum(struct acpi_table_header *table)
+{
+	acpi_status status;
+	struct acpi_table_rsdp *rsdp;
+
+	if (ACPI_VALIDATE_RSDP_SIG(table->signature)) {
+		/*
+		 * Checksum for RSDP.
+		 * Note: Other checksums are computed during the table dump.
+		 */
+		rsdp = ACPI_CAST_PTR(struct acpi_table_rsdp, table);
+		status = acpi_tb_validate_rsdp(rsdp);
+	} else {
+		status = acpi_tb_verify_checksum(table, table->length);
+	}
+
+	if (ACPI_FAILURE(status)) {
+		fprintf(stderr, "%4.4s: Warning: wrong checksum in table\n",
+			table->signature);
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_get_table_length
+ *
+ * PARAMETERS:  table               - Pointer to the table
+ *
+ * RETURN:      Table length
+ *
+ * DESCRIPTION: Obtain table length according to table signature.
+ *
+ ******************************************************************************/
+
+u32 ap_get_table_length(struct acpi_table_header *table)
+{
+	struct acpi_table_rsdp *rsdp;
+
+	/* Check if table is valid */
+
+	if (!ap_is_valid_header(table)) {
+		return (0);
+	}
+
+	if (ACPI_VALIDATE_RSDP_SIG(table->signature)) {
+		rsdp = ACPI_CAST_PTR(struct acpi_table_rsdp, table);
+		return (rsdp->length);
+	}
+
+	/* Normal ACPI table */
+
+	return (table->length);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_dump_table_buffer
+ *
+ * PARAMETERS:  table               - ACPI table to be dumped
+ *              instance            - ACPI table instance no. to be dumped
+ *              address             - Physical address of the table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump an ACPI table in standard ASCII hex format, with a
+ *              header that is compatible with the acpi_xtract utility.
+ *
+ ******************************************************************************/
+
+static int
+ap_dump_table_buffer(struct acpi_table_header *table,
+		     u32 instance, acpi_physical_address address)
+{
+	u32 table_length;
+
+	table_length = ap_get_table_length(table);
+
+	/* Print only the header if requested */
+
+	if (gbl_summary_mode) {
+		acpi_tb_print_table_header(address, table);
+		return (0);
+	}
+
+	/* Dump to binary file if requested */
+
+	if (gbl_binary_mode) {
+		return (ap_write_to_binary_file(table, instance));
+	}
+
+	/*
+	 * Dump the table with header for use with acpixtract utility.
+	 * Note: simplest to just always emit a 64-bit address. acpi_xtract
+	 * utility can handle this.
+	 */
+	printf("%4.4s @ 0x%8.8X%8.8X\n", table->signature,
+	       ACPI_FORMAT_UINT64(address));
+
+	acpi_ut_dump_buffer(ACPI_CAST_PTR(u8, table), table_length,
+			    DB_BYTE_DISPLAY, 0);
+	printf("\n");
+	return (0);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_dump_all_tables
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get all tables from the RSDT/XSDT (or at least all of the
+ *              tables that we can possibly get).
+ *
+ ******************************************************************************/
+
+int ap_dump_all_tables(void)
+{
+	struct acpi_table_header *table;
+	u32 instance = 0;
+	acpi_physical_address address;
+	acpi_status status;
+	int table_status;
+	u32 i;
+
+	/* Get and dump all available ACPI tables */
+
+	for (i = 0; i < AP_MAX_ACPI_FILES; i++) {
+		status =
+		    acpi_os_get_table_by_index(i, &table, &instance, &address);
+		if (ACPI_FAILURE(status)) {
+
+			/* AE_LIMIT means that no more tables are available */
+
+			if (status == AE_LIMIT) {
+				return (0);
+			} else if (i == 0) {
+				fprintf(stderr,
+					"Could not get ACPI tables, %s\n",
+					acpi_format_exception(status));
+				return (-1);
+			} else {
+				fprintf(stderr,
+					"Could not get ACPI table at index %u, %s\n",
+					i, acpi_format_exception(status));
+				continue;
+			}
+		}
+
+		table_status = ap_dump_table_buffer(table, instance, address);
+		free(table);
+
+		if (table_status) {
+			break;
+		}
+	}
+
+	/* Something seriously bad happened if the loop terminates here */
+
+	return (-1);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_dump_table_by_address
+ *
+ * PARAMETERS:  ascii_address       - Address for requested ACPI table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get an ACPI table via a physical address and dump it.
+ *
+ ******************************************************************************/
+
+int ap_dump_table_by_address(char *ascii_address)
+{
+	acpi_physical_address address;
+	struct acpi_table_header *table;
+	acpi_status status;
+	int table_status;
+	u64 long_address;
+
+	/* Convert argument to an integer physical address */
+
+	status = acpi_ut_strtoul64(ascii_address, 0, &long_address);
+	if (ACPI_FAILURE(status)) {
+		fprintf(stderr, "%s: Could not convert to a physical address\n",
+			ascii_address);
+		return (-1);
+	}
+
+	address = (acpi_physical_address) long_address;
+	status = acpi_os_get_table_by_address(address, &table);
+	if (ACPI_FAILURE(status)) {
+		fprintf(stderr, "Could not get table at 0x%8.8X%8.8X, %s\n",
+			ACPI_FORMAT_UINT64(address),
+			acpi_format_exception(status));
+		return (-1);
+	}
+
+	table_status = ap_dump_table_buffer(table, 0, address);
+	free(table);
+	return (table_status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_dump_table_by_name
+ *
+ * PARAMETERS:  signature           - Requested ACPI table signature
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get an ACPI table via a signature and dump it. Handles
+ *              multiple tables with the same signature (SSDTs).
+ *
+ ******************************************************************************/
+
+int ap_dump_table_by_name(char *signature)
+{
+	char local_signature[ACPI_NAME_SIZE + 1];
+	u32 instance;
+	struct acpi_table_header *table;
+	acpi_physical_address address;
+	acpi_status status;
+	int table_status;
+
+	if (strlen(signature) != ACPI_NAME_SIZE) {
+		fprintf(stderr,
+			"Invalid table signature [%s]: must be exactly 4 characters\n",
+			signature);
+		return (-1);
+	}
+
+	/* Table signatures are expected to be uppercase */
+
+	strcpy(local_signature, signature);
+	acpi_ut_strupr(local_signature);
+
+	/* To be friendly, handle tables whose signatures do not match the name */
+
+	if (ACPI_COMPARE_NAME(local_signature, "FADT")) {
+		strcpy(local_signature, ACPI_SIG_FADT);
+	} else if (ACPI_COMPARE_NAME(local_signature, "MADT")) {
+		strcpy(local_signature, ACPI_SIG_MADT);
+	}
+
+	/* Dump all instances of this signature (to handle multiple SSDTs) */
+
+	for (instance = 0; instance < AP_MAX_ACPI_FILES; instance++) {
+		status = acpi_os_get_table_by_name(local_signature, instance,
+						   &table, &address);
+		if (ACPI_FAILURE(status)) {
+
+			/* AE_LIMIT means that no more tables are available */
+
+			if (status == AE_LIMIT) {
+				return (0);
+			}
+
+			fprintf(stderr,
+				"Could not get ACPI table with signature [%s], %s\n",
+				local_signature, acpi_format_exception(status));
+			return (-1);
+		}
+
+		table_status = ap_dump_table_buffer(table, instance, address);
+		free(table);
+
+		if (table_status) {
+			break;
+		}
+	}
+
+	/* Something seriously bad happened if the loop terminates here */
+
+	return (-1);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_dump_table_from_file
+ *
+ * PARAMETERS:  pathname            - File containing the binary ACPI table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Dump an ACPI table from a binary file
+ *
+ ******************************************************************************/
+
+int ap_dump_table_from_file(char *pathname)
+{
+	struct acpi_table_header *table;
+	u32 file_size = 0;
+	int table_status = -1;
+
+	/* Get the entire ACPI table from the file */
+
+	table = ap_get_table_from_file(pathname, &file_size);
+	if (!table) {
+		return (-1);
+	}
+
+	/* File must be at least as long as the table length */
+
+	if (table->length > file_size) {
+		fprintf(stderr,
+			"Table length (0x%X) is too large for input file (0x%X) %s\n",
+			table->length, file_size, pathname);
+		goto exit;
+	}
+
+	if (gbl_verbose_mode) {
+		fprintf(stderr,
+			"Input file:  %s contains table [%4.4s], 0x%X (%u) bytes\n",
+			pathname, table->signature, file_size, file_size);
+	}
+
+	table_status = ap_dump_table_buffer(table, 0, 0);
+
+exit:
+	free(table);
+	return (table_status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_os* print functions
+ *
+ * DESCRIPTION: Used for linkage with ACPICA modules
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE acpi_os_printf(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf(stdout, fmt, args);
+	va_end(args);
+}
+
+void acpi_os_vprintf(const char *fmt, va_list args)
+{
+	vfprintf(stdout, fmt, args);
+}
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
new file mode 100644
index 0000000..4488acc
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -0,0 +1,228 @@
+/******************************************************************************
+ *
+ * Module Name: apfiles - File-related functions for acpidump utility
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include "acpidump.h"
+#include "acapps.h"
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_open_output_file
+ *
+ * PARAMETERS:  pathname            - Output filename
+ *
+ * RETURN:      Open file handle
+ *
+ * DESCRIPTION: Open a text output file for acpidump. Checks if file already
+ *              exists.
+ *
+ ******************************************************************************/
+
+int ap_open_output_file(char *pathname)
+{
+	struct stat stat_info;
+	FILE *file;
+
+	/* If file exists, prompt for overwrite */
+
+	if (!stat(pathname, &stat_info)) {
+		fprintf(stderr,
+			"Target path already exists, overwrite? [y|n] ");
+
+		if (getchar() != 'y') {
+			return (-1);
+		}
+	}
+
+	/* Point stdout to the file */
+
+	file = freopen(pathname, "w", stdout);
+	if (!file) {
+		perror("Could not open output file");
+		return (-1);
+	}
+
+	/* Save the file and path */
+
+	gbl_output_file = file;
+	gbl_output_filename = pathname;
+	return (0);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_write_to_binary_file
+ *
+ * PARAMETERS:  table               - ACPI table to be written
+ *              instance            - ACPI table instance no. to be written
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Write an ACPI table to a binary file. Builds the output
+ *              filename from the table signature.
+ *
+ ******************************************************************************/
+
+int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
+{
+	char filename[ACPI_NAME_SIZE + 16];
+	char instance_str[16];
+	FILE *file;
+	size_t actual;
+	u32 table_length;
+
+	/* Obtain table length */
+
+	table_length = ap_get_table_length(table);
+
+	/* Construct lower-case filename from the table local signature */
+
+	if (ACPI_VALIDATE_RSDP_SIG(table->signature)) {
+		ACPI_MOVE_NAME(filename, ACPI_RSDP_NAME);
+	} else {
+		ACPI_MOVE_NAME(filename, table->signature);
+	}
+	filename[0] = (char)ACPI_TOLOWER(filename[0]);
+	filename[1] = (char)ACPI_TOLOWER(filename[1]);
+	filename[2] = (char)ACPI_TOLOWER(filename[2]);
+	filename[3] = (char)ACPI_TOLOWER(filename[3]);
+	filename[ACPI_NAME_SIZE] = 0;
+
+	/* Handle multiple SSDts - create different filenames for each */
+
+	if (instance > 0) {
+		sprintf(instance_str, "%u", instance);
+		strcat(filename, instance_str);
+	}
+
+	strcat(filename, ACPI_TABLE_FILE_SUFFIX);
+
+	if (gbl_verbose_mode) {
+		fprintf(stderr,
+			"Writing [%4.4s] to binary file: %s 0x%X (%u) bytes\n",
+			table->signature, filename, table->length,
+			table->length);
+	}
+
+	/* Open the file and dump the entire table in binary mode */
+
+	file = fopen(filename, "wb");
+	if (!file) {
+		perror("Could not open output file");
+		return (-1);
+	}
+
+	actual = fwrite(table, 1, table_length, file);
+	if (actual != table_length) {
+		perror("Error writing binary output file");
+		fclose(file);
+		return (-1);
+	}
+
+	fclose(file);
+	return (0);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_get_table_from_file
+ *
+ * PARAMETERS:  pathname            - File containing the binary ACPI table
+ *              out_file_size       - Where the file size is returned
+ *
+ * RETURN:      Buffer containing the ACPI table. NULL on error.
+ *
+ * DESCRIPTION: Open a file and read it entirely into a new buffer
+ *
+ ******************************************************************************/
+
+struct acpi_table_header *ap_get_table_from_file(char *pathname,
+						 u32 *out_file_size)
+{
+	struct acpi_table_header *buffer = NULL;
+	FILE *file;
+	u32 file_size;
+	size_t actual;
+
+	/* Must use binary mode */
+
+	file = fopen(pathname, "rb");
+	if (!file) {
+		perror("Could not open input file");
+		return (NULL);
+	}
+
+	/* Need file size to allocate a buffer */
+
+	file_size = cm_get_file_size(file);
+	if (file_size == ACPI_UINT32_MAX) {
+		fprintf(stderr,
+			"Could not get input file size: %s\n", pathname);
+		goto cleanup;
+	}
+
+	/* Allocate a buffer for the entire file */
+
+	buffer = calloc(1, file_size);
+	if (!buffer) {
+		fprintf(stderr,
+			"Could not allocate file buffer of size: %u\n",
+			file_size);
+		goto cleanup;
+	}
+
+	/* Read the entire file */
+
+	actual = fread(buffer, 1, file_size, file);
+	if (actual != file_size) {
+		fprintf(stderr, "Could not read input file: %s\n", pathname);
+		free(buffer);
+		buffer = NULL;
+		goto cleanup;
+	}
+
+	*out_file_size = file_size;
+
+cleanup:
+	fclose(file);
+	return (buffer);
+}
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
new file mode 100644
index 0000000..70d71ec
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -0,0 +1,340 @@
+/******************************************************************************
+ *
+ * Module Name: apmain - Main module for the acpidump utility
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#define _DECLARE_GLOBALS
+#include "acpidump.h"
+#include "acapps.h"
+
+/*
+ * acpidump - A portable utility for obtaining system ACPI tables and dumping
+ * them in an ASCII hex format suitable for binary extraction via acpixtract.
+ *
+ * Obtaining the system ACPI tables is an OS-specific operation.
+ *
+ * This utility can be ported to any host operating system by providing a
+ * module containing system-specific versions of these interfaces:
+ *
+ *      acpi_os_get_table_by_address
+ *      acpi_os_get_table_by_index
+ *      acpi_os_get_table_by_name
+ *
+ * See the ACPICA Reference Guide for the exact definitions of these
+ * interfaces. Also, see these ACPICA source code modules for example
+ * implementations:
+ *
+ *      source/os_specific/service_layers/oswintbl.c
+ *      source/os_specific/service_layers/oslinuxtbl.c
+ */
+
+/* Local prototypes */
+
+static void ap_display_usage(void);
+
+static int ap_do_options(int argc, char **argv);
+
+static void ap_insert_action(char *argument, u32 to_be_done);
+
+/* Table for deferred actions from command line options */
+
+struct ap_dump_action action_table[AP_MAX_ACTIONS];
+u32 current_action = 0;
+
+#define AP_UTILITY_NAME             "ACPI Binary Table Dump Utility"
+#define AP_SUPPORTED_OPTIONS        "?a:bcf:hn:o:r:svz"
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_display_usage
+ *
+ * DESCRIPTION: Usage message for the acpi_dump utility
+ *
+ ******************************************************************************/
+
+static void ap_display_usage(void)
+{
+
+	ACPI_USAGE_HEADER("acpidump [options]");
+
+	ACPI_OPTION("-b", "Dump tables to binary files");
+	ACPI_OPTION("-c", "Dump customized tables");
+	ACPI_OPTION("-h -?", "This help message");
+	ACPI_OPTION("-o <File>", "Redirect output to file");
+	ACPI_OPTION("-r <Address>", "Dump tables from specified RSDP");
+	ACPI_OPTION("-s", "Print table summaries only");
+	ACPI_OPTION("-v", "Display version information");
+	ACPI_OPTION("-z", "Verbose mode");
+
+	printf("\nTable Options:\n");
+
+	ACPI_OPTION("-a <Address>", "Get table via a physical address");
+	ACPI_OPTION("-f <BinaryFile>", "Get table via a binary file");
+	ACPI_OPTION("-n <Signature>", "Get table via a name/signature");
+
+	printf("\n"
+	       "Invocation without parameters dumps all available tables\n"
+	       "Multiple mixed instances of -a, -f, and -n are supported\n\n");
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_insert_action
+ *
+ * PARAMETERS:  argument            - Pointer to the argument for this action
+ *              to_be_done          - What to do to process this action
+ *
+ * RETURN:      None. Exits program if action table becomes full.
+ *
+ * DESCRIPTION: Add an action item to the action table
+ *
+ ******************************************************************************/
+
+static void ap_insert_action(char *argument, u32 to_be_done)
+{
+
+	/* Insert action and check for table overflow */
+
+	action_table[current_action].argument = argument;
+	action_table[current_action].to_be_done = to_be_done;
+
+	current_action++;
+	if (current_action > AP_MAX_ACTIONS) {
+		fprintf(stderr, "Too many table options (max %u)\n",
+			AP_MAX_ACTIONS);
+		exit(-1);
+	}
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    ap_do_options
+ *
+ * PARAMETERS:  argc/argv           - Standard argc/argv
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Command line option processing. The main actions for getting
+ *              and dumping tables are deferred via the action table.
+ *
+ *****************************************************************************/
+
+static int ap_do_options(int argc, char **argv)
+{
+	int j;
+	acpi_status status;
+
+	/* Command line options */
+
+	while ((j = acpi_getopt(argc, argv, AP_SUPPORTED_OPTIONS)) != EOF)
+		switch (j) {
+			/*
+			 * Global options
+			 */
+		case 'b':	/* Dump all input tables to binary files */
+
+			gbl_binary_mode = TRUE;
+			continue;
+
+		case 'c':	/* Dump customized tables */
+
+			gbl_dump_customized_tables = TRUE;
+			continue;
+
+		case 'h':
+		case '?':
+
+			ap_display_usage();
+			exit(0);
+
+		case 'o':	/* Redirect output to a single file */
+
+			if (ap_open_output_file(acpi_gbl_optarg)) {
+				exit(-1);
+			}
+			continue;
+
+		case 'r':	/* Dump tables from specified RSDP */
+
+			status =
+			    acpi_ut_strtoul64(acpi_gbl_optarg, 0,
+					      &gbl_rsdp_base);
+			if (ACPI_FAILURE(status)) {
+				fprintf(stderr,
+					"%s: Could not convert to a physical address\n",
+					acpi_gbl_optarg);
+				exit(-1);
+			}
+			continue;
+
+		case 's':	/* Print table summaries only */
+
+			gbl_summary_mode = TRUE;
+			continue;
+
+		case 'v':	/* Revision/version */
+
+			printf(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+			exit(0);
+
+		case 'z':	/* Verbose mode */
+
+			gbl_verbose_mode = TRUE;
+			fprintf(stderr, ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+			continue;
+
+			/*
+			 * Table options
+			 */
+		case 'a':	/* Get table by physical address */
+
+			ap_insert_action(acpi_gbl_optarg,
+					 AP_DUMP_TABLE_BY_ADDRESS);
+			break;
+
+		case 'f':	/* Get table from a file */
+
+			ap_insert_action(acpi_gbl_optarg,
+					 AP_DUMP_TABLE_BY_FILE);
+			break;
+
+		case 'n':	/* Get table by input name (signature) */
+
+			ap_insert_action(acpi_gbl_optarg,
+					 AP_DUMP_TABLE_BY_NAME);
+			break;
+
+		default:
+
+			ap_display_usage();
+			exit(-1);
+		}
+
+	/* If there are no actions, this means "get/dump all tables" */
+
+	if (current_action == 0) {
+		ap_insert_action(NULL, AP_DUMP_ALL_TABLES);
+	}
+
+	return (0);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    main
+ *
+ * PARAMETERS:  argc/argv           - Standard argc/argv
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: C main function for acpidump utility
+ *
+ ******************************************************************************/
+
+int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
+{
+	int status = 0;
+	struct ap_dump_action *action;
+	u32 file_size;
+	u32 i;
+
+	ACPI_DEBUG_INITIALIZE();	/* For debug version only */
+
+	/* Process command line options */
+
+	if (ap_do_options(argc, argv)) {
+		return (-1);
+	}
+
+	/* Get/dump ACPI table(s) as requested */
+
+	for (i = 0; i < current_action; i++) {
+		action = &action_table[i];
+		switch (action->to_be_done) {
+		case AP_DUMP_ALL_TABLES:
+
+			status = ap_dump_all_tables();
+			break;
+
+		case AP_DUMP_TABLE_BY_ADDRESS:
+
+			status = ap_dump_table_by_address(action->argument);
+			break;
+
+		case AP_DUMP_TABLE_BY_NAME:
+
+			status = ap_dump_table_by_name(action->argument);
+			break;
+
+		case AP_DUMP_TABLE_BY_FILE:
+
+			status = ap_dump_table_from_file(action->argument);
+			break;
+
+		default:
+
+			fprintf(stderr,
+				"Internal error, invalid action: 0x%X\n",
+				action->to_be_done);
+			return (-1);
+		}
+
+		if (status) {
+			return (status);
+		}
+	}
+
+	if (gbl_output_file) {
+		if (gbl_verbose_mode) {
+
+			/* Summary for the output file */
+
+			file_size = cm_get_file_size(gbl_output_file);
+			fprintf(stderr,
+				"Output file %s contains 0x%X (%u) bytes\n\n",
+				gbl_output_filename, file_size, file_size);
+		}
+
+		fclose(gbl_output_file);
+	}
+
+	return (status);
+}
-- 
1.7.10

