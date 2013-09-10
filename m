From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] MAINTAINERS: Update ACPI git tree
Date: Tue, 10 Sep 2013 21:24:36 +0200
Message-ID: <4081683.00Tr2EONhd@vostro.rjw.lan>
References: <1378820101-28243-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42022 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab3IJTNe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Sep 2013 15:13:34 -0400
In-Reply-To: <1378820101-28243-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tuesday, September 10, 2013 04:35:01 PM Jarkko Nikula wrote:
> Update ACPI git tree URL since recent ACPI updates are merged from
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> and since there hasn't been updates for a while in
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I'm going to apply this, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87efa1f..95f7f83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -241,7 +241,7 @@ M:	Rafael J. Wysocki <rjw@sisk.pl>
>  L:	linux-acpi@vger.kernel.org
>  W:	http://www.lesswatts.org/projects/acpi/
>  Q:	http://patchwork.kernel.org/project/linux-acpi/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>  S:	Supported
>  F:	drivers/acpi/
>  F:	drivers/pnp/pnpacpi/
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
