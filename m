From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 06/12] ACPI / property: Don't limit named child node
 matching to data nodes
Date: Thu, 11 Apr 2019 16:02:33 +0300
Message-ID: <20190411130233.GA29292@kuha.fi.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
 <20190410152505.87041-7-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410152505.87041-7-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Apr 10, 2019 at 06:24:59PM +0300, Heikki Krogerus wrote:
> There is no reason why we should limit the use of
> fwnode_get_named_child_node() to data nodes only.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 77abe0ec4043..c3fb52c387a6 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -602,15 +602,29 @@ static struct fwnode_handle *
>  acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  				 const char *childname)
>  {
> +	char name[ACPI_PATH_SEGMENT_LENGTH];
>  	struct fwnode_handle *child;
> +	struct acpi_buffer path;
> +	acpi_status status;
>  
> -	/*
> -	 * Find first matching named child node of this fwnode.
> -	 * For ACPI this will be a data only sub-node.
> -	 */
> -	fwnode_for_each_child_node(fwnode, child)
> -		if (acpi_data_node_match(child, childname))
> +	path.length = sizeof(name);
> +	path.pointer = name;
> +
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (is_acpi_data_node(child)) {
> +			if (acpi_data_node_match(child, childname))
> +				return child;
> +			continue;
> +		}
> +
> +		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
> +				       ACPI_SINGLE_NAME, &path);
> +		if (ACPI_FAILURE(status))
> +			break;
> +
> +		if (!strncmp(name, childname, ACPI_NAME_SIZE))

I rebased these on of todays linux-next, and noticed that Bob renamed
ACPI_NAME_SIZE to ACPI_NAMESEG_SIZE in commit 3278675567df ("ACPICA:
Rename nameseg length macro/define for clarity").

I'll fix that and resend these tomorrow.

thanks,

-- 
heikki
