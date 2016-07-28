From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/6] efi: Retrieve Apple device properties
Date: Thu, 28 Jul 2016 02:25:41 +0200
Message-ID: <833d193b8a18b0afe168c515e9e56a857ece4bd1.1469616641.git.lukas__45216.2381182008$1469665581$gmane$org@wunner.de>
References: <cover.1469616641.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:36529 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162468AbcG1A0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2016 20:26:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout3.hostsharing.net (Postfix) with ESMTPS id F1B26101E4767
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:03 +0200 (CEST)
Received: from localhost (4-38-90-81.adsl.cmo.de [81.90.38.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id CB860609763D
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:00 +0200 (CEST)
In-Reply-To: <cover.1469616641.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-efi@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, Pierre Moreau <pierre.morrow@free.fr>, reverser@put.as, grub-devel@gnu.org, x86@kernel.org, linux-acpi@vger.kernel.org

Retrieve device properties from EFI using Apple's proprietary protocol
with GUID 91BD12FE-F6C3-44FB-A5B7-5122AB303AE0, which looks like this:

typedef struct {
	unsigned long signature; /* 0x10000 */
	efi_status_t (*get) (
		IN struct apple_properties_protocol *this,
		IN struct efi_generic_dev_path *device,
		IN efi_char16_t *property_name,
		OUT void *buffer,
		IN OUT u32 *buffer_size);
		/* EFI_SUCCESS, EFI_NOT_FOUND, EFI_BUFFER_TOO_SMALL */
	efi_status_t (*set) (
		IN struct apple_properties_protocol *this,
		IN struct efi_generic_dev_path *device,
		IN efi_char16_t *property_name,
		IN void *property_value,
		IN u32 property_value_len);
		/* allocates copies of property name and value */
		/* EFI_SUCCESS, EFI_OUT_OF_RESOURCES */
	efi_status_t (*del) (
		IN struct apple_properties_protocol *this,
		IN struct efi_generic_dev_path *device,
		IN efi_char16_t *property_name);
		/* EFI_SUCCESS, EFI_NOT_FOUND */
	efi_status_t (*get_all) (
		IN struct apple_properties_protocol *this,
		OUT void *buffer,
		IN OUT u32 *buffer_size);
		/* EFI_SUCCESS, EFI_BUFFER_TOO_SMALL */
} apple_properties_protocol;

Apple's EFI driver implementing this protocol, "AAPL,PathProperties",
is a per-device key/value store which is populated by other EFI drivers.
On macOS, these device properties are retrieved by the bootloader
/usr/standalone/i386/boot.efi. The extension AppleACPIPlatform.kext
subsequently merges them into the I/O Kit registry (see ioreg(8)) where
they can be queried by other kernel extensions and user space.

These device properties contain vital information which cannot be
obtained any other way (e.g. Thunderbolt Device ROM). EFI drivers also
use them to communicate the current device state so that OS drivers can
pick up where EFI drivers left (e.g. GPU mode setting).

The get_all() function conveniently fills a buffer with all properties
in marshalled form which can be passed to the kernel as a setup_data
payload. Note that the device properties will only be available if the
kernel is booted with the efistub. Distros should adjust their
installers to always use the efistub on Macs. grub with the "linux"
directive will not work unless the functionality of this commit is
duplicated in grub. (The "linuxefi" directive should work but is not
included upstream as of this writing.)

Thanks to osxreverser for this blog posting which was helpful in reverse
engineering Apple's EFI drivers and bootloader:
https://reverse.put.as/2016/06/25/apple-efi-firmware-passwords-and-the-scbo-myth/

If someone at Apple is reading this, please note there's a memory leak
in your implementation of the del() function as the property struct is
freed but the name and value allocations are not.

Cc: reverser@put.as
Cc: grub-devel@gnu.org
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andreas Noever <andreas.noever@gmail.com>
Tested-by: Lukas Wunner <lukas@wunner.de> [MacBookPro9,1]
Tested-by: Pierre Moreau <pierre.morrow@free.fr> [MacBookPro11,3]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/x86/boot/compressed/eboot.c      | 55 +++++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 include/linux/efi.h                   | 17 +++++++++++
 3 files changed, 73 insertions(+)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index ff574da..7262ee4 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -571,6 +571,55 @@ free_handle:
 	efi_call_early(free_pool, pci_handle);
 }
 
+static void retrieve_apple_device_properties(struct boot_params *params)
+{
+	efi_guid_t guid = APPLE_PROPERTIES_PROTOCOL_GUID;
+	struct setup_data *data, *new;
+	efi_status_t status;
+	void *properties;
+	u32 size = 0;
+
+	status = efi_early->call(
+			(unsigned long)sys_table->boottime->locate_protocol,
+			&guid, NULL, &properties);
+	if (status != EFI_SUCCESS)
+		return;
+
+	do {
+		status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+			size + sizeof(struct setup_data), &new);
+		if (status != EFI_SUCCESS) {
+			efi_printk(sys_table,
+				   "Failed to alloc mem for properties\n");
+			return;
+		}
+		status = efi_early->call(efi_early->is64 ?
+			((apple_properties_protocol_64 *)properties)->get_all :
+			((apple_properties_protocol_32 *)properties)->get_all,
+			properties, new->data, &size);
+		if (status == EFI_BUFFER_TOO_SMALL)
+			efi_call_early(free_pool, new);
+	} while (status == EFI_BUFFER_TOO_SMALL);
+
+	if (!size) {
+		efi_call_early(free_pool, new);
+		return;
+	}
+
+	new->type = SETUP_APPLE_PROPERTIES;
+	new->len  = size;
+	new->next = 0;
+
+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
+	if (!data)
+		params->hdr.setup_data = (unsigned long)new;
+	else {
+		while (data->next)
+			data = (struct setup_data *)(unsigned long)data->next;
+		data->next = (unsigned long)new;
+	}
+}
+
 static efi_status_t
 setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 {
@@ -1098,6 +1147,7 @@ free_mem_map:
 struct boot_params *efi_main(struct efi_config *c,
 			     struct boot_params *boot_params)
 {
+	efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
 	struct desc_ptr *gdt = NULL;
 	efi_loaded_image_t *image;
 	struct setup_header *hdr = &boot_params->hdr;
@@ -1128,6 +1178,11 @@ struct boot_params *efi_main(struct efi_config *c,
 
 	setup_efi_pci(boot_params);
 
+	if (!memcmp((void *)sys_table->fw_vendor, apple, sizeof(apple))) {
+		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
+			retrieve_apple_device_properties(boot_params);
+	}
+
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
 				sizeof(*gdt), (void **)&gdt);
 	if (status != EFI_SUCCESS) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index c18ce67..b10bf31 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -7,6 +7,7 @@
 #define SETUP_DTB			2
 #define SETUP_PCI			3
 #define SETUP_EFI			4
+#define SETUP_APPLE_PROPERTIES		5
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7f80a75..e53b4b2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -432,6 +432,22 @@ typedef struct {
 #define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO_16 0x20000
 #define EFI_PCI_IO_ATTRIBUTE_VGA_IO_16 0x40000
 
+typedef struct {
+	u32 signature;
+	u32 get;
+	u32 set;
+	u32 del;
+	u32 get_all;
+} apple_properties_protocol_32;
+
+typedef struct {
+	u64 signature;
+	u64 get;
+	u64 set;
+	u64 del;
+	u64 get_all;
+} apple_properties_protocol_64;
+
 /*
  * Types and defines for EFI ResetSystem
  */
@@ -580,6 +596,7 @@ void efi_native_runtime_setup(void);
 #define EFI_RNG_PROTOCOL_GUID			EFI_GUID(0x3152bca5, 0xeade, 0x433d,  0x86, 0x2e, 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
 #define EFI_MEMORY_ATTRIBUTES_TABLE_GUID	EFI_GUID(0xdcfa911d, 0x26eb, 0x469f,  0xa2, 0x20, 0x38, 0xb7, 0xdc, 0x46, 0x12, 0x20)
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
+#define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.8.1

