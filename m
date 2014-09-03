From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v4 0/4] PCC: Platform Communication Channel
Date: Wed,  3 Sep 2014 15:38:55 -0400
Message-ID: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:33875 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751AbaICTjJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 15:39:09 -0400
Received: by mail-yh0-f48.google.com with SMTP id b6so5595470yha.35
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 12:39:08 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

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


Ashwin Chaugule (4):
  Mailbox: Prepare to add PCC Mailbox support
  Mailbox: Add PCC Mailbox Helper functions
  Mailbox: Add support for Platform Communication Channel
  PCC test

 drivers/mailbox/Kconfig            |  19 +++
 drivers/mailbox/Makefile           |   4 +
 drivers/mailbox/mailbox.c          |  10 +-
 drivers/mailbox/pcc-test.c         | 208 +++++++++++++++++++++++++++++++
 drivers/mailbox/pcc.c              | 245 +++++++++++++++++++++++++++++++++++++
 drivers/mailbox/pcc_mailbox.c      | 136 ++++++++++++++++++++
 include/linux/mailbox_controller.h |   4 +
 7 files changed, 619 insertions(+), 7 deletions(-)
 create mode 100644 drivers/mailbox/pcc-test.c
 create mode 100644 drivers/mailbox/pcc.c
 create mode 100644 drivers/mailbox/pcc_mailbox.c

-- 
1.9.1

