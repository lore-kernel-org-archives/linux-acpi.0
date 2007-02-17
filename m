From: Andrew Morton <akpm@linux-foundation.org>
Subject: breakage in current git-acpi
Date: Fri, 16 Feb 2007 22:39:56 -0800
Message-ID: <20070216223956.d04af327.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:50277 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946422AbXBQGlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Feb 2007 01:41:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


Standard FC5 RH install, it is set up to suspend to disk when I close the
lid.

With git-acpi.patch applied, this just stops working on the second or third
attempt.  It's like acpid just didn't see the lid close at all.  Closing
the lid causes no kernel messages at all.

Any suggestions as to how to debug this, apart from git-bisect, which will
take rather a long time?
