From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH 2/2] xen/acpi/sleep: Register to the acpi_suspend_lowlevel a callback.
Date: Tue, 14 May 2013 13:46:11 -0400
Message-ID: <1368553572-4966-1-git-send-email-benjamin.guthro@citrix.com>
References: <1368551357-3903-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:28695 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757408Ab3ENRq0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 May 2013 13:46:26 -0400
In-Reply-To: <1368551357-3903-1-git-send-email-benjamin.guthro@citrix.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xensource.com


Apoligies, the prior description was a bit stale, in lieu of the 3.10 merge window.
cr3 is really the only thing that this needs to worry about anymore, since gdt pvops
has been removed, and the other registers are pvops'ed.

