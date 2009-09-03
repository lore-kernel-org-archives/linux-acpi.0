From: Lin Ming <lin@minggr.cn>
Subject: als driver build error
Date: Thu, 3 Sep 2009 11:06:03 +0800
Message-ID: <d3f22a0909022006v64473b58l231e9a7213f2e834@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:59470 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZICDGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Sep 2009 23:06:02 -0400
Received: by pzk42 with SMTP id 42so1224592pzk.19
        for <linux-acpi@vger.kernel.org>; Wed, 02 Sep 2009 20:06:03 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

drivers/acpi/als.c: In function =91acpi_als_get_mappings=92:
drivers/acpi/als.c:173: error: expected =91)=92 before =91PREFIX=92
drivers/acpi/als.c: In function =91acpi_als_add=92:
drivers/acpi/als.c:347: error: expected =91)=92 before =91PREFIX=92
make[2]: *** [drivers/acpi/als.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/acpi] Error 2
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
