From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 4 Sep 2017 11:08:49 +0800
Message-ID: <20170904030847.GA10604@localhost.localdomain>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
 <2895411.GR6mzpbNLk@aspire.rjw.lan>
 <20170904022619.GB30906@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3496 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753124AbdIDDI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2017 23:08:56 -0400
Content-Disposition: inline
In-Reply-To: <20170904022619.GB30906@x1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

On Mon, Sep 04, 2017 at 10:26:19AM +0800, Baoquan He wrote:
>On 09/04/17 at 12:55am, Rafael J. Wysocki wrote:
>> On Sunday, September 3, 2017 4:31:23 PM CEST Chao Fan wrote:
>> > KASLR should choose the memory region of immovable node to extract kernel.
>> > So get ACPI SRAT table and store the memory region of movable node which
>> > kaslr shold avoid.
>> 
>> Please elaborate.
>> 
>> This is far too little information on what problem you are trying to address
>> and why you are trying to address it in this particular way.
>
>Agree with Rafael.
>
>Why don't you try specifying those regions in cmdline and process them
>in kaslr.c? Your colleague, Liyang has tried this way, just he only
>considered the region in the first node. In this way, you don't need to

Hi Baoquan,

Yes, but if the region is not only in the first node, we can get the
detail information about the memory scope and whether it's hotpluggable
only by the ACPI table. The lines of code are so many, but we can get
more information.

Thanks,
Chao Fan

>touch ACPI tables with so many lines of code.
>
>Thanks
>Baoquan
>
>


