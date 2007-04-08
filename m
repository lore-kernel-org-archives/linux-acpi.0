From: "Morten Friesgaard" <friesgaard@gmail.com>
Subject: daylight saving makes computer wake up late
Date: Sun, 8 Apr 2007 14:12:52 +0200
Message-ID: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:38812 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbXDHMMx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 08:12:53 -0400
Received: by an-out-0708.google.com with SMTP id b33so1372078ana
        for <linux-acpi@vger.kernel.org>; Sun, 08 Apr 2007 05:12:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi.
I'm running a mythbox, and ever since we had our yearly change of
daylight savings (summer time) my computer wakes up late. At first it
was only an hour, then I set the time with hwclock (realised that
CLOCK_SYSTOHC="no"), now it is 2 hours late. And it is really precise
(1-2 hours later), and it is certainly because of daylight savings.

Any ideas?

Regards,
Morten

# rc-update show | grep acpi
acpid | default

# clock settings
CLOCK="UTC"
TIMEZONE="Europe/Copenhagen"
CLOCK_SYSTOHC="yes"

#uname -a
Linux mythbox 2.6.18-gentoo-r6 #1 SMP Wed Jan 31 15:40:25 CET 2007
i686 AMD Sempron(tm) Processor 3000+ AuthenticAMD GNU/Linux
