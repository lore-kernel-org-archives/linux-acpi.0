From: Len Brown <lenb@kernel.org>
Subject: native HPET probe required
Date: Sat, 18 Aug 2007 17:27:45 -0400
Message-ID: <200708181727.45455.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57810 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289AbXHRV1v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Aug 2007 17:27:51 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org

Venki,
I think that the confirmation from Dell in this bug report
is justification enough for you to push native HPET probing
and for Linux to not rely on ACPI to enumerate the HPET.

http://bugzilla.kernel.org/show_bug.cgi?id=4255

-Len
