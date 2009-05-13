From: Bob Copeland <me@bobcopeland.com>
Subject: Re: [BISECTED] Was Re: acpi/suspend - irq 9: nobody cared
Date: Wed, 13 May 2009 11:30:02 -0400
Message-ID: <b6c5339f0905130830k3549095dv3eee08d7d3155a37@mail.gmail.com>
References: <20090507105821.GA5864@hash.localnet>
	 <d3f22a0905122245h15786220g31ad0dcb8caa3a38@mail.gmail.com>
	 <1242192968.14626.40.camel@minggr.sh.intel.com>
	 <200905131015.45635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:62051 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbZEMPaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2009 11:30:04 -0400
In-Reply-To: <200905131015.45635.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lin Ming <ming.m.lin@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, yakui_zhao <yakui.zhao@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

2009/5/13 Rafael J. Wysocki <rjw@sisk.pl>:
>> So we preserve SCI_EN bit per spec.
>
> In fact we do set SCI_EN directly in drivers/acpi/sleep.c in a couple=
 of
> places exactly because the hardware is _known_ to wrong things here. =
=A0So, we
> don't really preserve it, _exactly_ because at least some pieces of h=
ardware
> out there don't follow the spec. =A0Including Macs, IIRC.
>
> Bob, can you please verify if the Lin Ming's patch helps?

Yes, my laptop is one of those pieces of hardware.  I can confirm that =
Lin
Ming's patch works on my system.

--=20
Bob Copeland %% www.bobcopeland.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
