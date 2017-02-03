From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Fri, 3 Feb 2017 12:00:00 +0200
Message-ID: <20170203100000.GK2053@lahna.fi.intel.com>
References: <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
 <20170202142618.GX2053@lahna.fi.intel.com>
 <20170202143145.xnjnicrxf5uapuwl@sig21.net>
 <20170202150212.GA2053@lahna.fi.intel.com>
 <20170202154243.wxrdcy6yqohcwvw3@sig21.net>
 <20170202155826.GF2053@lahna.fi.intel.com>
 <20170202173233.3gk6ko2tnjbhj73y@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4241 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752995AbdBCKAN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Feb 2017 05:00:13 -0500
Content-Disposition: inline
In-Reply-To: <20170202173233.3gk6ko2tnjbhj73y@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com

On Thu, Feb 02, 2017 at 06:32:33PM +0100, Johannes Stezenbach wrote:
> On Thu, Feb 02, 2017 at 05:58:26PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 04:42:43PM +0100, Johannes Stezenbach wrote:
> > > On Thu, Feb 02, 2017 at 05:02:12PM +0200, Mika Westerberg wrote:
> > > > Is the model Asus E200HA? Something like this (sorry the information is
> > > > in Finnish but the machine should look the same):
> > > > 
> > > > https://www.karkkainen.com/verkkokauppa/asus-e200ha-fd0005ts-11-6--hd-kannettava-tietokone
> > > 
> > > Looks right, mine is E200HA-FD0004TS but I think that just means dark blue color.
> > 
> > OK, we have one other Cherrytrail machine here which may have the same
> > PMIC. We'll check that first and if it does not have the same, I'll
> > order the above machine.
> 
> In case it is useful to know, I installed Debian stretch following this:
> https://wiki.debian.org/InstallingDebianOn/Asus/E200HA
> 
> I built my kernel using a relatively minimal kernel config,
> let me know if you want it.  I could also post the
> two patches which port the mfd and opregion drivers, but
> they are straight forward copies of intel_soc_pmic_crc.c
> and intel_pmic_crc.c from 4.10.0-rc6+ with code copy&pasted
> from the ProductionKernelQuilts patches and s/crc/dc_ti/ etc.,
> except I scamped the thermal handler to skip the ADC driver port for now.

Thanks!

Just for book keeping purposes, can you file a kernel.org bugzilla bug
about this and add all the necessary information, and your patches
there? You can assign the bug directly to me.
