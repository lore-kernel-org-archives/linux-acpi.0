From: Dave Jones <davej@redhat.com>
Subject: oops when BIOS presents multiple ACAD entries.
Date: Tue, 19 Jun 2012 13:34:44 -0400
Message-ID: <20120619173444.GH26103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab2FSRer (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2012 13:34:47 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fedora Kernel Team <kernel-team@fedoraproject.org>

We had a user report an oops at https://bugzilla.redhat.com/show_bug.cgi?id=772730
against 3.1.6 (bug probably goes back further, afaict, this never worked).
Every time there's a power event, he gets the oops.

Josh brought this here back in January, but the thread kind of went nowhere..
http://marc.info/?l=linux-acpi&m=132621492819249&w=2

It's still a problem against 3.4.2. Any hopes for resolution here?

	Dave


