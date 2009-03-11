From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 4/5] ACPI video: support reversed _BCL method
Date: Wed, 11 Mar 2009 01:45:10 +0000
Message-ID: <20090311014510.GA13760@srcf.ucam.org>
References: <1236672211.2820.122.camel@rzhang-dt> <20090310171136.GD2527@srcf.ucam.org> <1236735775.2820.160.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35156 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZCKBpP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 21:45:15 -0400
Content-Disposition: inline
In-Reply-To: <1236735775.2820.160.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, Mar 11, 2009 at 09:42:55AM +0800, Zhang Rui wrote:

> The index value returned by _BQC is the index in the PCTG package.
> if the _BCL package is in a reversed order, we can not use this index=
 to
> get the value in =EF=BB=BFdevice->brightness->levels[].
> For example, if the current brightness is 0x64, _BQC returns 0 in thi=
s
> case, but we can not translate this to value 0x14, we need a flag to
> tell us that _BCL is reversed.
>=20
> But in the non-indexed case, _BQC always returns a percentage that ca=
n
> be used directly by ACPI video driver, i.e. we don't need to parse
> device->brightness->levels to get the real value. so we don't need to
> check the =EF=BB=BFdevice->brightness->flags._BCL_reversed bit.

Ah, of course. Sorry, I should have got that. Thanks for the=20
explanation!

Acked-by: Matthew Garrett <mjg@redhat.com>

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
