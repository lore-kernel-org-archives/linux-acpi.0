From: Thomas Renninger <trenn@suse.de>
Subject: Re: hwapci-0142 error (dmidecode)
Date: Wed, 23 Jul 2008 12:56:04 +0200
Message-ID: <200807231256.05113.trenn@suse.de>
References: <20080720001417.GA22429@eorbit.net> <20080720023327.GA6026@eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50109 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYGWK4H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jul 2008 06:56:07 -0400
In-Reply-To: <20080720023327.GA6026@eorbit.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Collins <chris@eorbit.net>
Cc: linux-acpi@vger.kernel.org

On Sunday 20 July 2008 04:33:27 Chris Collins wrote:
> On Sat, Jul 19, 2008 at 05:14:17PM -0700, Chris Collins wrote:
> > Hello,
> >
> > ACPI doesn't work on my desktop, a VIA Apollo MVP3 chipset.
>
> Hello,
>
> In re-reading the ACPI-HOWTO I see that the output from
> dmidecode is helpful, so here you go:
> (I've never seen this before...cool.)
>
> ******dmidecode******
>
> chris@darkstar:/home/chris# cat dmi.txt
> # dmidecode 2.9
> SMBIOS 2.1 present.
> 33 structures occupying 870 bytes.
> Table at 0x000F0800.
>
> Handle 0x0000, DMI type 0, 19 bytes
> BIOS Information
>         Vendor: Award Software International, Inc.
>         Version: 4.51 PG
>         Release Date: 12/21/00
This machine/BIOS is rather old?
You should better stay with ACPI switched off.

You could search for a BIOS update and try again, but I expect it won't help.

        Thomas
