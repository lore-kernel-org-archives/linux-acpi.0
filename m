From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPICA: Handle large field apertures.
Date: Wed, 26 May 2010 11:30:09 +0400
Message-ID: <4BFCCE01.1070100@suse.de>
References: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>	 <20100525105910.2629.76253.stgit@thinkpad>	 <1274841567.28455.16.camel@minggr.sh.intel.com> <1274842158.28455.18.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:37888 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZHaN (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 26 May 2010 03:30:13 -0400
In-Reply-To: <1274842158.28455.18.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Hi Ming,

26.05.2010 06:49, Lin Ming =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Better to test AccessByteWidth as below,
Why not just 'if (AccessByteWidth > 255)' ?
>=20
> +                if (!(AccessByteWidth & ~0xFF)) {
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
