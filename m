From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v6 0/2] PCC: Platform Communication Channel
Date: Thu,  4 Sep 2014 14:49:19 -0400
Message-ID: <1409856561-3945-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63392 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaIDStf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 14:49:35 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so20529257pab.28
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 11:49:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Changes since V5:
-	Optimize loop that matches channel request.
-	Use platform_create_bundle.
-	Replace ioread/writes.
-	Remove redundant code and headers.
-	Restructure common mailbox macros.
-	Reformat PCC cmd parsing.

Changes since V4:
-	Folded PCC Mailbox helpers into pcc.c

Changes since V3:
- Added PCC helper functions to work around "struct device" limitations.
- PCC driver changes to work with PCC specific Mailbox helpers.

Changes since V2:
- Rebased on top of git://git.linaro.org/landing-teams/working/fujitsu/integration.git 
	branch mailbox-for-3.17
- Added PCC API to mailbox framework as per Arnd's suggestion to allow usage without ACPI.

Changes since V1:
- Integration with Mailbox framework - https://lkml.org/lkml/2014/5/15/49

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


Ashwin Chaugule (2):
  Mailbox: Add support for Platform Communication Channel
  PCC test

 drivers/mailbox/Kconfig    |  12 ++
 drivers/mailbox/Makefile   |   2 +
 drivers/mailbox/mailbox.c  |   4 +-
 drivers/mailbox/mailbox.h  |  16 +++
 drivers/mailbox/pcc-test.c | 203 +++++++++++++++++++++++++++++++++
 drivers/mailbox/pcc.c      | 279 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 513 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mailbox/mailbox.h
 create mode 100644 drivers/mailbox/pcc-test.c
 create mode 100644 drivers/mailbox/pcc.c

-- 
1.9.1

