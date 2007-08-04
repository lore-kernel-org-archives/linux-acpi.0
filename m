From: Gautam Iyer <gautam@math.stanford.edu>
Subject: ACPI event generated every time I check ac_adapter status
Date: Sat, 4 Aug 2007 01:56:25 -0700
Message-ID: <20070804085556.GA13199@math.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.22.28]:51000 "EHLO
	smtp1.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXHDJTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Aug 2007 05:19:11 -0400
Received: from smtp1.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 4E6CF4C4B7
	for <linux-acpi@vger.kernel.org>; Sat,  4 Aug 2007 02:00:19 -0700 (PDT)
Received: from localhost (SW-90-728-257-1.Stanford.EDU [171.66.159.85])
	by smtp1.stanford.edu (Postfix) with ESMTP id 119C24C4AE
	for <linux-acpi@vger.kernel.org>; Sat,  4 Aug 2007 02:00:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

I'm using linux 2.6.21, on a Linux Certified laptop (LC2100E). I find
that if I do

    cat /proc/acpi/ac_adapter/AC0/state

then an ACPI event for CPU1 is generated (I only have one CPU on my
system). More precisely, with acpid running, I see the following line in
my system logs:

    acpid: group=processor, action=processor, device=CPU1, value=00000000, id=00000080

Normally I wouldn't care about an extra line or two in my system logs.
However it turns out that if my monitor is idle, then X powers it up
every time it receives this event. Thus if I poll the state (e.g. via
gkrellm2), I can't put my monitor to sleep!

Does any one else have this problem, or know what I can do about it?

Thanks,

GI

-- 
'Adult' -- A person who has stopped growing at both ends and is now
growing in the middle.
