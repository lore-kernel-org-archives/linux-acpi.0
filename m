From: Mike Arthur <mike@mikearthur.co.uk>
Subject: MacBook 5,2 fails to boot
Date: Fri, 24 Apr 2009 14:13:24 +0100
Message-ID: <200904241413.24658.mike@mikearthur.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46456 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZDXNNa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 09:13:30 -0400
Received: by fxm2 with SMTP id 2so1092323fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2009 06:13:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This message would ideally follow on in the thread "MacBook5,2" but I wasn't 
subscribed at the time and can't coax my mail client into replying to it.

This is the referenced thread:
http://markmail.org/message/x333am4rnnjud4op

I'm having the same issue as described here. I've reproduced this on Debian's 
2.6.26/2.6.29 packages and a custom built 2.6.30-rc2 package.

I've done a slight bit of kernel development in the past and am quite happy 
building and running patched kernels and trying stuff out as there's nothing 
important in my Linux system so far. I've tried doing a netconsole but sadly 
it fails before any output is sent.

If this would be better filed on the ACPI Bugzilla then let me know. Basically 
I want to try and get this resolved as soon as I can so am willing to be as 
helpful as I can be to get this debugged.

Thanks for your time!

-- 
Cheers,
Mike Arthur
http://mikearthur.co.uk/
