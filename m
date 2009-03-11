From: Zhang Rui <rui.zhang@intel.com>
Subject: The Garbled screen issue on Sony laptops with two graphics (Intel
	and Nvidia)
Date: Wed, 11 Mar 2009 10:45:27 +0800
Message-ID: <1236739527.2820.178.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37194 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbZCKCoz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 22:44:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Matthia,

we encounter a couple of bugs about the Garbled screen after X started.
http://bugs.freedesktop.org/show_bug.cgi?id=17508

The problem can be fixed by disabling Nvidia card via ACPI _DSM method.
And it seems that there are some works already done for this issue.
http://archive.netbsd.se/?ml=xorg&a=2009-02&t=9908058

My question is that do we have any plans to ship these fixes upstream?

thanks,
rui



