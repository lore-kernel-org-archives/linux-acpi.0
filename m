From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH V2 1/4] mailbox: add support for APM X-Gene platform
 mailbox driver
Date: Fri, 24 Apr 2015 10:25:12 +0200
Message-ID: <1429863912.2927.43.camel@x220>
References: <1429741125-29156-1-git-send-email-fkan@apm.com>
	 <1429741125-29156-2-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:38145 "EHLO
	lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965836AbbDXIZT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2015 04:25:19 -0400
In-Reply-To: <1429741125-29156-2-git-send-email-fkan@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, jassisinghbrar@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 2015-04-22 at 15:18 -0700, Feng Kan wrote:
> --- /dev/null
> +++ b/drivers/mailbox/mailbox-xgene-slimpro.c

> +static struct platform_driver slimpro_mbox_driver = {
> +	.probe	= slimpro_mbox_probe,
> +	.remove = slimpro_mbox_remove,
> +	.driver	= {
> +		.name = "xgene-slimpro-mbox",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(slimpro_of_match),
> +	},
> +};
> +
> +static int __init slimpro_mbox_init(void)
> +{
> +	return platform_driver_register(&slimpro_mbox_driver);
> +}
> +
> +subsys_initcall(slimpro_mbox_init);

After a quick scan of this driver you'd expect something like
    static void __exit slimpro_mbox_exit(void)
    {
	platform_driver_unregister(&slimpro_mbox_driver);
    }
    module_exit(slimpro_mbox_exit);

too here. At least, I do. Is there some non-obvious (to me) reason this
driver can't be unloaded if it is built as a module?

> +MODULE_DESCRIPTION("APM X-Gene SLIMpro Mailbox Driver");
> +MODULE_LICENSE("GPL");

Thanks,


Paul Bolle

