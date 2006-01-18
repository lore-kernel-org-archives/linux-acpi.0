From: Hanno Mueller <sockpuppet@hanno.de>
Subject: Re: How to get /proc/acpi/alarm to work?
Date: Wed, 18 Jan 2006 11:02:06 +0100
Message-ID: <43CE121E.8000806@hanno.de>
References: <59D45D057E9702469E5775CBB56411F101682685@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from p-dns.epublica.de ([213.238.59.9]:40836 "EHLO
	kermit.epublica.de") by vger.kernel.org with ESMTP id S1751372AbWARKCM
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 05:02:12 -0500
Received: from router.epublica.de ([82.149.68.78] helo=[192.168.1.42])
	by kermit.epublica.de with esmtp (Exim 3.36 #2 (Debian))
	id 1EzA8l-0000wa-00
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 11:02:07 +0100
In-Reply-To: <59D45D057E9702469E5775CBB56411F101682685@pdsmsx406>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Li, Shaohua schrieb:
> Is it possible you could try the patch at 
> http://bugzilla.kernel.org/show_bug.cgi?id=5833?
> Christian Lupien's patch made a lot of improvements on alarm.

Thanks, but no, that didn't solve the problem.

Let me rephrase the description. My BIOS has a different ACPI alarm
value than the value stored in /proc/acpi/alarm.



I can set the RTC alarm wakeup in the BIOS's ACPI settings to:

  enabled: yes
  day:     18
  hour:    15
  minute:  10
  second:  30

If I look at /proc/acpi/alarm, it doesn't show me "****-**-18 15:10:30"
as one would expect, but a different value.

When doing

  echo "2006-01-18 15:20:45" > /proc/acpi/alarm

I get (with Christian's patch):

  cat /proc/acpi/alarm
  "****-**-** 15:20:45 +int (2006-01-18 10:50:12)"

Now, after rebooting, the BIOS _still_ shows 15:10:30 on day 18 in its
ACPI settings.


So on my system, the BIOS's RTC alarm wakeup ACPI setting appears to be
something different than what /proc/acpi/alarm has access to.

Also, the /proc/acpi/alarm setting does not wake the system from S5,
while the BIOS setting can. And the BIOS can handle the day's number as
a wakeup setting, while /proc/acpi/alarm cannot.

Any idea how to read and change the BIOS's RTC alarm wakeup from Linux?
I have read from users of other mainboards that it works for them
(including the day's number).

As I wrote before, the nvram-wakeup method does not work on this
mainboard, either.

Regards,

Hanno


-- 
epublica GmbH
http://www.epublica.de

Open Business Club - join: http://www.openbc.com/go/invanon/2

