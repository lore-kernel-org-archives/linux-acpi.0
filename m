From: Corentin Chary <corentin.chary@gmail.com>
Subject: ACPI ALS Status ?
Date: Sun, 6 Nov 2011 20:34:13 +0100
Message-ID: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39060 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1KFTeP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Nov 2011 14:34:15 -0500
Received: by wyh15 with SMTP id 15so3840454wyh.19
        for <linux-acpi@vger.kernel.org>; Sun, 06 Nov 2011 11:34:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

Hi,
I was looking at the DSDT of a new samsung laptop (I can send you the
output of acpidump if interested), and it export a standard ACPI ALS
device. So, it's actually great to see vendor using that, but it seems
that the series adding support for that and sent back in 2009 is not
available in the kernel. I'd really like to use my the ALS, what's the
current status of the driver ? Still blocked because we don't have a
generic sysfs class ? If yes, can't we just use a non-standard
interface ? It would still be better than no driver at all.

Thanks,

-- 
Corentin Chary
http://xf.iksaif.net
