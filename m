From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Fri, 11 Dec 2009 13:46:13 +0800
Message-ID: <1260510373.10543.17.camel@minggr.sh.intel.com>
References: <20091210100907.GA2446@ucw.cz>
	 <1260446205-16868-1-git-send-email-dfeng@redhat.com>
	 <4B20E7B2.1010208@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbZLKGAk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2009 01:00:40 -0500
In-Reply-To: <4B20E7B2.1010208@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Xiaotian Feng <dfeng@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Pavel Machek <pavel@ucw.cz>

On Thu, 2009-12-10 at 20:21 +0800, Alexey Starikovskiy wrote:
> Hi Xiaotian,
>=20
> I think, this is another round of "armor vs. bullet" race... It will =
hold until
> might_sleep() logic changes again.
>=20
> Please consider using preemptible() -- IMHO this is the check we shou=
ld perform=20
> in our case of voluntary preemption.

preemptible() may not work here because it always returns 0 for
non-preemptible kernel.

#ifdef CONFIG_PREEMPT
# define preemptible()  (preempt_count() =3D=3D 0 && !irqs_disabled())
# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
#else
# define preemptible()  0
# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
#endif

Lin Ming

>=20
> Regards,
> Alex.
>=20
>=20
> Xiaotian Feng =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > commit 8bd108d adds preemption point after each opcode parse, then
> > a sleeping function called from invalid context bug was founded
> > during suspend/resume stage. this was fixed in commit abe1dfa by
> > don't cond_resched when irq_disabled. But recent commit 138d156 cha=
nges
> > the behaviour to don't cond_resched when in_atomic. This makes the
> > sleeping function called from invalid context bug happen again, whi=
ch
> > is reported in http://lkml.org/lkml/2009/12/1/371.
> >=20
> > This patch also fixes http://bugzilla.kernel.org/show_bug.cgi?id=3D=
14483
> >=20
> > Reported-and-bisected-by: Larry Finger <Larry.Finger@lwfinger.net>
> > Reported-and-bisected-by: Justin P. Mattock <justinmattock@gmail.co=
m>
> > Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Bob Moore <robert.moore@intel.com>
> > Cc: Lin Ming <ming.m.lin@intel.com>
> > Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > ---
> >  include/acpi/platform/aclinux.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platfor=
m/aclinux.h
> > index 9d7febd..0946997 100644
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi=
_cache_t * cache)
> >  #include <linux/hardirq.h>
> >  #define ACPI_PREEMPTION_POINT() \
> >  	do { \
> > -		if (!in_atomic_preempt_off()) \
> > +		if (!in_atomic_preempt_off() && !irqs_disabled()) \
> >  			cond_resched(); \
> >  	} while (0)
> > =20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
