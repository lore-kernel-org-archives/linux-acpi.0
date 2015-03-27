From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 0/5] GHES NMI handler cleanup
Date: Fri, 27 Mar 2015 10:22:53 +0100
Message-ID: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58640 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbbC0JYu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Mar 2015 05:24:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

So this patchset is the result of us seeing this while debugging a
customer issue:

[  118.113136] INFO: NMI handler (ghes_notify_nmi) took too long to run: 1.005 msecs

Looking at that NMI handler, it could use a good scrubbing as it has
grown some needless fat. So let's try it.

First 4 patches simplify it and clean it, and the last one does the
bold move of making the status reader CPU be a single one based on
the not-100-percent-confirmed observation that GHES error sources are
global in the firmware glue and thus only one reader suffices to see all
errors.

This last thing still needs to be confirmed but I'm sending the patches
now so that people can look at them and poke holes. Thus the RFC tag.

Thanks.

Borislav Petkov (4):
  GHES: Carve out error queueing in a separate function
  GHES: Carve out the panic functionality
  GHES: Panic right after detection
  GHES: Elliminate double-loop in the NMI handler

Jiri Kosina (1):
  GHES: Make NMI handler have a single reader

 drivers/acpi/apei/ghes.c | 108 ++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

-- 
2.3.3

