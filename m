From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] Reverting ACPI / battery: fix wrong value of capacity_now reported when fully charged
Date: Tue, 09 Sep 2014 22:43:15 +0200
Message-ID: <2429348.jpd29irnWH@vostro.rjw.lan>
References: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59827 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751102AbaIIUXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 16:23:49 -0400
In-Reply-To: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mariusz Ceier <mceier+kernel@gmail.com>, Josef Gajdusek <atx@atx.name>

On Tuesday, September 09, 2014 10:45:16 AM Bj=C3=B8rn Mork wrote:
> This firmware workaround has unwanted side effects causing wrong
> capacity reports from previously working firmwares.  It should
> be reerted and redone in a non-intrusive manner.
>=20
> I see that one of the bugs it added alread has been fixed.  But
> the fix still leaves the original workaround design flaw in place,
> and I therefore propose reverting both patches.  I've marked both
> patches for stable, because the fix was marked for stable.  Those
> should ideally cancel each others out and only the revert of the
> initial buggy patch should really go to stable.

Queued up for 3.17-rc5, thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
