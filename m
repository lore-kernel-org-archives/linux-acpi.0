From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Sat, 6 Nov 2004 14:15:20 +0100
Message-ID: <200411061415.20364.jos.delbar@ugent.be>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com> <1099700714.13834.1717.camel@d845pe> <20041106002935.GA30467@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041106002935.GA30467-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 November 2004 01:29, Dominik Brodowski wrote:
> If that is the case, my patch is "overkill". If there's a chance to do more
> fine-tuned disabling of C3, my patch seems to be better.

Maybe you could reduce the overkill by using a counter instead of a linked 
list to keep track of the limits imposed by other modules. I don't think you 
need any extra code in the idle handler, Len's additions should be enough to 
handle a limit change. The only possible danger that I can see is one or more 
extra idle cycles with an outdated limit.

As it is, is there a way for a module such as ipw2100 to detect when its limit 
request has been commited? Does the processor module export the current C 
state, or should the module rely on the /proc file?

Anyway, here is some code to illustrate the counter. And now I'm going to stop 
spending time on workarounds! ;-)

static unsigned int cstate_limit_counter[ACPI_C_STATES_MAX];
static spinlock_t cstate_limit_lock = SPIN_LOCK_UNLOCKED;

inline void acpi_update_cstate_limit(unsigned int limit, int gain)
{
 unsigned long flags;
 int c;

 if(new_limit >= ACPI_C_STATES_MAX)
  return;

 spin_lock_irqsave(&cstate_limit_lock, flags);
 if (gain > 0)
  cstate_limit_counter[limit]++;
 else if (cstate_limit_counter[limit] > 0)
  cstate_limit_counter[limit]--;

 for (c = 0; c < ACPI_C_STATES_MAX; c++) {
  if (cstate_limit_counter[c]) {
   acpi_cstate_limit = c;
   spin_unlock_irqrestore(&cstate_limit_lock, flags);
   return;
  }
 }
 acpi_cstate_limit = ACPI_C_STATES_MAX;
 spin_unlock_irqrestore(&cstate_limit_lock, flags);
}

static void acpi_remove_cstate_limit(unsigned int limit)
{
 acpi_update_cstate_limit(limit, -1);
}

static void acpi_set_cstate_limit(unsigned int limit)
{
 acpi_update_cstate_limit(limit, 1);
}

-- 

Jos Delbar
jos.delbar-Cru1EgDzd7c@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
