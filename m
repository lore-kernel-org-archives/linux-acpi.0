From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH/RFC 1/4]device core changes
Date: Wed, 10 Nov 2004 04:28:22 +0000
Message-ID: <20041110042822.A13318@flint.arm.linux.org.uk>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com> <20041108225810.GB16197@kroah.com> <1099961418.15294.11.camel@sli10-desk.sh.intel.com> <1099971341.15294.48.camel@sli10-desk.sh.intel.com> <20041109045843.GA4849@kroah.com> <1099990981.15294.57.camel@sli10-desk.sh.intel.com> <20041110012443.GA9496@kroah.com> <1100051137.7825.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261858AbUKJE2v@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1100051137.7825.6.camel@sli10-desk.sh.intel.com>; from shaohua.li@intel.com on Wed, Nov 10, 2004 at 09:45:37AM +0800
Sender: linux-kernel-owner@vger.kernel.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Patrick Mochel <mochel@digitalimplant.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2004 at 09:45:37AM +0800, Li Shaohua wrote:
> On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > Maybe your other patches weren't so bad...  If we implement them, can we
> > drop the platform notify stuff?
> Currently only ARM use 'platform_notify', and we can easily convert it
> to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
> is we will have many '#ifdef ..' if many platforms implement their
> per-bus 'platform_bind'.

Except none of the merged ARM platforms use platform_notify, and I haven't
seen any suggestion in the ARM world of why it would be needed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
