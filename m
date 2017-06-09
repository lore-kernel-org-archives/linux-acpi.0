From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual
 GPIO device
Date: Fri, 09 Jun 2017 11:22:32 +0300
Message-ID: <1496996552.22624.60.camel@linux.intel.com>
References: <20170602151507.22391-1-hdegoede@redhat.com>
         <20170602151507.22391-2-hdegoede@redhat.com>
         <CAHp75Vcdznj2mB+msNvysrvRi3L-0j4c6vthOS8oAv1S9iYWKA@mail.gmail.com>
         <20170608154541.GH32509@fury>
         <d41ff55b-e28f-85bf-d088-392e363fb41f@redhat.com>
         <CAJZ5v0jw3Rzjkb3J2_XE7TPBjT+7FUW90B7kg15z6_WpdNGjzA@mail.gmail.com>
         <CAHp75Vc-Vz-QRAkrq2z3B9MaAPFEVX06ePAJuxjwqcLULjRbFw@mail.gmail.com>
         <CAJZ5v0guq1zRwU8ETe5+n6QSj+ytg_HewnrP7h2TsJFQNE9gxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42470 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdFIIYH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 04:24:07 -0400
In-Reply-To: <CAJZ5v0guq1zRwU8ETe5+n6QSj+ytg_HewnrP7h2TsJFQNE9gxg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Fri, 2017-06-09 at 02:30 +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 8, 2017 at 7:40 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jun 8, 2017 at 8:15 PM, Rafael J. Wysocki <rafael@kernel.org
> > > wrote:
> > > On Thu, Jun 8, 2017 at 6:45 PM, Hans de Goede <hdegoede@redhat.com
> > > > wrote:
> > > > On 06/08/2017 05:45 PM, Darren Hart wrote:
> > > > > On Wed, Jun 07, 2017 at 05:53:38PM +0300, Andy Shevchenko
> > > > > wrote:
> > > > > > On Fri, Jun 2, 2017 at 6:15 PM, Hans de Goede <hdegoede@redh
> > > > > > at.com>
> > > > > > wrote:
> > > > > Will you be taking this through fixes Andy? For a 4.12-rc*
> > > > > target per
> > > > > Hans'
> > > > > response to the cover letter?
> > > > Note that Rafael is planning to drop (revert) the commit which
> > > > makes
> > > > it (extra) desirable for this driver to get into 4.12, so we
> > > > should
> > > > perhaps reconsider that. I'm fine either way, but the primary
> > > > reason
> > > > to push this as a fix for 4.12 is no longer valid AFAICT.
> > > 
> > > Maybe I will just queue it up along with this series:
> > > http://marc.info/?l=linux-kernel&m=149688087904433&w=2
> > > if Andy and Darren agree?
> > 
> > Looks like it has ties to your series, so, I see no obstacles to go
> > via PM tree.
> 
> OK, thanks!

I removed it from our testing branch, feel free to apply any time.

> > Darren?
> 
> An ACK or equivalent from Linus W would be good to have too ...
> 

I was waiting for it about week and decided to proceed w.o. one.
Linus is overloaded by something, though he appears from time to time in
mailing lists.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
