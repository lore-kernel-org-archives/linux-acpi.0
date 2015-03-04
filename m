From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] x86: pmc_atom: Add Cherrytrail support
Date: Wed, 04 Mar 2015 12:44:53 +0200
Message-ID: <1425465893.14897.163.camel@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1424695552.14897.7.camel@linux.intel.com>
	 <54F52C8E.2050705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F52C8E.2050705@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2015-03-03 at 11:37 +0800, Li, Aubrey wrote:
> On 2015/2/23 20:45, Andy Shevchenko wrote:
> > On Tue, 2015-01-20 at 23:49 +0200, Andy Shevchenko wrote:
> >> This is the reworked patch series which had been sent earlier [1] to support
> >> Intel CherryTrail SoC.
> >>
> >> The patches were tested on both BayTrail and CherryTrail SoCs.
> >>
> >> [1] https://patchwork.kernel.org/patch/5235891/
> > 
> > Aubrey, is everything is clear for you now? Can I send v3 with your
> > Ack's?

> The patches overall look good to me, except a few minor comments need to
> be addressed in the last conversation. For example, I think we don't
> need patch 1/4 if we won't use dev_print.

We still use them. Like I said the patch has no relations to the series,
though it simplifies already existing function.


>  some other changes might be
> necessary only if they makes code cleaner and works better.

Thus, I think the patch 1/4 is still useful.

> Certainly, it would be better if other x86 maintainers can take a look
> at these patches.

Agree.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
