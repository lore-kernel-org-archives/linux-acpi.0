From: Aaron Lu <aaron.lu@intel.com>
Subject: Discussion on device's runtime wake capability
Date: Tue, 09 Oct 2012 14:23:12 +0800
Message-ID: <5073C2D0.1080900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab2JIGXR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 02:23:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hi all,

We are using _PRW as a hint to see if a device supports wakeup, this is
fine for device which is able to wake the system in a sleep state, but
not to wake itself when system is at S0.

Moreover, when we are to arm the device runtime wake, I think there is
no need to power on the power resources referenced in _PRW, those power
resources should be used to give the device ability to wake the system
from a sleep state, not to wake itself when system is at S0, so powering
thoses power resources on for run wake is a waste.

But I may miss something, so it would be very kind of you to point it
out if things are not like what I've thought, thanks.

BTW, _S0W seems to be a good hint whether the device supports run wake
from ACPI's perspective.

-Aaron

