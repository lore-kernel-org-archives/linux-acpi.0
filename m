From: Thomas Renninger <trenn@suse.de>
Subject: ACPI/cpuidle cleanups - Rename cpuidle states, cleanup idle= usage/processing
Date: Fri, 12 Nov 2010 18:02:11 +0100
Message-ID: <1289581334-26836-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34172 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757544Ab0KLRCR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Nov 2010 12:02:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, trenn@suse.de

Hi Len,

these are some not pressing cleanups.
It would be great to see them in your test branch.
I missed out (and won't send again) the idle=halt change in processor_idle.c
As you mentioned that x86 might always register for cpuidle, this change
would not make sense.

Compile tested, based on latest Linus tree.

Thanks,

      Thomas

