From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers/acpi/utils.c: Fixed coding style issues
Date: Mon, 02 May 2011 17:26:45 -0700
Message-ID: <1304382405.7792.53.camel@Joe-Laptop>
References: <1303341624.11397.2.camel@ks-ubuntu>
	 <20110421102815.5abf133e@absol.kitzblitz>
	 <1303402099.11855.9.camel@ks-ubuntu>  <1304374605.1619.4.camel@ks-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1153 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231Ab1ECA0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 May 2011 20:26:47 -0400
In-Reply-To: <1304374605.1619.4.camel@ks-ubuntu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karthigan Srinivasan <karthigan.srinivasan@hp.com>
Cc: Len Brown <lenb@kernel.org>, Nicolas Kaiser <nikai@nikai.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2011-05-02 at 17:16 -0500, Karthigan Srinivasan wrote:
>  drivers/acpi/utils.c |   15 ++++++---------
> @@ -373,7 +370,7 @@ acpi_evaluate_reference(acpi_handle handle,
>        end:
>  	if (ACPI_FAILURE(status)) {
>  		list->count = 0;
> -		//kfree(list->handles);
> +		/* kfree(list->handles); */

Just delete the line instead.


