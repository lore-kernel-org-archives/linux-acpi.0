From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPI info has non-printable chars
Date: Wed, 13 Jan 2010 09:02:10 +0800
Message-ID: <1263344530.3598.54.camel@minggr.sh.intel.com>
References: <87d699441001121415y6b37ed63v25b1913ccc959d46@mail.gmail.com>
	 <1263344599.12263.2251.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28732 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662Ab0AMBSB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jan 2010 20:18:01 -0500
In-Reply-To: <1263344599.12263.2251.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-01-13 at 09:03 +0800, Zhang, Rui wrote:
> CC Lin Ming, the ACPICA expert.
> 
> On Wed, 2010-01-13 at 06:15 +0800, Ilia Mirkin wrote:
> > Hi,
> > 
> > I just got a new motherboard (GIGABYTE GA-EX58-UD3R) and I'm seeing
> > the following in the kernel log (2.6.31-gentoo-r6, which I believe is
> > basically 2.6.31.6)
> > 
> > ...
> > [    0.000000] ACPI: TAMG 00000000cfee7330 00AE2 (v01 GBT    GBT   B0
> > 5455312E BG^A^A 53450101)
> 
> non-printable chars in Creator ID field.
> 
> > ...
> > [    0.713697] ACPI Warning: Incorrect checksum in table [TAMG] - 9D,
> > should be 9C 20090521 tbutils-246
> > 
> > acpidump shows:
> > 
> > TAMG @ 0xcfee7330
> >   0000: 54 41 4d 47 e2 0a 00 00 01 9d 47 42 54 20 20 20  TAMG......GBT
> >   0010: 47 42 54 20 20 20 42 30 2e 31 55 54 42 47 01 01  GBT   B0.1UTBG..
> >   0020: 01 01 45 53 44 54 3d 20 ef 00 08 00 0f 00 2c 01  ..ESDT= ......,.
> > 
> > So those ^A's are really in there, but it's a little annoying (and it
> > causes less to go into binary viewing mode when it shows up in
> > /var/log/messages). Would it be reasonable to add some kind of
> > escaping code for such situations so that it might print like
> > "BG\x01\x01"?
> > 
> 
> Ming, any comments on this?

Ilia, would you please attach the acpidump output?

Lin Ming



