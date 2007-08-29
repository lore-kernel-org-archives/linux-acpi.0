From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module, take 3
Date: Wed, 29 Aug 2007 02:13:58 -0400
Message-ID: <200708290213.58261.lenb@kernel.org>
References: <200708290031.l7T0VUu3005216@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56458 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbXH2GOP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Aug 2007 02:14:15 -0400
In-Reply-To: <200708290031.l7T0VUu3005216@turbo.physics.adelaide.edu.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org


> +	fujitsu->bl_device->props.max_brightness = FUJITSU_LCD_N_LEVELS - 1,

did you intend to use a ';' here?

> +	    ret = platform_driver_register(&fujitsupf_driver);
> +	if (ret)
> +		goto fail_backlight;
