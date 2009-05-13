From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] why do we need run disk sync before entering S3
Date: Wed, 13 May 2009 09:20:51 +0800
Message-ID: <1242177651.16529.26.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64960 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbZEMBUT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 May 2009 21:20:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>

Hi, all,

I did some S3 tests on an eeepc901, the total suspend time(from issue
the suspend command to power down) is about 2.5s~3s.
something interesting is that kernel runs disk sync before entering S3
state, and this takes about 0.7~1.2s.
my question is that, why do we need this for s2ram?
can we remove this and run sys_sync for S4 only?

thanks,
rui

