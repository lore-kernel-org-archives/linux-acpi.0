From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation
Date: Tue, 21 Sep 2010 14:47:18 +0200
Message-ID: <20100921124718.GE18991@one.firstfloor.org>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com> <1284865235-29920-6-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56889 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab0IUMrU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2010 08:47:20 -0400
Content-Disposition: inline
In-Reply-To: <1284865235-29920-6-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

On Sun, Sep 19, 2010 at 11:00:35AM +0800, Huang Ying wrote:
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 40b01c3..a103963 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -266,13 +266,27 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
>  {
>  	int rc;
>  	u64 offset;
> +	void *src, *dst;
> +
> +	/* ioremap does not work in interrupt context */
> +	if (in_interrupt())
> +		return -EBUSY;

That breaks serialization of machine checks no? If the BIOS uses MOVE_DATA
How about using kmap_atomic instead?

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
