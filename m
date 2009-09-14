From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4] topstar-laptop: add new driver for hotkeys support on Topstar N01
Date: Mon, 14 Sep 2009 09:30:14 -0600
Message-ID: <200909140930.14874.bjorn.helgaas@hp.com>
References: <200909092102.22152.herton@mandriva.com.br> <200909101702.54249.bjorn.helgaas@hp.com> <200909120155.45521.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:28420 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZINPaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 11:30:13 -0400
In-Reply-To: <200909120155.45521.herton@mandriva.com.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>

On Friday 11 September 2009 10:55:45 pm Herton Ronaldo Krzesinski wrote:
> +static int acpi_topstar_remove(struct acpi_device *device, int type)
> +{
> +	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
> +
> +	acpi_topstar_fncx_switch(device, false);
> +
> +	input_unregister_device(tps_hkey->inputdev);
> +	kfree(tps_hkey);
> +	device->driver_data = NULL;

I think you should remove this "driver_data = NULL" assignment.
Clearing it in the driver helps cover up bugs like the one Alan
just fixed:
  http://marc.info/?l=linux-acpi&m=125276975701005&w=2

Bjorn
