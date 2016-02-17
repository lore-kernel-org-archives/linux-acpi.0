From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] acpi/ec: Deny write access unless requested by module param
Date: Wed, 17 Feb 2016 15:27:31 +0100
Message-ID: <2729982.5vh6UKHT1H@skinner>
References: <1454742488-2231898-1-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37572 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423401AbcBQO1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Feb 2016 09:27:33 -0500
In-Reply-To: <1454742488-2231898-1-git-send-email-green@linuxhacker.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: green@linuxhacker.ru
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, February 06, 2016 02:08:08 AM green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> In debugfs it's not enough to just set file mode to read-only to
> deny write access to a file, instead just don't provide
> the write method unless write access is really requested.
> 
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
Signed-off-by: Thomas Renninger <trenn@suse.com>

Thanks!

> ---
> I assume allowing run-time changes via /sys/module is preferrable,
> opposed to forced module unload and reload to change this option,
> but I can submit another patch to only depend on the module parameter
> too, please let me know.
> 
>  drivers/acpi/ec_sys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> index bea8e42..6c7dd7a 100644
> --- a/drivers/acpi/ec_sys.c
> +++ b/drivers/acpi/ec_sys.c
> @@ -73,6 +73,9 @@ static ssize_t acpi_ec_write_io(struct file *f, const char
> __user *buf, loff_t init_off = *off;
>  	int err = 0;
> 
> +	if (!write_support)
> +		return -EINVAL;
> +
>  	if (*off >= EC_SPACE_SIZE)
>  		return 0;
>  	if (*off + count >= EC_SPACE_SIZE) {

