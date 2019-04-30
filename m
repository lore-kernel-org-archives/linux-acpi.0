From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in
 acpi_get_next_subnode()
Date: Tue, 30 Apr 2019 19:30:41 +0300
Message-ID: <20190430163041.GN9224@smile.fi.intel.com>
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 10:52:29AM -0500, Pierre-Louis Bossart wrote:
> When the DSDT tables expose devices with subdevices and a set of
> hierarchical _DSD properties, the data returned by
> acpi_get_next_subnode() is incorrect, with the results suggesting a bad
> pointer assignment. The parser works fine with device_nodes or
> data_nodes, but not with a combination of the two.
> 
> The problem is traced to an invalid pointer used when jumping from
> handling device_nodes to data nodes. The existing code looks for data
> nodes below the last subdevice found instead of the common root. Fix
> by forcing the acpi_device pointer to be derived from the same fwnode
> for the two types of subnodes.
> 
> This same problem of handling device and data nodes was already fixed
> in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
> node parsing in acpi_get_next_subnode()")' but broken later by 'commit
> 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
> this should probably go to linux-stable all the way to 4.12

Period is missed in above sentence.

I think it make sense to add Fixes: tag.

Nevertheless,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for fixing this interesting issue!

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/acpi/property.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 5815356ea6ad..efc74f912f39 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -943,6 +943,16 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  		const struct acpi_data_node *data = to_acpi_data_node(fwnode);
>  		struct acpi_data_node *dn;
>  
> +		/*
> +		 * We can have a combination of device and data nodes,
> +		 * e.g. with hierarchical _DSD properties. Make sure
> +		 * the adev pointer is restored before going through
> +		 * data nodes, otherwise we will be looking for
> +		 * data_nodes below the last device found instead of
> +		 * the common fwnode shared by device_nodes and
> +		 * data_nodes
> +		 */
> +		adev = to_acpi_device_node(fwnode);
>  		if (adev)
>  			head = &adev->data.subnodes;
>  		else if (data)
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko
