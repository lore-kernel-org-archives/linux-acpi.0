From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PNP / ACPI: Use ACPI_COMPANION_SET() during
 initialization
Date: Fri, 13 Mar 2015 17:34:16 +0200
Message-ID: <20150313153416.GS1563@lahna.fi.intel.com>
References: <1562702.j1oaNJkYhk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1562702.j1oaNJkYhk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 13, 2015 at 01:45:49AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> pnpacpi_add_device() calls acpi_bind_one() on an already registered
> device, which is a mistake, but it can initialize the ACPI companion
> field of the struct device to be registered using ACPI_COMPANION_SET()
> instead, so make it do that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
