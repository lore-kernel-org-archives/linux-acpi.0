From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: drivers for Lenovo 3000 series?
Date: Mon, 20 Apr 2009 13:35:13 +0800
Message-ID: <1240205713.7661.416.camel@rzhang-dt>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
	 <1239586069.5564.9.camel@localhost.localdomain>
	 <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
	 <20090414193340.GA8304@srcf.ucam.org>
	 <d0cc17060904141252q721daf9cp1f3a6a6667394f9a@mail.gmail.com>
	 <1239759896.7661.302.camel@rzhang-dt>
	 <d0cc17060904180417i2cec7ebckddf31bed36606cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40784 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZDTFev (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 01:34:51 -0400
In-Reply-To: <d0cc17060904180417i2cec7ebckddf31bed36606cde@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@startrek.or.id>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-04-18 at 19:17 +0800, Andika Triwidada wrote:
> On Wed, Apr 15, 2009 at 8:44 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> > On Wed, 2009-04-15 at 03:52 +0800, Andika Triwidada wrote:
> >> On Wed, Apr 15, 2009 at 2:33 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> > On Wed, Apr 15, 2009 at 02:31:35AM +0700, Andika Triwidada wrote:
> >> >
> >> >>  /sys/class/backlight/acpi_video0/brightness exist, I can write and
> >> >> the value kept,
> >> >> but no effect on display brightness.
> >> >
> >> > Is this an Intel graphics machine? Is the i915 driver loaded?
> >>
> >> yes and yes
> >>
> >> $ lspci -nn|egrep '(VGA|Disp)'
> >> 00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile 4
> >> Series Chipset Integrated Graphics Controller [8086:2a42] (rev 07)
> >> 00:02.1 Display controller [0380]: Intel Corporation Mobile 4 Series
> >> Chipset Integrated Graphics Controller [8086:2a43] (rev 07)
> >>
> >> $ lsmod|grep 915
> >> i915                   44928  2
> >> drm                   110304  3 i915
> >> intel_agp              39152  1
> >>
> > please attach the acpidump output.
> > please try the latest git tree.
> >
> > thanks,
> > rui
> 
> using latest (?) git tree (my network link is quite slow, latest I
> have is v2.6.30-rc1)
> is worst, no /sys/class/backlight
> 
> furthermore,

please apply this patch
http://marc.info/?l=linux-kernel&m=123982845406021&w=2
on top of 2.6.30-rc1 and see if /sys/class/backlight/acpi_video0/ comes
back again.

If it doesn't help, please file a new bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
so that we can track this bug better.

thanks,
rui


>  running acpi_listen while running kernel Ubuntu
> 2.6.27-11-generic (amd64)
> I got some messages (comments are mine):
> video DD02 00000086 00000000; brightness up key pressed
> video DD02 00000087 00000000; brightness down key pressed
> 
> attached some files which might help,
> please let me know if you need more data/test
> 
> Regards,
> Andika

