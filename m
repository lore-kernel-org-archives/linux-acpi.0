From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v3 0/3] PCC: Platform Communication Channel
Date: Tue, 26 Aug 2014 15:35:35 -0400
Message-ID: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:36690 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbaHZTgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Aug 2014 15:36:31 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so14347032qaq.13
        for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2014 12:36:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org

This patchset adds support for the PCC (Platform Communication Channel)
interface as described in the current ACPI 5.0 spec. See Section 14 of the
ACPI spec - http://acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf for more details
on how PCC works.

In brief PCC is a generic means for PCC clients, to talk to the firmware. The
PCC register space is typically memory mapped IO and uses a doorbell mechanism
to communicate synchronously from the OS to the firmware. The PCC driver is
completely agnostic to the protocol implemented by the PCC clients. It only
implements the enumeration of PCC channels and the low level transport mechanism
and leaves the rest to the PCC clients.

The PCC is meant to be useable in the future by clients such as CPPC
(Collaborative Processor Performance Control), RAS (Reliability,
Availability and Serviceability) and MPST (Memory Power State Tables) and possibly others.


Changes since V2:
- Rebased on top of git://git.linaro.org/landing-teams/working/fujitsu/integration.git 
	branch mailbox-for-3.17
- Added PCC API to mailbox framework as per Arnd's suggestion to allow usage without ACPI.

Changes since V1:
-Integration with Mailbox framework - https://lkml.org/lkml/2014/5/15/49

Ashwin Chaugule (3):
  Mailbox: Add support for PCC mailbox and channels
  Add support for Platform Communication Channel
  PCC-test: Test driver to trigger PCC commands

 drivers/mailbox/Kconfig            |  12 ++
 drivers/mailbox/Makefile           |   2 +
 drivers/mailbox/mailbox.c          | 118 +++++++++++++++++--
 drivers/mailbox/pcc-test.c         | 208 +++++++++++++++++++++++++++++++++
 drivers/mailbox/pcc.c              | 228 +++++++++++++++++++++++++++++++++++++
 include/linux/mailbox_client.h     |   6 +
 include/linux/mailbox_controller.h |   1 +
 7 files changed, 568 insertions(+), 7 deletions(-)
 create mode 100644 drivers/mailbox/pcc-test.c
 create mode 100644 drivers/mailbox/pcc.c

-- 
1.9.1

