From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 4 Sep 2017 10:26:19 +0800
Message-ID: <20170904022619.GB30906@x1>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
 <2895411.GR6mzpbNLk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753180AbdIDC00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 3 Sep 2017 22:26:26 -0400
Content-Disposition: inline
In-Reply-To: <2895411.GR6mzpbNLk@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

On 09/04/17 at 12:55am, Rafael J. Wysocki wrote:
> On Sunday, September 3, 2017 4:31:23 PM CEST Chao Fan wrote:
> > KASLR should choose the memory region of immovable node to extract kernel.
> > So get ACPI SRAT table and store the memory region of movable node which
> > kaslr shold avoid.
> 
> Please elaborate.
> 
> This is far too little information on what problem you are trying to address
> and why you are trying to address it in this particular way.

Agree with Rafael.

Why don't you try specifying those regions in cmdline and process them
in kaslr.c? Your colleague, Liyang has tried this way, just he only
considered the region in the first node. In this way, you don't need to
touch ACPI tables with so many lines of code.

Thanks
Baoquan
