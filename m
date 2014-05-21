From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCHv2 2/4] ACPI / LPSS: custom power domain for LPSS
Date: Wed, 21 May 2014 13:52:58 +0300
Message-ID: <20140521105258.GB29349@xps8300>
References: <1400161226-24067-1-git-send-email-heikki.krogerus@linux.intel.com>
 <3202918.AHHS8JP9gx@vostro.rjw.lan>
 <20140521100511.GA29349@xps8300>
 <4546817.Xm9e491t74@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4546817.Xm9e491t74@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mike Turquette <mturquette@linaro.org>, Jin Yao <yao.jin@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 21, 2014 at 01:01:31PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 21, 2014 01:05:11 PM Heikki Krogerus wrote:
> > On Tue, May 20, 2014 at 11:33:09PM +0200, Rafael J. Wysocki wrote:
> > > First, is the 10 ms sleep really necessary?  I'd expect the AML to take care of
> > > such delays (this is not a PCI device formally).
> > 
> > Unfortunately that is not the case. There is nothing in the AML for
> > this. Mika, correct me if I'm wrong.
> > 
> > > And because this is not a PCI device formally, why is the comment talking about
> > > the PCI spec?  Why is PCI relevant in any way here?
> > 
> > Under the hood the devices are still PCI devices, even if they
> > formally aren't. Maybe I should point that out in the comment..
> > 
> > We put the sleep there because without it there was no guarantee if
> > the device was properly resumed by the time the drivers resume hooks
> > were called. The symptom in case of a failure was simply that the
> > registers could not be written, which leads into timeouts at least in
> > case of the I2C and UART and making them unusable until the next
> > suspend followed by resume.
> 
> OK, so the msleep() is functionally necessary.  Instead of talking about the
> PCI in the comment, which will make a casual reader think "What the heck?",
> please say something like "the delay is necessary for the subsequent register
> writes to succeed on <example system>".

OK.

Thanks,

-- 
heikki
