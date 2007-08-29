From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module, take 3
Date: Wed, 29 Aug 2007 02:16:59 -0400
Message-ID: <200708290216.59248.lenb@kernel.org>
References: <200708290031.l7T0VUu3005216@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40620 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbXH2GRO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Aug 2007 02:17:14 -0400
In-Reply-To: <200708290031.l7T0VUu3005216@turbo.physics.adelaide.edu.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org


> +static int __init fujitsu_init(void)
> +{
> +	int ret, result;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	fujitsu = kmalloc(sizeof(struct fujitsu_t), GFP_KERNEL);
> +	if (!fujitsu)
> +		return -ENOMEM;
> +	memset(fujitsu, 0, sizeof(struct fujitsu_t));
> +
> +	result = acpi_bus_register_driver(&acpi_fujitsu_driver);
> +	if (result < 0) {
> +		goto fail_acpi;
> +	}

if this goto is taken, then "ret" is used uninitialized below:

> +      fail_acpi:
> +
> +	kfree(fujitsu);
> +
> +	return ret;
> +}

