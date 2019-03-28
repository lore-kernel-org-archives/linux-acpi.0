From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Thu, 28 Mar 2019 13:51:42 +0200
Message-ID: <20190328115142.k75ijhviovhly25g@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
 <c08956873f4dfd7dc8bd918bf59443de9c2c7b33.camel@perches.com>
 <20190328114845.giusyarjibvg5ru7@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328114845.giusyarjibvg5ru7@kekkonen.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 01:48:45PM +0200, Sakari Ailus wrote:
> I actually intended to leave this --- it points to anyone accidentally
> trying to use %pf to what it needs to be replaced with. But the Deprecated
> should be replaced with Invalid (i.e. remove that assignment).

This is actually already a part of an earlier patch, "[PATCH v2 4/6]
lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps".

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
