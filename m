From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 6/6] In Documentation/hw_random.txt
Date: Tue, 5 Mar 2013 16:23:28 +0800
Message-ID: <1362471808-9437-7-git-send-email-tangchen@cn.fujitsu.com>
References: <1362471808-9437-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362471808-9437-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trival@kernel.org
List-Id: linux-acpi@vger.kernel.org

Seeing from the comment, there are three reasons for removing request_mem_region.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 Documentation/hw_random.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/hw_random.txt b/Documentation/hw_random.txt
index 690f525..026e237 100644
--- a/Documentation/hw_random.txt
+++ b/Documentation/hw_random.txt
@@ -63,7 +63,7 @@ Intel RNG Driver notes:
 
 	* FIXME: support poll(2)
 
-	NOTE: request_mem_region was removed, for two reasons:
+	NOTE: request_mem_region was removed, for three reasons:
 	1) Only one RNG is supported by this driver, 2) The location
 	used by the RNG is a fixed location in MMIO-addressable memory,
 	3) users with properly working BIOS e820 handling will always
-- 
1.7.1
