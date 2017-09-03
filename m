From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 04 Sep 2017 00:55:00 +0200
Message-ID: <2895411.GR6mzpbNLk@aspire.rjw.lan>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49594 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753093AbdICXDs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2017 19:03:48 -0400
In-Reply-To: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

On Sunday, September 3, 2017 4:31:23 PM CEST Chao Fan wrote:
> KASLR should choose the memory region of immovable node to extract kernel.
> So get ACPI SRAT table and store the memory region of movable node which
> kaslr shold avoid.

Please elaborate.

This is far too little information on what problem you are trying to address
and why you are trying to address it in this particular way.

Thanks,
Rafael

