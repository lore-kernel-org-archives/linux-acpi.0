From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2] ACPI: remove _GTS/_BFS support
Date: Thu, 26 Jul 2012 20:34:47 -0400
Message-ID: <1343349289-31179-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64504 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2G0AfA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 20:35:00 -0400
Received: by vbbff1 with SMTP id ff1so2252729vbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 17:34:59 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, x86@kernel.org

Here's a pair of patches to remove  _GTS/_BFS support --
something that we've wanted to do for a while.

Justification is in the commit log of 2/2.
Let me know if you se any troubles with the pair.

thanks,
Len Brown, Intel Open Source Technology Center

