From: Andreas Schwab <schwab@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Sat, 28 Jul 2007 01:50:06 +0200
Message-ID: <je8x91flu9.fsf@sykes.suse.de>
References: <200707251238.50218.lenb@kernel.org> <46A98FF9.8060801@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47610 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762431AbXG0XuJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jul 2007 19:50:09 -0400
In-Reply-To: <46A98FF9.8060801@l4x.org> (Jan Dittmer's message of "Fri\, 27 Jul
	2007 08\:26\:01 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Jan Dittmer <jdi@l4x.org> writes:

> Len Brown wrote:
>> Hi Linus,
>>
>> please pull from:=20
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.gi=
t release
>
> This seems to break ia64 defconfig:
>
>   Building modules, stage 2.
>   MODPOST 157 modules
> FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=3D20 is not=
 a modulo of the size of section __mod_acpi_device_table=3D144.

Are you cross-compiling?  The definition of kernel_ulong_t won't work o=
n
x86.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
