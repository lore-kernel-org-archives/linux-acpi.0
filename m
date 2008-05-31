From: "Jeff Trull" <linmodemstudent@gmail.com>
Subject: no self-refresh during S3 - any debug hints?
Date: Sat, 31 May 2008 12:15:50 -0700
Message-ID: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:58891 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYEaTQI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 May 2008 15:16:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so361635fgg.17
        for <linux-acpi@vger.kernel.org>; Sat, 31 May 2008 12:15:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello ACPI experts,

I made a breakthrough in my s2r debugging last night when I realized
that the sooner I pressed the power button after suspend, the more
life the system exhibited post-resume.  In fact when I attempted to
resume immediately after entering suspend, my system had a successful
resume from memory for the first time ever.  Therefore, I have a new
hypothesis: DRAM self-refresh mode is not being properly entered.

I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
recompiling the kernel.  Any suggestions as to how to proceed,
experiments to run, etc.?

Thanks for any help you can give,
Jeff
