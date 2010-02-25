From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared
 GPEs
Date: Thu, 25 Feb 2010 18:14:08 +0300
Message-ID: <4B8693C0.4020701@gmail.com>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com> <201002200014.04936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:45804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0BYPOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2010 10:14:10 -0500
Received: by fg-out-1718.google.com with SMTP id e12so206530fga.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2010 07:14:09 -0800 (PST)
In-Reply-To: <201002200014.04936.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>

Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> --- linux-2.6.orig/drivers/acpi/ec.c
> +++ linux-2.6/drivers/acpi/ec.c
> @@ -307,7 +307,11 @@ static int acpi_ec_transaction(struct ac
>  	pr_debug(PREFIX "transaction start\n");
>  	/* disable GPE during transaction if storm is detected */
>  	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> -		acpi_disable_gpe(NULL, ec->gpe);
> +		/*
> +		 * It has to be disabled at the hardware level regardless of the
> +		 * GPE reference counting, so that it doesn't trigger.
> +		 */
> +		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
>  	}
>  =20
EC should have non-shared GPE, according to spec. Thus, refcounting is
not needed here anyway.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
