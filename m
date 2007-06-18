From: "Tom Conerly" <theycallhimtom@gmail.com>
Subject: Opteron 1210 not showing throttling
Date: Mon, 18 Jun 2007 11:04:55 -0700
Message-ID: <3efa93d0706181104p3c1fdef4y6c2de194a3ce80c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:42109 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXFRSE4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jun 2007 14:04:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2283089wah
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jun 2007 11:04:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

First off thanks for the help. I have a opteron 1210 machine with
kernel version 2.6.20-15-generic. I have not installed anything
special for acpi. When I look at the /proc/acpi/processor/CPU0/info it
has:

processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no

Now I believe that the opteron 1210 does support throttling, whats
going on here? Do I need to patch or recompile my kernel?
