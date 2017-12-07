From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 1/3] x86/boot: add acpi rsdp address to setup_header
Date: Thu,  7 Dec 2017 13:28:19 +0100
Message-ID: <20171207122821.30158-2-jgross@suse.com>
References: <20171207122821.30158-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207122821.30158-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>
List-Id: linux-acpi@vger.kernel.org

Xen PVH guests receive the address of the RSDP table from Xen. In order
to support booting a Xen PVH guest via grub2 using the standard x86
boot entry we need a way fro grub2 to pass the RSDP address to the
kernel.

For this purpose expand the struct setup_header to hold the physical
address of the RSDP address. Being zero means it isn't specified and
has to be located the legacy way (searching through low memory or
EBDA).

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 Documentation/x86/boot.txt            | 19 +++++++++++++++++++
 arch/x86/boot/header.S                |  6 +++++-
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index 5e9b826b5f62..a33c224797e4 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -61,6 +61,13 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
 	 	to struct boot_params for loading bzImage and ramdisk
 		above 4G in 64bit.
 
+Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
+		xloadflags to support booting a 64 bit kernel from 32 bit
+		EFI
+
+Protocol 2.14	(Kernel 4.16) Added acpi_rsdp_addr holding the physical
+		address of the ACPI RSDP table.
+
 **** MEMORY LAYOUT
 
 The traditional memory map for the kernel loader, used for Image or
@@ -197,6 +204,7 @@ Offset	Proto	Name		Meaning
 0258/8	2.10+	pref_address	Preferred loading address
 0260/4	2.10+	init_size	Linear memory required during initialization
 0264/4	2.11+	handover_offset	Offset of handover entry point
+0268/8	2.14+	acpi_rsdp_addr	Physical address of RSDP table
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
@@ -744,6 +752,17 @@ Offset/size:	0x264/4
 
   See EFI HANDOVER PROTOCOL below for more details.
 
+Field name:	acpi_rsdp_addr
+Type:		write
+Offset/size:	0x268/8
+Protocol:	2.14+
+
+  This field can be set by the boot loader to tell the kernel the
+  physical address of the ACPI RSDP table.
+
+  A value of 0 indicates the kernel should fall back to the standard
+  methods to locate the RSDP (search in EBDA/low memory).
+
 
 **** THE IMAGE CHECKSUM
 
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..e7184127f309 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020d		# header version number (>= 0x0105)
+		.word	0x020e		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
@@ -558,6 +558,10 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
 
+acpi_rsdp_addr:		.quad 0			# 64-bit physical pointer to
+						# ACPI RSDP table, added with
+						# version 2.14
+
 # End of setup header #####################################################
 
 	.section ".entrytext", "ax"
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index afdd5ae0fcc4..5742e433e93e 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -85,6 +85,7 @@ struct setup_header {
 	__u64	pref_address;
 	__u32	init_size;
 	__u32	handover_offset;
+	__u64	acpi_rsdp_addr;
 } __attribute__((packed));
 
 struct sys_desc_table {
-- 
2.12.3
