From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/6] dma: acpi-dma: parse CSRT to extract additional
 resources
Date: Mon, 08 Apr 2013 16:01:29 +0300
Message-ID: <1365426089.6652.99.camel@smile>
References: <1364374682-8547-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1364374682-8547-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20130329213350.GZ10326@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130329213350.GZ10326@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.jf.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2013-03-30 at 03:03 +0530, Vinod Koul wrote: 
> On Wed, Mar 27, 2013 at 10:57:59AM +0200, Andy Shevchenko wrote:
> > Since we have CSRT only to get additional DMA controller resources, let's get
> > rid of drivers/acpi/csrt.c and move its logic inside ACPI DMA helpers code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> for such a patch git format-patch -M is your friend. It generates patch to show
> file movement. It helps review greatly if you just move the file and then do
> additions on second patch, as diffstat tells me some changes have been done.

It obviously will not help. We are not creating new file, but moving
(quite partially) contents from one file to the _existing_ one.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
