From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI_COMPANION equivalent in older kernels
Date: Thu, 11 Jun 2015 02:02:26 +0200
Message-ID: <2623380.e8FT7OfKgL@vostro.rjw.lan>
References: <55784708.60305@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59374 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751308AbbFJXgg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 19:36:36 -0400
In-Reply-To: <55784708.60305@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, June 10, 2015 04:17:44 PM Arend van Spriel wrote:
> For backporting a driver to 3.11 kernel I would like to know how to get 
> same functionality as ACPI_COMPANION(). I did it like below, but would 
> like to have some confirmation on it.

Yes, that should work in general.

> --8<------------------------------------------------------------------
> static inline
> struct acpi_device *_acpi_get_companion(struct device *dev)
> {
> 	struct acpi_device *adev;
> 	int ret;
> 
> 	ret = acpi_bus_get_device(ACPI_HANDLE(dev), &adev);
> 	if (ret < 0)
> 		adev = NULL;
> 
> 	return adev;
> }
> #define ACPI_COMPANION(dev)	_acpi_get_companion(dev)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
