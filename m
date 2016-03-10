From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/ec: Deny write access unless requested by module param
Date: Fri, 11 Mar 2016 00:32:21 +0100
Message-ID: <4293761.4xFOzkxIam@vostro.rjw.lan>
References: <1454742488-2231898-1-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55306 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753838AbcCJXa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:30:27 -0500
In-Reply-To: <1454742488-2231898-1-git-send-email-green@linuxhacker.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: green@linuxhacker.ru
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, February 06, 2016 02:08:08 AM green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> In debugfs it's not enough to just set file mode to read-only to
> deny write access to a file, instead just don't provide
> the write method unless write access is really requested.
> 
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
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
> @@ -73,6 +73,9 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
>  	loff_t init_off = *off;
>  	int err = 0;
>  
> +	if (!write_support)
> +		return -EINVAL;
> +
>  	if (*off >= EC_SPACE_SIZE)
>  		return 0;
>  	if (*off + count >= EC_SPACE_SIZE) {
> 

Applied, thanks!

Rafael

