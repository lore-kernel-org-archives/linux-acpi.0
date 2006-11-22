From: Len Brown <len.brown@intel.com>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 17:18:55 -0500
Message-ID: <200611221718.55689.len.brown@intel.com>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com> <1164021493.3721.229.camel@queen.suse.de>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:8411 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1757071AbWKVWQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 17:16:04 -0500
In-Reply-To: <1164021493.3721.229.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

> > 5. Is =E2=80=9Cdsdt=E2=80=9D and =E2=80=9Cfadt=E2=80=9D still neede=
d in sysfs? This is not necessary because the acpidump tools are quite =
handy.
> > If =E2=80=9CYes=E2=80=9D, are other tables also needed, e.g. multip=
le SSDTs and dynamically loaded op-regions? This is much more difficult=
, as they can=E2=80=99t be distinguished sometimes.
> > And where should these tables locate?

> IMO they can vanish (at least temporarily).
> If really needed (AFAIK explicitly loaded tables via "Load(addr,)"
> statement that are not listed in RSDT/XSDT can't be found by acpidump=
),
> a /sys/../tables/* can still be implemented at later time? We are als=
o
> not able to grab them atm...

=46YI, The latest code on the ACPICA branch spits out the physical addr=
ess
for dynamic tables in dmesg and the latest acpidump can read it by
specifying a physical address as a parameter.

My view is that if we export any tables in sysfs, we should export them=
 all,
including dynamically loaded tables.  The current /proc/acpi/fadt,dsdt
is inconsistent.

I agree, that we can do this later.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
