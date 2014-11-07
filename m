From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v10 0/1] PCC: Platform Communication Channel
Date: Fri,  7 Nov 2014 09:52:43 -0500
Message-ID: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:59666 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaKGOw6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2014 09:52:58 -0500
Received: by mail-yk0-f173.google.com with SMTP id 20so2343805yks.18
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2014 06:52:57 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jaswinder.singh@linaro.org
Cc: broonie@kernel.org, lv.zheng@intel.com, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, arnd@arndb.de, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Changes since V9:
- Default to PCC subspace headers as defined in ACPI v5.1

Changes since V8:
- Removed unncessary header files.
- Added kerneldoc comments.
- Added intro about PCC in pcc.c

Changes since V7:
- Added timeout to tx method in case the remote dies.
- Restructured usage of acpi_status. Had inverted logic previously.

Changes since V6:
- Cosmetic changes based on Lv's suggestions

Changes since V5:
- Optimize loop that matches channel request.
- Use platform_create_bundle.
- Replace ioread/writes.
- Remove redundant code and headers.
- Restructure common mailbox macros.
- Reformat PCC cmd parsing.

Changes since V4:
- Folded PCC Mailbox helpers into pcc.c

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



Ashwin Chaugule (1):
  Mailbox: Add support for Platform Communication Channel

 drivers/mailbox/Kconfig   |  12 ++
 drivers/mailbox/Makefile  |   2 +
 drivers/mailbox/mailbox.c |   4 +-
 drivers/mailbox/mailbox.h |  16 ++
 drivers/mailbox/pcc.c     | 367 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 398 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mailbox/mailbox.h
 create mode 100644 drivers/mailbox/pcc.c

-- 
1.9.1

