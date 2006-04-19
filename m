From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: how to back from suspend without shutdown
Date: Wed, 19 Apr 2006 21:59:30 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206C7@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22385 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750744AbWDSN7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2006 09:59:34 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, acpi devel <linux-acpi@vger.kernel.org>

>Hi everybody,
>I have a new laptop one HP Compaq NX6110 , that works quite well with
>suspend and hibernation.
>
>But after suspend , how I bring back computer ?, the only key that I
>know is power button, but after press power button and laptop wake-up,
>Begins the shutdown process because is triggered the power button
>shutdown .
>any ideas ?

Maybe you need to write a patch:

acpi_button_notify:
	if(acpi_during_suspend_resume)
		don't generate power button event to confuse user space
daemon,

for acpi_during_suspend_ruesme definition please search title 
"Power-button event after resume from S3" in acpi ML archive.

Thanks,
Luming
