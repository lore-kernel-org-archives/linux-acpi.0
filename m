From: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: Any difference between disabling ACPI in BIOS and acpi=off
Date: Tue, 6 Mar 2007 13:56:17 +0800
Message-ID: <ac8af0be0703052156y76e15dbqf4e6683695b5ae07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:11965 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965789AbXCFF4S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 00:56:18 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2022817nze
        for <linux-acpi@vger.kernel.org>; Mon, 05 Mar 2007 21:56:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

For RHEL4-U4-64bit, we can boot up kernel with ACPI enabled in BIOS
whether we add the kernel parameter "acpi=off" or not; however kernel
can't boot with ACPI  disabled in BIOS whether we add kernel parameter
"acpi=off" or not.

My question is, is there any difference between disabling ACPI in BIOS
and acpi=off from the kernel's point of view?

Thanks,
Forrest
