From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Date: Tue, 16 Oct 2018 17:46:22 +0300
Message-ID: <20181016144622.GG24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 16, 2018 at 05:35:50PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 12, 2018 at 2:41 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi guys,
> >
> > To continue the discussion started by Dmitry [1], this is my proposal
> > that I mentioned in my last mail. In short, the idea is that instead
> > of trying to extend the support for the currently used struct
> > property_set, I'm proposing that we introduce a completely new,
> > independent type of fwnode, and replace the struct property_set with
> > it. I'm calling the type "software node" here.
> >
> > The reason for a complete separation of the software nodes from the
> > generic property handling code is the need to be able to create the
> > nodes independently from the devices that they are bind to.
> >
> > The way this works is that every node that is created will have a
> > kobject registered. That will take care the ref counting for us, and
> > also allow us to for example display the properties in sysfs.
> >
> > There are a few more details in patch 3/5 about the software nodes in
> > the commit message.
> >
> > [1] https://lkml.org/lkml/2018/9/17/1067
> 
> In private discussion I brought a concern that we exposed properties
> as a part of ABI, but at the same time we have not strict rules which
> might lead to ambiguous reading, e.g. there is no type exported and
> thus no possibility to tell what kind of property it is.
> 
> Examples:
> 1. 0x1 and 0x1 ??? are they of the same type?
> 2. 0x1 ??? is it an array or single value?
> 3. 0x12345678 ??? is it string or hex?
> 4. 25 ??? is it hex or decimal?
> 
> Until these will not be solved, better to not to expose properties to userspace.

I agree. I'll drop that part from my final version.


Thanks Andy,

-- 
heikki
