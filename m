From: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
Subject: cleanups for acpi/battery.c
Date: Fri, 12 Jan 2018 15:58:43 +0200
Message-ID: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16942 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbeALN7W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 08:59:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com

This patch series does few cleanups in the file acpi/battery.c:
  ACPI / battery: drop inclusion of init.h
  ACPI / battery: reorder headers alphabetically
  ACPI / battery: use specialized print macros
  ACPI / battery: get rid of negations in conditions

  drivers/acpi/battery.c | 31 +++++++++++++++----------------
  1 file changed, 15 insertions(+), 16 deletions(-)

