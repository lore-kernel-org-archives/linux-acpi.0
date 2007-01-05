From: Len Brown <lenb@kernel.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 12:33:20 -0500
Message-ID: <200701051233.20366.lenb@kernel.org>
References: <459D4051.9020506@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46746 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422650AbXAERd4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 12:33:56 -0500
In-Reply-To: <459D4051.9020506@tlen.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Cc: linux-acpi@vger.kernel.org

On Thursday 04 January 2007 12:58, Cacy Rodney wrote:
> Hello everyone!
> 
> I know that the thread is much further but I'd like to inform the 
> maintainer (whoever is) that the driver v0.2 (there is v0.3 but in this 
> context it is not important) with the updated sony_acpi_values structure 
> (enclosed at the end) is working and gives me about 20% of energy 
> conservation.
> By clear, I have Sony Vaio SZ2.
> The cdpower(cdrom),sound,lan files in sony directory can power off 
> (_PS3) the relevant devices. To do that
> 
> echo 0 >/proc/acpi/sony/cdpower etc.
> 
> To ON the devices
> 
> echo 1 >/proc/acpi/sony/cdpower etc.
> 
> (unfortunately, after the commend sequence the lan card is not 
> initialized properly and to use it again the computer must be rebooted - 
> but i'm working to change it :))
> 
> The acpi methods of SNC are:
> 
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GBRT, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SBRT, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GPBR, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SPBR, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: PWAK, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: PWRN, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CSXB, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GWDP, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CDPW, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GCDP, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SLRS, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: RBMF, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: RSBI, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CBMF, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: AZPW, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GAZP, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: LNPW, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GLNP, args 0
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SCAM, args 1
> Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GCAM, args 0
> 
> Anyone knows what the rest do?
> 
> Best regards
> Cacy
> 
> 
> } sony_acpi_values[] = {
>          {
>                  .name           = "brightness",
>                  .acpiget        = "GBRT",
>                  .acpiset        = "SBRT",
>                  .min            = 1,
>                  .max            = 8,
>                  .debug          = 0,
>          },
>          {
>                  .name           = "brightness_default",
>                  .acpiget        = "GPBR",
>                  .acpiset        = "SPBR",
>                  .min            = 1,
>                  .max            = 8,
>                  .debug          = 0,
>          },
>          {
>                  .name           = "cdpower",
>                  .acpiget        = "GCDP",
>                  .acpiset        = "CDPW",
>                  .min            = 0,
>                  .max            = 1,
>                  .debug          = 0,
>          },
>          {
>                  .name           = "sound",
>                  .acpiget        = "GAZP",
>                  .acpiset        = "AZPW",
>                  .min            = 0,
>                  .max            = 1,
>                  .debug          = 0,
>          },
>          {
>                  .name           = "lan",
>                  .acpiget        = "GLNP",
>                  .acpiset        = "LNPW",
>                  .min            = 0,
>                  .max            = 1,
>                  .debug          = 0,
>          },
>          {
>                  .name           = NULL,
>          }
> };

With /proc/acpi/ going away, this raises the question of where sony_acpi should put stuff
that is under development -- as unlike brightness -- it will not have a generic home in sysfs.

To do it right,  some analysis of the DSDT which has these vendor methods in them
will be necessary.  It is conceivable that these methods can be hooked to the generic
device power management support if the "real" devices in sysfs can be found.

A word of warning, which may be totally obvious here, is that the method names above
are completely arbitrary choices on the part of a BIOS engineer at Sony, and the
next BIOS engineer can make completely different choices for what names are used
or what the same names do.

Only if we had documentation or some sort of support from Sony could we know or sure.
Happily they identified their platform device with PNPID SNY5001 -- so at least this
stuff will not run wild on non-Sony products.

cheers,
-Len
