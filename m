From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] Update documentation for parameter *notrigger* in
 einj.txt
Date: Fri, 17 Feb 2012 18:27:53 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F03CAB8@ORSMSX104.amr.corp.intel.com>
References: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
 <1329462665-4040-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19889 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab2BQS15 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2012 13:27:57 -0500
In-Reply-To: <1329462665-4040-2-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

+- notrigger
+  This file is used to set whether or not exectuing trigger action by
+  the user. When set to 1, it means trigger action is executed by
+  the user, otherwise the trigger action is executed by the kernel.
+  It is useful when injecting one SRAR in the user context situation.
+

You hid the "this might not work in your BIOS" part up in the commit
message - which is harder for someone to track down and read than this
Documentation file.
 
How about:

notrigger
The EINJ mechanism is a two step process. First inject the error, then
perform some action to trigger it. Setting "notrigger" to 1 skips the
trigger phase, which *may* allow the user to cause the error in some other
context by a simple access to the cpu, memory location, or device that is
the target of the error injection. Whether this actually works depends
on what operations the BIOS actually includes in the trigger phase.


-Tony

