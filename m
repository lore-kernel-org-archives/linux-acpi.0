From: Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/1] thinkpad-acpi: kill hotkey_thread_mutex
Date: Thu, 7 Mar 2013 18:53:05 +0100
Message-ID: <20130307175305.GA15631@redhat.com>
References: <201303042055.38040.maciej.rutecki@gmail.com>
	<1362504883-9180-1-git-send-email-msb@chromium.org>
	<20130305174838.GA7276@redhat.com>
	<CACBanvqHRDsOQiMsQMw5_QDt1wFrb8_DRoiASSvqeA6XdFrwZQ@mail.gmail.com>
	<20130305180542.GA12738@redhat.com>
	<CACBanvr7XvXbFjphpRwKHHJKzVuA-s6sF-qkPiizBV3+uqzpJw@mail.gmail.com>
	<20130305232603.GA16045@khazad-dum.debian.net>
	<20130306154420.GA7697@redhat.com>
	<20130306233232.GA12645@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130306233232.GA12645-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mandeep Singh Baines <msb-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 03/06, Henrique de Moraes Holschuh wrote:
>
> On Wed, 06 Mar 2013, Oleg Nesterov wrote:
> >
> > 	static void hotkey_poll_stop_sync(void)
> > 	{
> > 		if (tpacpi_hotkey_task) {
> > 			kthread_stop(tpacpi_hotkey_task);
> > 			tpacpi_hotkey_task = NULL;
> > 			mutex_lock(&hotkey_thread_mutex);
> > 			/* at this point, the thread did exit */
> > 			mutex_unlock(&hotkey_thread_mutex);
> > 		}
> > 	}
> >
> > And I simply do not understand the comment. This thread has already exited
> > when kthread_stop() returns (OK, it can be running do_exit() paths but this
> > doesn't matter). So this mutex_lock() buys nothing afaics.
>
> It was added due to an oops, waaaaay back then.  If it is not needed
> anymore, and there is zero chance of the kthread still being active when
> hotkey_poll_stop_sync() ends, hotkey_thread_mutex can be simply removed.

Well, there could be another bug. Say, hotkey_poll_stop_sync() can block
on hotkey_thread_mutex if another thread was started. But at first glance
this can't happen (hotkey_mutex), and even _if_ it can this needs another
fix.

> Looks like it, if the current semanthics of ktread_stop() are syncronous.

IIRC, it always was... But at least currently it is certainly syncronous.
kthread_stop(t) does wait_for_completion(t->vfork_done), complete(vfork_done)
can't happen unless this task calls do_exit().

Hmm. I just noticed that the recent changes in kthread_stop() are not correct...
But this is offtopic and doesn't affect thinkpad_acpi.c, I'll write another
email later.

So, what do you think about (UNTESTED) 1/1 ?

Oleg.


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
