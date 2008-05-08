From: West <weihuayao@gmail.com>
Subject: have anyone implemented STR (Suspend To Ram) on non-x86 platform?
Date: Thu, 8 May 2008 09:50:10 +0800
Message-ID: <759eb87f0805071850l206d2f33l68db2888da78f21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:20881 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYEHBuM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 21:50:12 -0400
Received: by wf-out-1314.google.com with SMTP id 27so507714wfd.4
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2008 18:50:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

hi all,

I have a project to implement STR (Suspend To Ram) on mips platform,
could you please give me some advice？

my questions:
    1. which register should be saved at suspend and restored at resume
    2. how to deal with the MMU

Best Regards,
-West

---------------------------------
Keep It Simple, Stupid
---------------------------------
