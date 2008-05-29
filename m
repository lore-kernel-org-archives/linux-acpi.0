From: "Jeff Trull" <linmodemstudent@gmail.com>
Subject: looking for advanced debugging advice (resume from ram)
Date: Wed, 28 May 2008 21:09:24 -0700
Message-ID: <685450530805282109j15259cf8s258eeee82d0a65d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:11491 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYE2EJ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 May 2008 00:09:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1937515fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 28 May 2008 21:09:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I'm sending this out because I've tried a lot of techniques I found
described on the web and am
now running out of ideas.  I have a Fujitsu Lifebook S2010 and it
hangs when resuming from S3
(fan running, no disk activity, no response to caps lock), but
hibernates fine. I have tried:

1) running my DSDT through iasl - there are no errors
2) unloading all possible modules before suspend - does not help
3) pm_trace - results are unreliable (different every time, or not
present in dmesg at all)
4) Rafael Wysocki's pm_test_level patch from last year - it appears to
exonerate the drivers
5) adding code to the kernel to toggle the keyboard LEDs - this
revealed that at least some
    code is being executed after resume.  However, sometimes this
added code triggers a
    kernel panic (flashing keyboard LEDs).
6) adding TRACE_RESUME() calls in various places - this gives either
unrepeatable results,
    no results, or kernel panics as in 5)

I just decided this afternoon to start adding calls to the emergency
reboot function to figure
out how far the code is getting, but it occurred to me that perhaps
I've become desperate and
I should ask the experts instead.  Is there any hope of a faster
approach?  I'm getting about
one iteration per hour on my old slow laptop.

Thanks,
Jeff
