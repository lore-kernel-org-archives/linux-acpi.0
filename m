From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Date: Fri, 29 Mar 2019 16:15:49 +0200
Message-ID: <20190329141549.GZ9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
 <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
 <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com>
 <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 29, 2019 at 03:15:07PM +0200, Sakari Ailus wrote:
> On Thu, Mar 28, 2019 at 03:52:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:

> Another option would be changing where the counting starts --- the first
> parent. I.e.

Looks better to me, though can you put comment how parents are being counted?

> fwnode = fwnode_get_parent(fwnode);
> 
> for (count = 0; fwnode; count++)
> 	fwnode = fwnode_get_next_parent(fwnode);
> 
> return count;



-- 
With Best Regards,
Andy Shevchenko
