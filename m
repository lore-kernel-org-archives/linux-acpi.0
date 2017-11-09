From: Kiernan Hager <kiernan.hager@gmail.com>
Subject: [PATCH] Fix the ambient light sensor on Zenbook UX430UQ
Date: Thu, 9 Nov 2017 13:47:45 -0700
Message-ID: <CANDLvR4Ju1uzn4ncq=ErRs+-jDyDxbpgBASAsjoT-C5w91Zc1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:56711 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbdKIUsG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2017 15:48:06 -0500
Received: by mail-qt0-f174.google.com with SMTP id z28so9346000qtz.13
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2017 12:48:06 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently discovered that the acpi-als driver doesn't properly
activate the ambient light sensor in this laptop. The sensor begins in
the off state, and gives a constant brightness value of 0x190 when
queried. The solution is to call the \_SB.PCI0.LPCB.EC0.ALSC method
with an integer argument of 1 when the module is loaded. I have a
patch for this, but I don't know if what it does constitutes proper
testing for the presence of that method, or if I should disable the
sensor when the module is unloaded, so input is welcome on those
details.

--- acpi-als.c.orig 2017-11-09 13:29:43.346699941 -0700
+++ acpi-als.c 2017-11-09 13:35:21.708579014 -0700
@@ -180,6 +180,11 @@
  struct acpi_als *als;
  struct iio_dev *indio_dev;
  struct iio_buffer *buffer;
+    unsigned long long temp_val;
+    acpi_status status;
+    struct acpi_object_list arg_list;
+    union acpi_object arg;
+

  indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
  if (!indio_dev)
@@ -204,6 +209,18 @@

  iio_device_attach_buffer(indio_dev, buffer);

+    arg_list.count = 1;
+    arg_list.pointer = &arg;
+    arg.type = ACPI_TYPE_INTEGER;
+    arg.integer.value = 1;
+
+    if (acpi_has_method(als->device->handle, "\\_SB.PCI0.LPCB.EC0.ALSC")) {
+    status = acpi_evaluate_integer(als->device->handle,
+                                   "\\_SB.PCI0.LPCB.EC0.ALSC",
+                                   &arg_list,
+                                   &temp_val);
+    }
+
  return devm_iio_device_register(&device->dev, indio_dev);
 }
