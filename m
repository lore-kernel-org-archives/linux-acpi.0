From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 0/1] Fix NULL pointer dereference in ACPI tables parsing code
Date: Thu, 18 Aug 2016 16:36:36 -0400
Message-ID: <1471552597-27909-1-git-send-email-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33599 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbcHSA7l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2016 20:59:41 -0400
Received: by mail-qk0-f196.google.com with SMTP id n66so114793qkf.0
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2016 17:59:40 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>

Hello ACPI gurus,

I'm experiencing a NULL pointer dereference on acpi_ds_load1_begin_op() from
drivers/acpi/acpica/dswload.c, when running on a Acer Aspire E14 ES1-432-P06A
laptop. Before the kernel panic stack trace, I see the following warnings and
error (sorry for any typos, as I had to manually type this):

ACPI Core revision 20160422
ACPI Warning: Unsupported module-level executable opcode 0x80 at table offset 0x0190 (20160422/psloop-222)
ACPI Warning: Unsupported module-level executable opcode 0x80 at table offset 0x0196 (20160422/psloop-222)
ACPI Error: Unknown opcode 0x03 at table offset 0x0171, ignoring (20160422/psobject-108)

I'm not exactly sure how to map these addresses to the DSDT ASL code, so any
suggestions in that direction or to better understand the whole picture are
appreciated. The disassembled DSDT can be found here:
https://gist.github.com/jprvita/c6373856f6672a06b9031c67e2980bdd, and I can
provide the binary tables if necessary.

The following patch fixes the NULL pointer dereference, and things seem to be
working normally.

João Paulo Rechi Vita (1):
  acpi: Check walk_state->scope_info before dereferencing

 drivers/acpi/acpica/dswload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.8.1

