From: akpm@linux-foundation.org
Subject: [patch 16/26] asus-laptop: fix incorrect return value for write_acpi_int_ret if handle is NULL
Date: Tue, 20 Jul 2010 15:19:47 -0700
Message-ID: <201007202219.o6KMJlaI021057@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, corentincj@iksaif.net, mjg@redhat.com
List-Id: linux-acpi@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>

According to the comments of write_acpi_int_ret(), write_acpi_int_ret()
should return 0 if write is successful, -1 else.  Thus if handle is NULL,
the write does not happen, it should return -1.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/asus-laptop.c~asus-laptop-fix-incorrect-return-value-for-write_acpi_int_ret-if-handle-is-null drivers/platform/x86/asus-laptop.c
--- a/drivers/platform/x86/asus-laptop.c~asus-laptop-fix-incorrect-return-value-for-write_acpi_int_ret-if-handle-is-null
+++ a/drivers/platform/x86/asus-laptop.c
@@ -297,7 +297,7 @@ static int write_acpi_int_ret(acpi_handl
 	acpi_status status;
 
 	if (!handle)
-		return 0;
+		return -1;
 
 	params.count = 1;
 	params.pointer = &in_obj;
_
