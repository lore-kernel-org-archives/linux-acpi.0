From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or
 in_atomic
Date: Fri, 04 Dec 2009 13:38:43 +0800
Message-ID: <1259905123.27069.99.camel@rzhang1-desktop>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
	 <1259905017.27069.98.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751672AbZLDFiI@vger.kernel.org>
In-Reply-To: <1259905017.27069.98.camel@rzhang1-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2009-12-04 at 13:36 +0800, Zhang Rui wrote:
> CC Alexey.
> 
> And this is also the fix for
> http://bugzilla.kernel.org/show_bug.cgi?id=14483
> 
> thanks,
> rui
> 
> On Fri, 2009-12-04 at 12:26 +0800, Xiaotian Feng wrote:
> > commit 8bd108d adds preemption point after each opcode parse, then
> > a sleeping function called from invalid context bug was founded
> > during suspend/resume stage. this was fixed in commit abe1dfa by
> > don't cond_resched when irq_disabled. But recent commit 138d156 changes
> > the behaviour to don't cond_resched when in_atomic. This makes the
> > sleeping function called from invalid context bug happen again, which
> > is reported in http://lkml.org/lkml/2009/12/1/371.
> > 
> > The fix is to cond_sched() only when preemptible, which means not in
> > irq_disabled or in_atomic.
> > 
> > Reported-and-bisected-by: Larry Finger <Larry.Finger@lwfinger.net>
> > Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> > ---
> >  include/acpi/platform/aclinux.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> > index 9d7febd..5b415ee 100644
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
> >  #include <linux/hardirq.h>
> >  #define ACPI_PREEMPTION_POINT() \
> >  	do { \
> > -		if (!in_atomic_preempt_off()) \
> > +		if (preemptible()) \
> >  			cond_resched(); \
> >  	} while (0)
> >  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
