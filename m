From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -v2 2/3] ACPI, APEI, Add APEI generic error status print support
Date: Wed, 1 Dec 2010 07:56:46 +0800
Message-ID: <AANLkTimxPqx_VUBBrmgA1gzYz1p4kC1SQBJO-vv570f+@mail.gmail.com>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
	<1291085501-31494-3-git-send-email-ying.huang@intel.com>
	<20101129190343.7d7cea12.akpm@linux-foundation.org>
	<987664A83D2D224EAE907B061CE93D530191E8BCF1@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38495 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0K3X4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Nov 2010 18:56:46 -0500
In-Reply-To: <987664A83D2D224EAE907B061CE93D530191E8BCF1@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Wed, Dec 1, 2010 at 2:00 AM, Luck, Tony <tony.luck@intel.com> wrote:
>> + =C2=A0 =C2=A0 for (i =3D 0; i < strs_size; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(bits & (1U << i)))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D strs[i];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len && len + strlen(=
str) + 2 > 80) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 printk("\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 len =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 len =3D pr_pfx(pfx, "%s", str);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 len +=3D printk(", %s", str);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk("\n");
>
> Does printk() offer any guarantees about getting all the characters
> from a single printk() call out to the console without interleaving
> with messages from printk() calls on other cpus? =C2=A0If it does, th=
en
> it would be a good idea to sprintf() the parts of this message to
> a buffer and then use one printk() call. =C2=A0I think I read that ne=
tconsole
> ends up with one packet on the wire for each call to printk().
>
> Trying to parse output jumbled together from multiple cpus
> doesn't sound like fun.

Yes. Will do that.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
