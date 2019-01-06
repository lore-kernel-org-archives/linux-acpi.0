From: Joe Perches <joe@perches.com>
Subject: acpi_string with const char * losing casts
Date: Sun, 06 Jan 2019 13:52:37 -0800
Message-ID: <3e9bc1431278847ad72fc32960b3687da3f01909.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

include/acpi/actypes.h:typedef char *acpi_string;       /* Null terminated ASCII string */

It seems there are cases where a function with an acpi_string
argument should instead use const acpi_string.

Some acpi function callers cast const char * to non-const to
avoid compiler warnings.

It would be good to use const acpi_string where appropriate in
the generic acpi_<foo> functions instead.

Also acpi_<foo> seems to use acpi_string and char * somewhat
interchangeably.

It would also be good to standardize on one style.

For instance intel-hid.c has:

   static const char *intel_hid_dsm_fn_to_method[INTEL_HID_DSM_FN_MAX] = {
   	NULL,
   	"BTNL",
   	"HDMM",
   	"HDSM",
   	"HDEM",
   	"BTNS",
   	"BTNE",
   	"HEBC",
   	"VGBS",
   	"HEBC"
   };

   [...]

   static bool intel_hid_execute_method(acpi_handle handle,
   				     enum intel_hid_dsm_fn_codes fn_index,
   				     unsigned long long arg)
   {
   	union acpi_object *obj, argv4, req;
   	acpi_status status;
   	char *method_name;

   	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
   	    fn_index >= INTEL_HID_DSM_FN_MAX)
   		return false;

   	method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];

   [...]

where the const is cast away because

   skip_dsm_exec:
   	status = acpi_execute_simple_method(handle, method_name, arg);

here acpi_execute_simple_method takes a non-const acpi_string method_name.

   include/acpi/acpi_bus.h:acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
   include/acpi/acpi_bus.h-                                       u64 arg);

and the implementation in drivers/acpi/utils.c does not modify method

   acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
   				       u64 arg)
   {
   	union acpi_object obj = { .type = ACPI_TYPE_INTEGER };
   	struct acpi_object_list arg_list = { .count = 1, .pointer = &obj, };

   	obj.integer.value = arg;

   	return acpi_evaluate_object(handle, method, &arg_list, NULL);
   }
   EXPORT_SYMBOL(acpi_execute_simple_method);

and acpi_evaluate_object does not modify method either
but may assign it to another const char *relative_pathname

   acpi_status
   acpi_evaluate_object(acpi_handle handle,
   		     acpi_string pathname,
   		     struct acpi_object_list *external_params,
   		     struct acpi_buffer *return_buffer)

   {
   	[...]

   	info->relative_pathname = pathname;
