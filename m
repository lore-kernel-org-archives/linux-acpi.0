From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][next][RESEND] drivers: base: remove need for a temporary string for the node name
Date: Mon, 17 Dec 2018 12:39:03 +0100
Message-ID: <2449257.d8gDasH2Fh@aspire.rjw.lan>
References: <20181206170557.27834-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206170557.27834-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 6, 2018 6:05:57 PM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the node name is being formatting into a temporary string
> node_name, however, kobject_init_and_add allows one to format up
> a node name, so use that instead. This removes the need for the
> node_name string and also cleans up the following warning:
> 
> Fixes clang warning:
> warning: format string is not a string literal (potentially
> insecure) [-Wformat-security]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/swnode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 9c63ec8d8ab4..306bb93287af 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -553,7 +553,6 @@ fwnode_create_software_node(const struct property_entry *properties,
>  {
>  	struct software_node *p = NULL;
>  	struct software_node *swnode;
> -	char node_name[20];
>  	int ret;
>  
>  	if (parent) {
> @@ -576,8 +575,6 @@ fwnode_create_software_node(const struct property_entry *properties,
>  	}
>  
>  	swnode->id = ret;
> -	sprintf(node_name, "node%d", swnode->id);
> -
>  	swnode->kobj.kset = swnode_kset;
>  	swnode->fwnode.ops = &software_node_ops;
>  
> @@ -590,7 +587,7 @@ fwnode_create_software_node(const struct property_entry *properties,
>  		list_add_tail(&swnode->entry, &p->children);
>  
>  	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> -				   p ? &p->kobj : NULL, node_name);
> +				   p ? &p->kobj : NULL, "node%d", swnode->id);
>  	if (ret) {
>  		kobject_put(&swnode->kobj);
>  		return ERR_PTR(ret);
> 

Applied, thanks!
