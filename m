From: "Nick Nobody" <me@nikosapi.org>
Subject: Suspend on Lenovo 3000 V200 - Linux 2.6.25rc8
Date: Sat, 5 Apr 2008 23:10:05 -0400
Message-ID: <3e8fd0440804052010xbe8f59bw3268d8206b97ac3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:35963 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbYDFDKG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Apr 2008 23:10:06 -0400
Received: by an-out-0708.google.com with SMTP id d31so182559and.103
        for <linux-acpi@vger.kernel.org>; Sat, 05 Apr 2008 20:10:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I'm trying to get suspend working properly on my Lenovo 3000 V200. I'm
using Linux 2.6.25rc8 and the latest xf86-video-intel. Before I was
using kernel-2.6.23.15-137.fc8, xorg-x11-drv-i810-2.1.1-8.fc8 and
suspend worked perfectly.

The laptop will go to sleep properly but it doesn't seem to enjoy
waking up. When it starts up it will either display a black screen and
remain frozen or I will end up at a virtual term login prompt but when
I put in my username it never prompts me for my password.

The only way to get suspend working reasonably well is to first
hibernate and then suspend. After a hibernation suspend seems to work
fine :S

I'm a real noob when it comes to figuring out these sort of things, so
any pointers on things I could try would be much appreciated.

Here's what s2ram has to say about my hardware:
Machine is unknown.
This machine can be identified by:
    sys_vendor   = "LENOVO"
    sys_product  = "07642CU"
    sys_version  = "LENOVO3000 V200"
    bios_version = "65ET32WW (1.06 )"

Here's the output of dmidecode: http://pastebin.ca/973442

Thanks,

nick
