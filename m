From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 4 Sep 2017 09:44:09 +0800
Message-ID: <20170904014408.GA23556@localhost.localdomain>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
 <2895411.GR6mzpbNLk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45089 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753120AbdIDBoZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2017 21:44:25 -0400
Content-Disposition: inline
In-Reply-To: <2895411.GR6mzpbNLk@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

On Mon, Sep 04, 2017 at 12:55:00AM +0200, Rafael J. Wysocki wrote:
>On Sunday, September 3, 2017 4:31:23 PM CEST Chao Fan wrote:
>> KASLR should choose the memory region of immovable node to extract kernel.
>> So get ACPI SRAT table and store the memory region of movable node which
>> kaslr shold avoid.
>
>Please elaborate.

Hi Rafael,

Sorry for that.
The problem is: in a machine, some numa nodes are hotpluggable, some are
not. The kernel should use the memory in unhotpluggable.
But when extracting kernel, kaslr may chooose the memory in hotpluggable
or unhotpluggable node. The ACPI SRAT table can show the node is
hotpluggable or not. But the acpi_boot_table_init runs in setup_arch,
which is after extracting kernel. So I imitate the initialization in
acpi_boot_table_init to get the table before extracting kernel. And
mark the memory region in hotpluggable node to avoid kaslr extracting
kernel in these regions.

Thanks,
Chao Fan

>
>This is far too little information on what problem you are trying to address
>and why you are trying to address it in this particular way.
>
>Thanks,
>Rafael
>
>
>


