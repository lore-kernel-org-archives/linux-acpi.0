From: Colin King <colin.king@canonical.com>
Subject: [PATCH 0/5] remove some unnecessary newline from error messages
Date: Thu, 29 Nov 2012 11:53:11 +0000
Message-ID: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35015 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab2K2LxV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Nov 2012 06:53:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The ACPI_EXCEPTION and ACPI_ERROR macros already emit a newline after
the message, so remove the unnecessary newlines from a bunch of messages.

Colin Ian King (5):
  ACPI dock: remove unnecessary newline from exception message
  ACPI video: remove unnecessary newline from error messages
  ACPI sysfs: remove unnecessary newline from exception
  ACPICA: GPE support: remove unnecessary newline from error messages
  ACPI thermal: remove unnecessary newline from exception message

 drivers/acpi/acpica/hwgpe.c | 2 +-
 drivers/acpi/dock.c         | 2 +-
 drivers/acpi/sysfs.c        | 2 +-
 drivers/acpi/thermal.c      | 2 +-
 drivers/acpi/video.c        | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.0

