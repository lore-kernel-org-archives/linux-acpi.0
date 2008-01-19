From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from Slackware 12.0 on Notebook HP Pavilion dv6000 - 30B7
Date: Fri, 18 Jan 2008 23:14:11 -0500
Message-ID: <200801182314.11875.lenb@kernel.org>
References: <46F65F48.3070600@andromedacomm.com> <46F7926C.8010901@andromedacomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47516 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760798AbYASEO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:14:29 -0500
In-Reply-To: <46F7926C.8010901@andromedacomm.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Schon <michael.schon@andromedacomm.com>
Cc: linux-acpi@vger.kernel.org

On Monday 24 September 2007 06:33, Michael Schon wrote:
> > System Information
> > =A0 =A0 =A0 =A0 Manufacturer: Hewlett-Packard
> > =A0 =A0 =A0 =A0 Product Name: HP Pavilion dv6000 (RK415AV)
> > =A0 =A0 =A0 =A0 Version: Rev 1
> > =A0 =A0 =A0 =A0 Serial Number: BRB70907PY
> > =A0 =A0 =A0 =A0 UUID: 42524237-3039-3037-5059-0019BBF8B1E9
> > =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> > =A0 =A0 =A0 =A0 SKU Number: RK415AV)
> > =A0 =A0 =A0 =A0 Family: 103C_5335KV
> >
> > Handle 0x0002, DMI type 2, 8 bytes
> > Base Board Information
> > =A0 =A0 =A0 =A0 Manufacturer: Quanta
> > =A0 =A0 =A0 =A0 Product Name: 30B7

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
