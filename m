From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] acpi: video: trivial cleanups
Date: Thu,  1 Aug 2013 18:43:58 -0500
Message-ID: <1375400641-1694-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

Here's a few patches to cleanup the code-style of acpi/video.c. Some were found
by checkpatch, and some just make sense.

Felipe Contreras (3):
  acpi: video: trivial costmetic cleanups
  acpi: video: trivial style cleanups
  acpi: video: remove unnecessary casting

 drivers/acpi/video.c | 210 +++++++++++++++++++++++++--------------------------
 1 file changed, 103 insertions(+), 107 deletions(-)

-- 
1.8.3.4
