From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 09/12] platform/x86: intel_cht_int33fe: Provide
 software nodes for the devices
Date: Thu, 11 Apr 2019 16:35:46 +0300
Message-ID: <20190411133546.GA25743@kuha.fi.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
 <20190410152505.87041-10-heikki.krogerus@linux.intel.com>
 <CAHp75Vde9rX7XaVuUyn_mozwr1VFtCNVYzkerGE4DXT_hp_wPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vde9rX7XaVuUyn_mozwr1VFtCNVYzkerGE4DXT_hp_wPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 11, 2019 at 04:31:51PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Software nodes provide two features that we will need later.
> > 1) Software nodes can have references to other software nodes.
> > 2) Software nodes can exist before a device entry is created.
> >
> 
> It seems does two things in one patch, and the first one is not
> mentioned in the commit message.
> I would suggest to create a preparation patch which extracts finding
> and registering max17047 device followed by what you do here.

OK, I'll split the patch.

thanks,

-- 
heikki
