From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after
 suspend
Date: Fri, 1 Aug 2014 10:42:55 +0800
Message-ID: <20140801024255.GF30211@aaronlu.sh.intel.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
 <53D7AF8F.7060401@intel.com>
 <CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
 <20140730083248.GA31763@aaronlu.sh.intel.com>
 <CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
 <20140731080947.GD20462@aaronlu.sh.intel.com>
 <CACiopZCrfyqxgqS8NoF5Hi-K-0zM+8YHsyXqfhWKgjU65n4-Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACiopZCrfyqxgqS8NoF5Hi-K-0zM+8YHsyXqfhWKgjU65n4-Pg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: John Marsden <john.d.marsden@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 31, 2014 at 10:05:14PM +0100, John Marsden wrote:
> On 31 July 2014 09:09, Aaron Lu <aaron.lu@intel.com> wrote:
> > Please add acpi_backlight=vendor to kernel cmdline and see if that makes
> > the backlight work. What it does is to tell ACPI video module not to
> > create the acpi_videoX sysfs interface and let's see if X server will
> > pick up the intel_backlight one.
> 
> Adding acpi_backlight=vendor to the kernel cmdline results in the
> brightness controls not working from first boot, not just after a
> suspend.

That probably because X server now picks the toshiba_acpi interface
instead of the intel_backlight one.

A workaround from user space is to specify the backlight interface you
want to use in xorg.conf, an example is here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?msg=78;att=0;bug=651741

Section "Device"
Identifier  "Intel Graphics"
Driver      "intel"
Option      "AccelMethod"     "sna"
Option      "Backlight" "intel_backlight"
Driver      "intel"
BusID       "PCI:0:2:0"
EndSection

Alternatively, we can disable the acpi_video and toshiba_acpi interfaces
in the kernel so that only intel_backlight is available. I'm not sure
how to do this nicely, I've cc-ed platform x86 mailing list.

Regards,
Aaron

> 
> Detailed test results:
> 
> After fresh boot into 3.16-rc with acpi_backlight=vendor added to the
> kernel cmdline
> ls -l /sys/class/backlight
> total 0
> lrwxrwxrwx 1 root root 0 Jul 31 21:38 intel_backlight ->
> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
> lrwxrwxrwx 1 root root 0 Jul 31 21:38 toshiba ->
> ../../devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/backlight/toshiba
> 
> Attempts to adjust brightness via user interfaces (system settings and
> function keys) fail to change brightness.
> 
> It remains possible to adjust brightness by directly writing to
> /sys/class/backlight/intel_backlight/brightness but, as before, not by
> writing to  /sys/class/backlight/toshiba/brightness.
> 
> After suspend and resume same test results.
> 
> Regards,  John
