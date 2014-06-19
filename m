From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: drivers/acpi/ac.c, re-enabling CONFIG_ACPI_PROCFS_POWER?
Date: Thu, 19 Jun 2014 14:32:40 +0800
Message-ID: <53A28408.8040001@intel.com>
References: <53A1F65C.9090907@gmail.com> <1891948.UFv8RnVsZc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55117 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbaFSGdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2014 02:33:41 -0400
In-Reply-To: <1891948.UFv8RnVsZc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sorin Manolache <sorinm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2014=E5=B9=B406=E6=9C=8819=E6=97=A5 07:17, Rafael J. Wysocki wrote:
> On Wednesday, June 18, 2014 10:28:12 PM Sorin Manolache wrote:
>> Hello,
>>
>> Would it be worth considering re-enabling the old procfs interface f=
or=20
>> ac.c? There are old tools still around (kpowersave from kde 3.5.10) =
that=20
>> expect /proc/acpi/ac_adapter.
>=20
> Can you please CC ACPI-related messages to linux-acpi@vger.kernel.org=
?
>=20
> I'm not sure how much effort that would require at this point.  Rui, =
Tianyu?

I think we need to revert commit ab0fd67.

commit ab0fd674d6cef0904baa511f22613ef6474f8169
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Sat Oct 12 21:04:48 2013 +0800

    ACPI / AC: Remove AC's proc directory.

    AC's proc directory is not used and so remove it. Prepare for remov=
ing
    /proc/acpi directory.

    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


>=20
> Rafael
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
