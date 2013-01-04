From: Yinghai Lu <yinghai@kernel.org>
Subject: acpi debug changes cause compiling error
Date: Fri, 4 Jan 2013 14:53:24 -0800
Message-ID: <CAE9FiQWgjfHBHfaqHecJcB_NRa3dC0sm=Vug7FZkA=-jCv=j0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:59991 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab3ADWx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2013 17:53:26 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so7438165bkc.21
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jan 2013 14:53:24 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

drivers/acpi/processor_driver.c: In function =91acpi_processor_get_info=
=92:
drivers/acpi/processor_driver.c:351:2: error: =91else=92 without a prev=
ious =91if=92
drivers/acpi/processor_driver.c: In function =91is_processor_present=92=
:
drivers/acpi/processor_driver.c:674:2: error: =91else=92 without a prev=
ious =91if=92
make[1]: *** [drivers/acpi/processor_driver.o] Error 1
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
