From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: FAN Processor and Thermap
Date: Fri, 20 Mar 2009 08:47:09 +0800
Message-ID: <1237510029.3640.125.camel@localhost.localdomain>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1423 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757532AbZCTAqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Mar 2009 20:46:07 -0400
In-Reply-To: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Perl <kenperl@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-03-19 at 16:18 +0800, Ken Perl wrote:
> After I replaced my mainboard, then I can see errors related to ACPI
> during the Linux booting, I can also reproduce it with command below,
>=20
> moproble fan processor thermap
>=20
> I got error "no such device",  I ever tried to append following lines
> to the /etc/modprobe.d/blacklist but can not succeed, I can still see
> same error during boot, another error is "ACPI unable to load system
> description tables",
Maybe the issue is related with the following complains:
   >=EF=BB=BFACPI unable to load system description tables",
   If so, the ACPI SSDT table is not loaded correctly.
 =20
Will you please attach the output of acpidump ?
Thanks.
>=20
> blacklist fan
> blacklist processor
> blacklist thermap
>=20
> Do these a big problem? Can anyone tell how I can fix the issue?
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
