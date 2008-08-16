From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Fri, 15 Aug 2008 21:47:14 -0700
Message-ID: <20080816044714.GA19886@kroah.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <20080814083828.d10e126d.randy.dunlap@oracle.com> <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com> <20080815085836.67e420f1.randy.dunlap@oracle.com> <1218854219.3629.30.camel@lgn.site> <48A64235.2030108@linux.intel.com> <1218856798.3629.45.camel@lgn.site> <48A64E0A.8090408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33401 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbYHPEs2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Aug 2008 00:48:28 -0400
Content-Disposition: inline
In-Reply-To: <48A64E0A.8090408@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rusty@rustcorp.com.au

On Sat, Aug 16, 2008 at 05:48:26AM +0200, Andi Kleen wrote:
>
>> They have been module options, not prefixed kernel parameters so far=
,
>> and the prefix was just the module name.
>> So it just strikes back, that acpi uses generic names for the module=
s,
>> there would have been no problem if "power" would be called "acpi_po=
wer"
>> and the options would just be =EF=BB=BF"acpi.acpica_version" and
>> "acpi_power.nocheck".
>> But well, there are driver modules just called "option", so acpi is =
not
>> that bad. :)
>>> I think the generic params code should be fixed to handle this.
>> We could try to look up existing directories to use instead of expec=
ting
>> that we need to create and own them. I guess,
>
> sysfs does this anyways, doesn't it. We would just need to teach it
> to not BUG() in this case, perhaps with a special entry point.
> Also a BUG() in general seems a little harsh for this, surely a WARN_=
ON
> should be enough.

It is a WARN() call, not a BUG().

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
