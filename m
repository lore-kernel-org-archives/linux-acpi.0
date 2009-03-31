From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Wed, 1 Apr 2009 00:02:17 +0100
Message-ID: <20090331230217.GA31599@srcf.ucam.org>
References: <20090331214501.GC29489@srcf.ucam.org> <20090331214749.GD29489@srcf.ucam.org> <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com> <20090331221107.GA30383@srcf.ucam.org> <74962ea30903311519s2fb6087fxfe8859e3c570ac99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764327AbZCaXCw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74962ea30903311519s2fb6087fxfe8859e3c570ac99@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Azael Avalos <coproscefalo@gmail.com>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Ok, can you try this and let me know what codes it generates (if it 
generates any)? It should go on top of the previous patches.

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 9fb4873..8552e1a 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -185,7 +185,6 @@ static int write_acpi_int(const char *methodName, int val)
 	return (status == AE_OK);
 }
 
-#if 0
 static int read_acpi_int(const char *methodName, int *pVal)
 {
 	struct acpi_buffer results;
@@ -200,7 +199,6 @@ static int read_acpi_int(const char *methodName, int *pVal)
 
 	return (status == AE_OK) && (out_objs[0].type == ACPI_TYPE_INTEGER);
 }
-#endif
 
 static const char *method_hci /*= 0*/ ;
 
@@ -802,6 +800,13 @@ static void toshiba_acpi_notify(acpi_handle handle, u32 event, void **data)
 
 	if (event != 0x80)
 		return;
+
+	if (is_valid_acpi_path(TOSH_INTERFACE_2 SPFC_METHOD)) {
+		read_acpi_int(TOSH_INTERFACE_2 SPFC_METHOD, &value);
+		printk("Received 0x%x\n", value);
+		return;
+	}
+
 	do {
 		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
 		if (hci_result == HCI_SUCCESS) {

-- 
Matthew Garrett | mjg59@srcf.ucam.org
