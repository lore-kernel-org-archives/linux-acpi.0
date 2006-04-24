From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Mon, 24 Apr 2006 08:59:08 -0600
Message-ID: <200604240859.09012.bjorn.helgaas@hp.com>
References: <200604211243.32276.trenn@suse.de> <200604211918.13025.trenn@suse.de> <1145875957.3797.15.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:44681 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750837AbWDXO7Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 10:59:16 -0400
In-Reply-To: <1145875957.3797.15.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Monday 24 April 2006 04:52, Thomas Renninger wrote:
> Rethinking about this: driver_registered is a bit too general variable?
> 
> Is this OK, now?

It's static, so I don't care either way.

The powernow/speedstep/acpi code sharing seems a little strange, but
I don't know anything about it.  And you're not changing that part
of things anyway.

> @@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
>  
>  	acpi_thermal_cpufreq_exit();
>  
> +	if (processor_driver_registered){
>  	acpi_processor_uninstall_hotplug_notify();
>  
>  	acpi_bus_unregister_driver(&acpi_processor_driver);
>  
>  	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> -
> +	}

Shouldn't the remove_proc_entry() be outside the "if (processor_driver_registered)"
block?  The directory was created unconditionally, before the
acpi_bus_register_driver() call.
