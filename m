From: helgaas@ldl.fc.hp.com
Subject: [patch 00/17] PNP Lindent
Date: Mon, 23 Jul 2007 15:27:57 -0600
Message-ID: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52723 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbXGWVdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run PNP files through Lindent.  These patches are all completely
independent and contain no functional changes.  Object files before
and after are identical.

These are against current upstream.  If you prefer a different base
or drop some of these due to conflicts with things already in -mm,
let me know and I can regenerate them.

Bjorn

--
