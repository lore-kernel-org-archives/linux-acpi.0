From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Date: Sun, 31 Mar 2019 01:42:13 -0500
Message-ID: <5ca06147.1c69fb81.f8db8.1219@mx.google.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> The prefix is used for printing purpose before a node, and it also works
> as a separator between two nodes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c  | 22 ++++++++++++++++++++++
>  drivers/base/property.c  | 12 ++++++++++++
>  drivers/of/property.c    | 10 ++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/fwnode.h   |  2 ++
>  include/linux/property.h |  1 +
>  5 files changed, 47 insertions(+)
