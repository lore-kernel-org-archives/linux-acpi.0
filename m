From: akpm@linux-foundation.org
Subject: [patch 06/26] fujitsu-laptop: remove unnecessary input_free_device calls
Date: Tue, 20 Jul 2010 15:19:34 -0700
Message-ID: <201007202219.o6KMJY44021009@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54859 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932948Ab0GTWkg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, dtor@mail.ru, jwoithe@physics.adelaide.edu.au, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

input_free_device() should only be used if input_register_device() was not
called yet or if it failed.  This patch removes unnecessary
input_free_device calls.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Cc: Matthew Garrett <mjg@redhat.com>a
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/fujitsu-laptop.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-remove-unnecessary-input_free_device-calls drivers/platform/x86/fujitsu-laptop.c
--- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-remove-unnecessary-input_free_device-calls
+++ a/drivers/platform/x86/fujitsu-laptop.c
@@ -725,6 +725,7 @@ static int acpi_fujitsu_add(struct acpi_
 
 err_unregister_input_dev:
 	input_unregister_device(input);
+	input = NULL;
 err_free_input_dev:
 	input_free_device(input);
 err_stop:
@@ -738,8 +739,6 @@ static int acpi_fujitsu_remove(struct ac
 
 	input_unregister_device(input);
 
-	input_free_device(input);
-
 	fujitsu->acpi_handle = NULL;
 
 	return 0;
@@ -930,6 +929,7 @@ static int acpi_fujitsu_hotkey_add(struc
 
 err_unregister_input_dev:
 	input_unregister_device(input);
+	input = NULL;
 err_free_input_dev:
 	input_free_device(input);
 err_free_fifo:
@@ -953,8 +953,6 @@ static int acpi_fujitsu_hotkey_remove(st
 
 	input_unregister_device(input);
 
-	input_free_device(input);
-
 	kfifo_free(&fujitsu_hotkey->fifo);
 
 	fujitsu_hotkey->acpi_handle = NULL;
_
