From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Thu, 10 Dec 2009 15:21:06 +0300
Message-ID: <4B20E7B2.1010208@suse.de>
References: <20091210100907.GA2446@ucw.cz> <1260446205-16868-1-git-send-email-dfeng@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:35773 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932805AbZLJMVC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 07:21:02 -0500
In-Reply-To: <1260446205-16868-1-git-send-email-dfeng@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Pavel Machek <pavel@ucw.cz>

Hi Xiaotian,

I think, this is another round of "armor vs. bullet" race... It will ho=
ld until
might_sleep() logic changes again.

Please consider using preemptible() -- IMHO this is the check we should=
 perform=20
in our case of voluntary preemption.

Regards,
Alex.


Xiaotian Feng =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> commit 8bd108d adds preemption point after each opcode parse, then
> a sleeping function called from invalid context bug was founded
> during suspend/resume stage. this was fixed in commit abe1dfa by
> don't cond_resched when irq_disabled. But recent commit 138d156 chang=
es
> the behaviour to don't cond_resched when in_atomic. This makes the
> sleeping function called from invalid context bug happen again, which
> is reported in http://lkml.org/lkml/2009/12/1/371.
>=20
> This patch also fixes http://bugzilla.kernel.org/show_bug.cgi?id=3D14=
483
>=20
> Reported-and-bisected-by: Larry Finger <Larry.Finger@lwfinger.net>
> Reported-and-bisected-by: Justin P. Mattock <justinmattock@gmail.com>
> Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Lin Ming <ming.m.lin@intel.com>
> Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
>  include/acpi/platform/aclinux.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/=
aclinux.h
> index 9d7febd..0946997 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_c=
ache_t * cache)
>  #include <linux/hardirq.h>
>  #define ACPI_PREEMPTION_POINT() \
>  	do { \
> -		if (!in_atomic_preempt_off()) \
> +		if (!in_atomic_preempt_off() && !irqs_disabled()) \
>  			cond_resched(); \
>  	} while (0)
> =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
