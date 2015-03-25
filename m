From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] driver core: property: Update
 fwnode_property_read_string_array()
Date: Wed, 25 Mar 2015 09:29:15 +0100
Message-ID: <20150325082915.GB28023@kroah.com>
References: <1670743.YY8G2nYXVm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1670743.YY8G2nYXVm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 01:40:13AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 5c0acf3b4f96 (driver core: Add comments about returning array
> counts) forgot to update fwnode_property_read_string_array() along
> the lines of device_property_read_string_array(), although it did
> change the kerneldoc comment of it.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
