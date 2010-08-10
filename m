From: Piotr Hosowicz <piotr@hosowicz.com>
Subject: Re: BUG: scheduling while atomic: swapper/0/0x10000002
Date: Tue, 10 Aug 2010 17:36:28 +0200
Message-ID: <4C6171FC.6060305@example.com>
References: <20100810142951.GA7156@arch.tripp.de> <4C616DF9.1070309@example.com> <20100810153538.GB5466@swordfish.minsk.epam.com>
Reply-To: piotr@hosowicz.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 70.mail-out.ovh.net ([91.121.185.63]:41498 "HELO
	70.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932156Ab0HJPgd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Aug 2010 11:36:33 -0400
In-Reply-To: <20100810153538.GB5466@swordfish.minsk.epam.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Heinz Diehl <htd@fancy-poultry.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 10.08.2010 17:35, Sergey Senozhatsky wrote:
> On (08/10/10 17:19), Piotr Hosowicz wrote:
>> None of them works for me. I do:
>>
>> cat patch.txt | patch -p1
>>
>> And get:
>>
>> aapi205:/usr/src/linux# cat ../smp-bug.txt | patch -p1
>> patching file include/acpi/platform/aclinux.h
>> Hunk #1 FAILED at 152.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> include/acpi/platform/aclinux.h.rej
>>
>> Help me please.
>>
>
> Can we see your:
> include/acpi/platform/aclinux.h(.rej)
>
> ?

aapi205:/usr/src/linux# cat include/acpi/platform/aclinux.h.rej
--- include/acpi/platform/aclinux.h
+++ include/acpi/platform/aclinux.h
@@ -152,7 +152,7 @@
  #include <linux/hardirq.h>
  #define ACPI_PREEMPTION_POINT() \
         do { \
-               if (!in_atomic_preempt_off() && !irqs_disabled()) \
+               if (!in_atomic() && !irqs_disabled()) \
                         cond_resched(); \
         } while (0)

> (did you `git pull`?)

No, I just downloaded bz2 patch from kernel.org.

Regards,

Piotr Hosowicz

--=20
Z cyklu "Uroki demokracji", czyli pytania i odpowiedzi w teledurniejach=
:
- W kt=F3rym mie=B6cie europejskim powsta=B3a pierwsza opera?
- Sydney.
NP: Peter Green Splinter Group - Heart Of Stone
NB: 2.6.35-git9
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
