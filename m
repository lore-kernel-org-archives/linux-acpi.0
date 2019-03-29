From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Date: Fri, 29 Mar 2019 17:31:57 +0200
Message-ID: <20190329153157.hj2b4mjgfh5q5e2q@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <20190328141036.mbns3ei4agnginsg@pathway.suse.cz>
 <20190329130436.4fxzki5kljprhyai@kekkonen.localdomain>
 <20190329141419.GY9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329141419.GY9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

On Fri, Mar 29, 2019 at 04:14:19PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 29, 2019 at 03:04:36PM +0200, Sakari Ailus wrote:
> > On Thu, Mar 28, 2019 at 03:10:36PM +0100, Petr Mladek wrote:
> 
> > You basically have to have a reference to a node until you're done
> > accessing it. The refcounting in the fwnode framework is based on the OF
> > API --- otherwise you couldn't access OF nodes using the framework.
> 
> > ACPI
> > does not have those (as you can't dynamically remove nodes).
> 
> What about configfs where we can load / unload tables at run time?

Hmm. I have to admit I missed this one.

Well, I guess that this feature depends on the user making sure there are
no references to the tables that are to be removed, as there is no
refcounting. Let me know if I'm missing something, but nothing appears to
prevent releasing nodes that are in use.

If that is really so, then refcounting or another mechanism to achieve
something similar should be added to make removal safe, but this isn't
related to printing the node names anymore nor such fixes belong to this
patchset.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
