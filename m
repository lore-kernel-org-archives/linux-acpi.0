From: Thomas Renninger <trenn@suse.de>
Subject: Re: getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Mon, 6 Sep 2010 13:43:32 +0200
Message-ID: <201009061343.32919.trenn@suse.de>
References: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com> <AANLkTikuQjDQGt1Ppm5u6PPkk_-CBM7_sUL=asgAneJb@mail.gmail.com> <1282872611.3707.103.camel@rui>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48728 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab0IFLng (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Sep 2010 07:43:36 -0400
In-Reply-To: <1282872611.3707.103.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Yedidia Klein <yedidia@atarplpl.co.il>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 27 August 2010 03:30:11 Zhang Rui wrote:
> On Thu, 2010-08-26 at 17:17 +0800, Yedidia Klein wrote:
> > here is my acpidump output.
> > 
> hmmm, please attach the output of "cat /proc/interrupts" and
> "grep . /sys/firmware/acpi/interrupts/*", both before and after pressing
> the hotkey.
Yep.
You could also try to load the wmi driver with:
debug_event=1
e.g. adding this line:
options wmi debug_event=1
in
/etc/modprobe.d/99-local.conf or /etc/modprobe.conf.local
(the first is the new the latter the older interface, depends on your
userspace versions)
Then hit the button and check syslog.

It might also be served by a Windows spec called "hot start" for which
I sent a driver which would still need some polishing some weeks ago.
The device for these is:
PNP0C32

Please add me to CC if you open bug at bugzilla.kernel.org. I won't
have time to code, but I can help a bit.

      Thomas
