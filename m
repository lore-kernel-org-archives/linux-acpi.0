From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ACPI: Adjustments for six function implementations
Date: Fri, 29 Sep 2017 22:15:39 +0200
Message-ID: <267c842c-d38a-67be-f61b-a2056f7e71ee@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:50110 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbdI2UPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Sep 2017 16:15:55 -0400
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Sep 2017 22:10:22 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in five functions
  scan: Improve a size determination in three functions

 drivers/acpi/acpi_platform.c |  1 -
 drivers/acpi/acpi_video.c    |  1 -
 drivers/acpi/ioapic.c        |  1 -
 drivers/acpi/scan.c          | 11 ++++-------
 4 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.14.2

