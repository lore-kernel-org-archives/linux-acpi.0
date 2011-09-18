From: Jim Green <student.northwestern@gmail.com>
Subject: bug report: ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
Date: Sun, 18 Sep 2011 13:18:44 -0400
Message-ID: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52888 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab1IRRSp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Sep 2011 13:18:45 -0400
Received: by gyg10 with SMTP id 10so3661207gyg.19
        for <linux-acpi@vger.kernel.org>; Sun, 18 Sep 2011 10:18:45 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello:

I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
version 1702, latest stable)

2357 Sep 18 13:05:07 localhost kernel: [    1.045727] ACPI: EC: Look
up EC in DSDT
2358 Sep 18 13:05:07 localhost kernel: [    1.046535] ACPI: Executed 1
blocks of module-level executable AML code
2359 Sep 18 13:05:07 localhost kernel: [    1.049876] ACPI Error:
[RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
2360 Sep 18 13:05:07 localhost kernel: [    1.049880] ACPI Exception:
AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
(20110112/         nsinit-349)
2361 Sep 18 13:05:07 localhost kernel: [    1.050347] ACPI: SSDT
00000000df5d4818 0079C (v01    AMI      IST 00000001 MSFT 03000001)
2362 Sep 18 13:05:07 localhost kernel: [    1.050805] ACPI: Dynamic
OEM Table Load:
2363 Sep 18 13:05:07 localhost kernel: [    1.050807] ACPI: SSDT
    (null) 0079C (v01    AMI      IST 00000001 MSFT 03000001)
2364 Sep 18 13:05:07 localhost kernel: [    1.050883] ACPI: SSDT
00000000df5dba18 0021C (v01    AMI      CST 00000001 MSFT 03000001)
2365 Sep 18 13:05:07 localhost kernel: [    1.051168] ACPI: Dynamic
OEM Table Load:
2366 Sep 18 13:05:07 localhost kernel: [    1.051169] ACPI: SSDT
    (null) 0021C (v01    AMI      CST 00000001 MSFT 03000001)
2367 Sep 18 13:05:07 localhost kernel: [    1.052510] ACPI: Interpreter enabled
2368 Sep 18 13:05:07 localhost kernel: [    1.052512] ACPI: (supports
S0 S1 S3 S4 S5)
2369 Sep 18 13:05:07 localhost kernel: [    1.052530] ACPI: Using
IOAPIC for interrupt routing

Could anyone help how to fix this error?.. is this bug fixed in some
later kernel versions?

Thank you very much!

Jim.
