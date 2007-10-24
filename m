From: "Ash Milsted" <thatistosayiseenem@gawab.com>
Subject: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update correctly
Date: Wed, 24 Oct 2007 20:14:42 +0200
Message-ID: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:35420 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbXJXSOn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 14:14:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so287703wxd
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 11:14:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I just tried out the new RC on my laptop system, initially neglecting
to enable ACPI_PROCFS support. Thus I was thrust into using the new
sysfs interface for the battery.c driver. ..

Unfortunately the charge values etc do not seem to update periodically
- only (un)plugging the AC power updates the status if ACPI_PROCFS is
disabled.
If ACPI_PROCFS is enabled then a read to /proc/acpi/battery/state gets
the up-to-date data, and a subsequent read to the sysfs equivalents
gives the same results - otherwise sysfs stays stale.

If you need any more info please say so - this is on an ageing Toshiba
Satellite 1110.

Thanks,

Ash
