From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/3] ACPI / video: move video_extension.txt to Documentation/acpi
Date: Thu, 20 Jun 2013 15:08:56 +0800
Message-ID: <1371712137-4019-3-git-send-email-aaron.lu@intel.com>
References: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42935 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab3FTHIf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 03:08:35 -0400
In-Reply-To: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Micael Dias <kam1kaz3@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

ACPI video driver is written according to ACPI spec, appendix B: Video
Extensions. So it better be put under the acpi directory instead of the
power directory. This patch moves the file there without any other
change.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 Documentation/{power => acpi}/video_extension.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{power => acpi}/video_extension.txt (100%)

diff --git a/Documentation/power/video_extension.txt b/Documentation/acpi/video_extension.txt
similarity index 100%
rename from Documentation/power/video_extension.txt
rename to Documentation/acpi/video_extension.txt
-- 
1.8.3.3.gfada522

