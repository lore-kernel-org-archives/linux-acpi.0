From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/6] device property: Add fwnode_get_name for
 returning the name of a node
Date: Sun, 31 Mar 2019 01:42:10 -0500
Message-ID: <5ca06143.1c69fb81.65919.5944@mx.google.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-3-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-3-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:02PM +0200, Sakari Ailus wrote:
> The fwnode framework did not have means to obtain the name of a node. Add
> that now, in form of the fwnode_get_name() function and a corresponding
> get_name fwnode op. OF and ACPI support is included.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
>  drivers/base/property.c  | 11 +++++++++++
>  drivers/of/property.c    |  6 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/fwnode.h   |  2 ++
>  include/linux/property.h |  1 +
>  5 files changed, 44 insertions(+)
