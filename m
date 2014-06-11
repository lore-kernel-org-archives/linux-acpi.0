From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: New eMCA trace event interface V4
Date: Wed, 11 Jun 2014 21:33:05 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F3283268C@ORSMSX114.amr.corp.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8588 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaFKVdH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2014 17:33:07 -0400
In-Reply-To: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Let's try and close this out.

I made a branch in the ras git tree and applied the first few parts:

	git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git eMCA-trace

I took Boris' modified versions of parts 1 & 4, and his alternate hunk for part 2.
I also assumed no comment on part 3 to be assent, so applied that too.

Gong: when you see Boris' comments on part5 - you can just resend an update
based on the this tree.

-Tony
