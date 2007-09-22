From: Len Brown <lenb@kernel.org>
Subject: ACPI patches i test branch queued for 2.6.24
Date: Fri, 21 Sep 2007 23:46:06 -0400
Message-ID: <11904327981905-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:26644 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbXIVDqk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here are the patches currently on the ACPI test branch
(above the handful just send on the release branch)
that are candidates for 2.6.24.

I'm sure I mised some, and I may have a couple that are
not the latest versions sent to me -- that is the fun
I get to sort out on Monday.

Note that cpuidle is dropped for the moment -- but will be
restored in a consolidated form shortly.
(I want it down to two patches -- cpuidle vs 2.6.22,
and forward-port cpuidle to 2.6.23)

Also, the Documentation patches are dropped, as I re-wrote
them as web pages, hopefully to appear on the new Linux/ACPI
web page under lesswatts.org next week.

thanks,
-Len
