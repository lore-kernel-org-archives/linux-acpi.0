From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: drivers for Lenovo 3000 series?
Date: Wed, 15 Apr 2009 09:44:56 +0800
Message-ID: <1239759896.7661.302.camel@rzhang-dt>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
	 <1239586069.5564.9.camel@localhost.localdomain>
	 <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
	 <20090414193340.GA8304@srcf.ucam.org>
	 <d0cc17060904141252q721daf9cp1f3a6a6667394f9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23611 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZDOBog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 21:44:36 -0400
In-Reply-To: <d0cc17060904141252q721daf9cp1f3a6a6667394f9a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@startrek.or.id>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-04-15 at 03:52 +0800, Andika Triwidada wrote:
> On Wed, Apr 15, 2009 at 2:33 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Wed, Apr 15, 2009 at 02:31:35AM +0700, Andika Triwidada wrote:
> >
> >>  /sys/class/backlight/acpi_video0/brightness exist, I can write and
> >> the value kept,
> >> but no effect on display brightness.
> >
> > Is this an Intel graphics machine? Is the i915 driver loaded?
> 
> yes and yes
> 
> $ lspci -nn|egrep '(VGA|Disp)'
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile 4
> Series Chipset Integrated Graphics Controller [8086:2a42] (rev 07)
> 00:02.1 Display controller [0380]: Intel Corporation Mobile 4 Series
> Chipset Integrated Graphics Controller [8086:2a43] (rev 07)
> 
> $ lsmod|grep 915
> i915                   44928  2
> drm                   110304  3 i915
> intel_agp              39152  1
> 
please attach the acpidump output.
please try the latest git tree.

thanks,
rui

