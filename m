From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 00/12] ACPI: constify patches and other minor fixes
Date: Sat, 13 Jun 2015 14:26:48 +0200
Message-ID: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36588 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbFMM1N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:13 -0400
Received: by wigg3 with SMTP id g3so36841722wig.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:11 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Hi Rafael, Len,

this series constifies a few variables in the ACPI code that are read
only and therefore can be const. The main goal is to constify all users
of struct acpi_device_id, but while digging through the code I found a
few other places that could be improved too (constifying other variables
in patches 1, 2, 4 and 9 as adding __init annotations where sensible in
patch 7 or dropping bogus annotations in patch 3).

This series only handles the ACPI related bits for the constification of
struct acpi_device_id but all other users have been changed too (you've
been Cc'ed on the corresponding patches).

Please apply!


Mathias Krause (12):
  ACPI / AC: constify DMI system id table
  ACPI / LPSS: constify device descriptors
  ACPI / processor: remove bogus __refdata annotation
  ACPI / PNP: constify device IDs
  ACPI / battery: constify the offset tables
  ACPI / battery: minor tweaks to acpi_battery_units()
  ACPI / battery: mark DMI table as __initconst
  ACPI / HED: constify ACPI device ids
  ACPI / processor: constify DMI system id table
  ACPI / scan: constify ACPI device ids
  ACPI / video: constify ACPI and DMI id tables
  ACPI: Constify ACPI device IDs in documentation

 Documentation/acpi/enumeration.txt |    6 +++---
 drivers/acpi/ac.c                  |    2 +-
 drivers/acpi/acpi_lpss.c           |   22 +++++++++++-----------
 drivers/acpi/acpi_pnp.c            |    2 +-
 drivers/acpi/acpi_processor.c      |    2 +-
 drivers/acpi/battery.c             |   30 +++++++++++++++---------------
 drivers/acpi/hed.c                 |    2 +-
 drivers/acpi/processor_idle.c      |    2 +-
 drivers/acpi/scan.c                |    2 +-
 drivers/acpi/video_detect.c        |    4 ++--
 10 files changed, 37 insertions(+), 37 deletions(-)

-- 
1.7.10.4

