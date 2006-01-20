From: Hanno Mueller <sockpuppet@hanno.de>
Subject: Re: How to get /proc/acpi/alarm to work?
Date: Fri, 20 Jan 2006 01:52:45 +0100
Message-ID: <43D0345D.4060009@hanno.de>
References: <59D45D057E9702469E5775CBB56411F1016C8E04@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from p-dns.epublica.de ([213.238.59.9]:46047 "EHLO
	kermit.epublica.de") by vger.kernel.org with ESMTP id S1030233AbWATAwu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 19:52:50 -0500
Received: from p548ea6a0.dip0.t-ipconnect.de ([84.142.166.160] helo=[192.168.178.20])
	by kermit.epublica.de with esmtp (Exim 3.36 #2 (Debian))
	id 1EzkWD-0000iu-00
	for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2006 01:52:45 +0100
In-Reply-To: <59D45D057E9702469E5775CBB56411F1016C8E04@pdsmsx406>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,

thanks.

Li, Shaohua schrieb:
> Can you enable the RTC driver? IIRC, without it, the date you see is
> wrong, which might make you set wrong alarm.

Yes, it is enabled (now). But no, it didn't help.



I still have two different alarm settings.

1) The setting stored in the BIOS's ACPI section as "RTC alarm". I can
choose a time and a specific day of the month.

2) The setting stored in /proc/acpi/alarm - there I can only choose the
time, not the day.

These two settings appear to be completely independent from each other.

Also, the 2nd setting does not work. I can change it and the computer
remembers it between reboots, but the BIOS does not wake up the system
from S5. The 1st setting is able to wake up the system.

Two questions: Why are there two different settings? I thought there was
just one?

And more important to me: How can I access the 1st alarm time from
Linux? Since the BIOS lists it in its ACPI settings section, I guess
there is some way to access it through ACPI.

Regards,

Hanno
