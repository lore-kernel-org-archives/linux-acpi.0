From: Len Brown <len.brown@intel.com>
Subject: ACPI Thermal workaround hooks
Date: Thu,  9 Aug 2007 01:58:50 -0400
Message-ID: <11866391363162-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23487 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbXHIF65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:58:57 -0400
In-Reply-To: 11866388361593-git-send-email-len.brown@intel.com
References: 11866388361593-git-send-email-len.brown@intel.com
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

In response to the outcry after I deleted the trip-point
overrides, here is how I think we can work-around
thermal issues in a supportable way.

In particular, this series should address the issues
on Knut's AOpen Award system here:
http://bugzilla.kernel.org/show_bug.cgi?id=8842
and give us the hooks to address analogous issues in
other systems.

Please let me know what you think.

thanks,
-Len
