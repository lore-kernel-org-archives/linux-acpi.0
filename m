From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: EC
Date: Thu, 02 Jul 2009 10:20:31 +0400
Message-ID: <4A4C51AF.8080206@suse.de>
References: <76780B19A496DC4B80439008DAD7076C03453A5BFC@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58999 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750850AbZGBGUa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 02:20:30 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C03453A5BFC@PDSMSX501.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Li, Shaohua =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
> Preempt isn't disabled between ec_burst_enable()/ec_burst_disable(), =
so it's very likely there is a preemption between them and make the tim=
ing for burst mode not comply with ACPI spec (400ms for first access an=
d 50ms for subsequent access).
>=20
> We have a system with broken EC and the BIOS engineer identified it's=
 the timing issue.
> What's the judgment why Linux doesn't comply with ACPI spec?

Please disable ec_burst_* and check again. Judgement is that ec_burst_*=
 is irrelevant to the protocol.
What platform and what other symptoms do you have? How exactly this EC =
is broken?

Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
