From: Craig Lawson <craig.lawson@dslextreme.com>
Subject: BIOS wake-up alarm doesn't work anymore
Date: Tue, 14 Mar 2006 01:03:21 -0800
Message-ID: <441686D9.4040107@dslextreme.com>
References: <1139558159.29028.16.camel@localhost.localdomain> <200603131221.13287.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail5.dslextreme.com ([66.51.199.81]:57262 "HELO
	mail5.dslextreme.com") by vger.kernel.org with SMTP
	id S1751270AbWCNJDY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Mar 2006 04:03:24 -0500
In-Reply-To: <200603131221.13287.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi ACPI list,

I'm new to the list, and I'm looking for some help with my system.

Something has changed with my BIOS wake-up alarm. It was set to wake
everyday at 3:00 am, cron would run backups, and then suspend to S5
again. Worked that way for well over a year, though several kernel
upgrades. But when I switched to 2.6.14-5 with suspend2 2.2-rc14
(specifically Gentoo suspend2-sources-2.6.14-r7), it stopped working.
The kernel I used immediately prior was 2.6.11.11 + suspend2-2.1.8. (and
I am now on 2.6.15-r6.)

My BIOS alarm has 3 fields: day, hour, and minute. I have it set to "day
= 0, 10:45 am" (UTC), where day = 0 means "everyday". /proc/acpi/alarm
shows "2006-01-00 10:45:00" (year, month, and seconds are filled in by
the kernel, year and month are from today's date).

I read with interest Hanno's and Shaohua's e-mails from around
2006-01-18. Sounds like Hanno's problem is similar to mine (except I
know mine used to work reliably). My kernels have been configured with
CONFIG_RTC=m.

I tried several things to understand the problem:

    * I can write timestamps into /proc/acpi/alarm. When I read them
      back, they are the same (day, hours, and minute, that is).
    * I write a timestamp into /proc/acpi/alarm with day = 0, and the
      system won't wake.
    * I configure the alarm in the BIOS with day = 0 and then power off.
      It won't wake.
    * I write a timestamp into /proc/acpi/alarm with a non-zero day, and
      the system wakes when it's supposed to. After waking, the day has
      been cleared to 0.
    * I write a timestamp two days in the future and suspend to S5. I
      resume the next day, and the day has been cleared to zero.
    * Write a non-zero day, suspend to S5, power on and go to BIOS
      config to see what's in there. The BIOS has day = 0. Don't change
      it and power off. Result: system won't wake.
    * As a work-around, I have an hourly cron job that computes and
      writes the next wake time into /proc/acpi/alarm. Result: wakes
      from S5 reliably.

More system details:
  MB is: DFI PS83-BL
  BIOS is: Award 02/16/2004-I865P/PE-6A79AD4DC-00 (updated Sept 2004)
  Flash type is: Winbond 49V002F/3.3V

This is definitely not as good as before. When day = 0 meant "every
day", my system could be unplugged for several days, and it would always
wake at 3 am the day after power was restored. And it never forgot to
wake up.

What has changed? And why, if I remove all power to the machine and then
configure the BIOS alarm directly, won't the system wake up?

And is this a bug or a feature?

Thanks and Best Regards,
Craig.

