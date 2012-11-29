From: Matt White <mattw922@gmail.com>
Subject: Lenovo T530 Brightness Control Issue
Date: Wed, 28 Nov 2012 18:14:35 -0800
Message-ID: <CA+BUVh0QnRqtZqqNoA3hW-XGStGgEdCsQ_TrT_TD-o26D5gUYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50154 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab2K2CO4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2012 21:14:56 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so10364925qcr.19
        for <linux-acpi@vger.kernel.org>; Wed, 28 Nov 2012 18:14:55 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I installed Ubuntu 12.10 with kernel version 3.5.0-18 on a Lenovo Thinkpad
T530 and everything seems to work well except the brightness control.
When using integrated graphics, it works fine, but if I switch to the
Nvidia
graphics, I only get the brightness notification like it's working, but the
brightness doesn't actually change. I filed a bug here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1083984

I tried various different config tweaks as noted on Launchpad, and I also
tried other newer kernel versions with no success. I was told to email this
list to see if there were any suggestions.

Thanks,
Matt W.
