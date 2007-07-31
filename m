From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2/3] 2.6.23-rc1: known regressions v3
Date: Tue, 31 Jul 2007 08:07:55 +0400
Message-ID: <46AEB59B.7030909@gmail.com>
References: <46AE0F5D.3000500@googlemail.com> <46AE12F5.4030706@googlemail.com> <200707302208.20891.ismail@pardus.org.tr> <Pine.SOC.4.64.0707302301290.14147@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:38287 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbXGaEIC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2007 00:08:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so38220ugf
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jul 2007 21:08:01 -0700 (PDT)
In-Reply-To: <Pine.SOC.4.64.0707302301290.14147@math.ut.ee>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: =?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Meelis Roos wrote:
>>> Subject         : New ACPI error/warning with Linus' latest GIT
>>> References      : http://lkml.org/lkml/2007/7/26/395
>>> Last known good : ?
>>> Submitter       : Ismail D=F6nmez <ismail@pardus.org.tr>
>>> Caused-By       : ?
>>> Handled-By      : ?
>>> Status          : unknown
>> This started to happen after the second ACPI merge which was for 2.6=
=2E23-rc2.
>=20
> It appeared after new Embedded Controller code was merged into ACPI. =
It=20
> might as well be just a debug message or a remainder to add support f=
or=20
> new queries (whatever these are), but I do not know. The message itse=
lf=20
> seems harmless.
>=20
This _is_ a debug message. EC asks us to perform query which was never =
defined in DSDT.
Previously I thought it would be rare error report, but now it seems th=
at every machine
has at least one unregistered query... It is not a functional regressio=
n, as we just=20
ignored errors from query execution before.

Len already has a patch to remove this printk.

Regards,
	Alex.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
