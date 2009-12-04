From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or
	in_atomic
Date: Thu, 3 Dec 2009 22:50:58 -0800
Message-ID: <dd18b0c30912032250k7502c751mb8aefe7f915a281b@mail.gmail.com>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:41595 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZLDGuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 01:50:52 -0500
In-Reply-To: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 3, 2009 at 8:26 PM, Xiaotian Feng <dfeng@redhat.com> wrote:
> commit 8bd108d adds preemption point after each opcode parse, then
> a sleeping function called from invalid context bug was founded
> during suspend/resume stage. this was fixed in commit abe1dfa by
> don't cond_resched when irq_disabled. But recent commit 138d156 chang=
es
> the behaviour to don't cond_resched when in_atomic. This makes the
> sleeping function called from invalid context bug happen again, which
> is reported in http://lkml.org/lkml/2009/12/1/371.
>
> The fix is to cond_sched() only when preemptible, which means not in
> irq_disabled or in_atomic.
>
> Reported-and-bisected-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> ---
> =A0include/acpi/platform/aclinux.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/=
aclinux.h
> index 9d7febd..5b415ee 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_c=
ache_t * cache)
> =A0#include <linux/hardirq.h>
> =A0#define ACPI_PREEMPTION_POINT() \
> =A0 =A0 =A0 =A0do { \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!in_atomic_preempt_off()) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (preemptible()) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cond_resched(); \
> =A0 =A0 =A0 =A0} while (0)
>
> --
> 1.6.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

looks good
kernel compiled without any issues,
echo mem > /sys/power/state
reported no warning message.

Also if you don't mind add:
Reported-and-bisected-by: Justin P. Mattock <justinmattock@gmail.com>

Id like to get some kind of credit for this b*tch.

--=20
Justin P. Mattock
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
