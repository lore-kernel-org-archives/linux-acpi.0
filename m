From: John Marsden <john.d.marsden@gmail.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after suspend
Date: Mon, 4 Aug 2014 21:32:40 +0100
Message-ID: <CACiopZBgyr0+81nz8fW_OvZtUg71r9tHutFLynHtHhDLxK5agQ@mail.gmail.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
	<53D7AF8F.7060401@intel.com>
	<CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
	<20140730083248.GA31763@aaronlu.sh.intel.com>
	<CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
	<20140731080947.GD20462@aaronlu.sh.intel.com>
	<CACiopZCrfyqxgqS8NoF5Hi-K-0zM+8YHsyXqfhWKgjU65n4-Pg@mail.gmail.com>
	<20140801024255.GF30211@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:59784 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaHDUcl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2014 16:32:41 -0400
In-Reply-To: <20140801024255.GF30211@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>

On 1 August 2014 03:42, Aaron Lu <aaron.lu@intel.com> wrote:
> A workaround from user space is to specify the backlight interface you
> want to use in xorg.conf, an example is here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?msg=78;att=0;bug=651741
>
> Section "Device"
> Identifier  "Intel Graphics"
> Driver      "intel"
> Option      "AccelMethod"     "sna"
> Option      "Backlight" "intel_backlight"
> Driver      "intel"
> BusID       "PCI:0:2:0"
> EndSection

Thank you.  This works both in v3.16-rc and in the current Ubuntu
14.04 latest update.  Now user-interface brightness controls work
before AND after a suspend.  The only difference in the user
experience is that now minimum brightness on the brightness sliders
gives a completely dark screen rather than just a very dimly lit
screen.  I can live with this.

I'm guessing this should be regarded as a work-round rather than a
final solution that might eventually form part of the kernel.  Should
I report it as such back in the downstream Ubuntu/Launchpad bug?

If in future, when this is addressed in the kernel, further testing is
required please let me know.  I'd be happy to assist.

Thank you for your help,

John Marsden
