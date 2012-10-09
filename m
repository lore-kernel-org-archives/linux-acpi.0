From: Len Brown <lenb@kernel.org>
Subject: ACPI & Thermal patches for Linux-3.7-merge
Date: Tue,  9 Oct 2012 01:53:50 -0400
Message-ID: <1349762060-25334-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50042 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab2JIGCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 02:02:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Here is my 3.7 queue of Thermal pathces (from Zhang-Rui's release tree)
plus a few misc fixes.  I fixed two merge issues when pulling rui's tree,
the TC1/TC2 vs OMAP and the MAX_IDR_MASK rename issue.

Please let me know if you see troubles with any of these patches,
they are currently on my "next" branch.

thanks,
Len Brown, Intel Open Source Technology Center

