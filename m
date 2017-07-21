From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] MAINTAINERS: device property: acpi: add fwnode.h
Date: Sat, 22 Jul 2017 00:03:41 +0200
Message-ID: <2851122.8a0ts3VkAi@aspire.rjw.lan>
References: <1500578005-25893-1-git-send-email-frowand.list@gmail.com> <1500578005-25893-2-git-send-email-frowand.list@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47507 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753111AbdGUWLf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 18:11:35 -0400
In-Reply-To: <1500578005-25893-2-git-send-email-frowand.list@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, July 20, 2017 12:13:24 PM frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> ACPI is impacted by changes to fwnode.h, add a file entry
> to ACPI
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

ACK for this one.

Or do you want me to apply it?

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d3977ac46..c0ac362e850a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -302,6 +302,7 @@ S:	Supported
>  F:	drivers/acpi/
>  F:	drivers/pnp/pnpacpi/
>  F:	include/linux/acpi.h
> +F:	include/linux/fwnode.h
>  F:	include/acpi/
>  F:	Documentation/acpi/
>  F:	Documentation/ABI/testing/sysfs-bus-acpi
> 

