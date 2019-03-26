From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 16:13:07 +0100
Message-ID: <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322152930.16642-6-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri 2019-03-22 17:29:30, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
> On ACPI based systems the resulting strings look like
> 
> 	\_SB.PCI0.CIO2.port@1.endpoint@0
> 
> where the nodes are separated by a dot (".") and the first three are
> ACPI device nodes and the latter two ACPI data nodes.
> 
> Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")

Reusing obsolete modifiers is dangerous from many reasons:

   + people might miss the change of the meaning
   + backporting mistakes
   + 3rd party modules

It might be acceptable if the long term gain is bigger
than a short time difficulties. But it would be better
to it a safe way when possible.

Fortunately, we could keep the backward compatibility
for "%pf" and handle only "%pfw*" with the fwnode api.

Best Regards,
Petr
