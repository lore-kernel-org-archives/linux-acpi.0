From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 02/13] ACPI/IPMI: Fix atomic context requirement of ipmi_msg_handler()
Date: Thu, 12 Sep 2013 10:44:02 -0400
Message-ID: <5231D332.2080602@redhat.com>
Reply-To: 8a21a77c2672cc91d8de13bb33c51104dc42affa.1374566394.git.lv.zheng@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab3ILOir (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 10:38:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, lv.zheng@intel.com, Don Zickus <dzickus@redhat.com>

Hi, Len.

On Jul 23, Lv Zheng submitted this patch (02/13)
https://lkml.org/lkml/2013/7/23/96

.. and early this month, not having seen Lv's patch, I
submitted a virtual identical one, here. 
https://lkml.org/lkml/2013/9/2/305

We've been seeing lockdep splats that are fixed by this
patch, so I'm wondering if Lv's patch will be included
in kernel v3.12.

