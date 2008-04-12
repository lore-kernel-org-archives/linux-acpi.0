From: Len Brown <lenb@kernel.org>
Subject: ACPICA branch
Date: Sat, 12 Apr 2008 00:24:43 -0400
Message-ID: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933AbYDLE1z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Back, by popular demand, after too long a delay...
is a an "acpica" branch in the linux-acpi git tree.

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica

This is where the ACPICA core interpreter update to Linux
shall live until it is regression free and ready to
merge into the acpi test branch (and mm).

There are some known issues with the series,
and we'll discuss those issues on the list.

But for now, to set the baseline, here is a patch bomb
showing the current contents of the series.
Thanks to Lin-Ming and Bob Moore for developing most
of the patches, and thanks to Alexey Starikovskiy
for helping merge them up to the latest tree.

-Len


