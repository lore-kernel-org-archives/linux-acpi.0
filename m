From: John Marsden <john.d.marsden@gmail.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after suspend
Date: Wed, 30 Jul 2014 18:11:02 +0100
Message-ID: <CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
	<53D7AF8F.7060401@intel.com>
	<CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
	<20140730083248.GA31763@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:61334 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbaG3RLE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2014 13:11:04 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so1147753lbj.9
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2014 10:11:02 -0700 (PDT)
In-Reply-To: <20140730083248.GA31763@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

On 30 July 2014 09:32, Aaron Lu <aaron.lu@intel.com> wrote:
> Does the other interface work after resume? I mean the intel_backlight
> and the toshiba one?

The intel-backlight interface works but the toshiba one does not work.

Below is my detailed test actions and results:

Fresh boot in v3.16-rc
======================

sudo su
cat /sys/class/backlight/intel_backlight/brightness
4539
cat /sys/class/backlight/toshiba/brightness
7
cat /sys/class/backlight/acpi_video0/brightness
7

Operate brightness control downwards via system settings.  Screen dims:

cat /sys/class/backlight/intel_backlight/brightness
3844

Restored brightness control to full via system settings. Screen brightens:

cat /sys/class/backlight/intel_backlight/brightness
4539

Suspend and resume
==================

cat /sys/class/backlight/intel_backlight/brightness
4539
cat /sys/class/backlight/toshiba/brightness
7
cat /sys/class/backlight/acpi_video0/brightness
7

TEST operating brightness controls via user interface:

Operate brightness control downwards via system settings. No change to
screen brightness:

cat /sys/class/backlight/intel_backlight/brightness
4539

Restored brightness control to full via system settings. No change to
screen brightness:

cat /sys/class/backlight/intel_backlight/brightness
4539

TEST setting directly via sysfs:

echo 3844 > /sys/class/backlight/intel_backlight/brightness

screen goes dimmer.

cat /sys/class/backlight/intel_backlight/brightness
3844
echo 4539 > /sys/class/backlight/intel_backlight/brightness

Screen goes brighter.

cat /sys/class/backlight/intel_backlight/brightness
4539

BUT:
echo 2 > /sys/class/backlight/toshiba/brightness

no change to screen brightness.

cat /sys/class/backlight/intel_backlight/brightness
4539
cat /sys/class/backlight/toshiba/brightness
2
echo 7 > /sys/class/backlight/toshiba/brightness
cat /sys/class/backlight/toshiba/brightness
7

AND:
echo 2 > /sys/class/backlight/acpi_video0/brightness

no change to screen brightness.

cat /sys/class/backlight/acpi_video0/brightness
2
cat /sys/class/backlight/intel_backlight/brightness
4539
echo 7 > /sys/class/backlight/acpi_video0/brightness
cat /sys/class/backlight/acpi_video0/brightness
7

NOTE ALSO:
==========
On previous test after suspend and resume screen comes up dim:

cat /sys/class/backlight/intel_backlight/brightness
249
cat /sys/class/backlight/toshiba/brightness
7
cat /sys/class/backlight/acpi_video0/brightness
7

I'm not sure what it is that determines whether screen comes up dimmed
after suspend and resume.  Seems to be related to whether power is
plugged in and/or screen has dimmed automatically because of computer
auto-suspending after in-activity.

Thanks for your help.  John
