From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] platform samsung-q10: use ACPI instead of direct EC
 calls
Date: Mon, 08 Jul 2013 11:36:54 -0400
Message-ID: <1373297814.24233.5.camel@x230.lan>
References: <20130703212737.GC5579@lat.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20130703212737.GC5579@lat.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Frederick van der Wyck <fvanderwyck@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-07-03 at 22:27 +0100, Frederick van der Wyck wrote:

> +#define EC_HID "PNP0C09"

This is probably wrong - you should be able to just use first_ec
directly rather than probing yourself.
> +	for (i = 0; i < SAMSUNGQ10_BL_MAX_INTENSITY; i++) {
> +		status = acpi_evaluate_object(ec_handle, "_Q63", NULL, NULL);

The potential problem here is that there's no guarantee that these event
numbers are stable, and a firmware upgrade could change them. Of course,
that's also true of the EC registers, but we haven't had anyone complain
about the driver suddenly breaking so I'm not hugely enthusiastic about
replacing one fragile but seemingly working method with a fragile but
unproven one. 

-- 
Matthew Garrett <mjg59@srcf.ucam.org>
