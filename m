From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] pinctrl: baytrail: Add back Baytrail-T ACPI ID
Date: Fri, 23 May 2014 10:18:45 +0300
Message-ID: <20140523071845.GN1651@lahna.fi.intel.com>
References: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdY28sT8jG750F9n6T=NBcsuvN3ZKpOtt4e4=VWDBJr_uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY28sT8jG750F9n6T=NBcsuvN3ZKpOtt4e4=VWDBJr_uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jin Yao <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 22, 2014 at 11:50:00PM +0200, Linus Walleij wrote:
> On Thu, May 15, 2014 at 5:28 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > From: Jin Yao <yao.jin@intel.com>
> >
> > Now that the x86 dynamic IRQ allocation problem has been resolved with
> > commmit 62a08ae2a576 (genirq: x86: Ensure that dynamic irq allocation does
> > not conflict), we can add back Baytrail-T ACPI ID to the pinctrl driver.
> >
> > This makes the driver to work on Asus T100 where it is needed for several
> > things like ACPI GPIO events and SD card detection.
> >
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=68291
> > Signed-off-by: Jin Yao <yao.jin@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Patch applied with Rafael's ACK.
> 
> Applying this and 2/2 to v3.16 though, protest if there is a problem with this.

v3.16 is fine. Thanks!
