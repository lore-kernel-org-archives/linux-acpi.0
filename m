From: John Marsden <john.d.marsden@gmail.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after suspend
Date: Thu, 31 Jul 2014 22:05:14 +0100
Message-ID: <CACiopZCrfyqxgqS8NoF5Hi-K-0zM+8YHsyXqfhWKgjU65n4-Pg@mail.gmail.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
	<53D7AF8F.7060401@intel.com>
	<CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
	<20140730083248.GA31763@aaronlu.sh.intel.com>
	<CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
	<20140731080947.GD20462@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:54132 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaGaVFQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2014 17:05:16 -0400
Received: by mail-la0-f50.google.com with SMTP id gf5so2508134lab.37
        for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2014 14:05:14 -0700 (PDT)
In-Reply-To: <20140731080947.GD20462@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

On 31 July 2014 09:09, Aaron Lu <aaron.lu@intel.com> wrote:
> Please add acpi_backlight=vendor to kernel cmdline and see if that makes
> the backlight work. What it does is to tell ACPI video module not to
> create the acpi_videoX sysfs interface and let's see if X server will
> pick up the intel_backlight one.

Adding acpi_backlight=vendor to the kernel cmdline results in the
brightness controls not working from first boot, not just after a
suspend.

Detailed test results:

After fresh boot into 3.16-rc with acpi_backlight=vendor added to the
kernel cmdline
ls -l /sys/class/backlight
total 0
lrwxrwxrwx 1 root root 0 Jul 31 21:38 intel_backlight ->
../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
lrwxrwxrwx 1 root root 0 Jul 31 21:38 toshiba ->
../../devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/backlight/toshiba

Attempts to adjust brightness via user interfaces (system settings and
function keys) fail to change brightness.

It remains possible to adjust brightness by directly writing to
/sys/class/backlight/intel_backlight/brightness but, as before, not by
writing to  /sys/class/backlight/toshiba/brightness.

After suspend and resume same test results.

Regards,  John
