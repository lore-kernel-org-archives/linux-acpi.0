From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 1/1] thinkpad-acpi: kill
	hotkey_thread_mutex
Date: Sat, 9 Mar 2013 18:34:28 -0300
Message-ID: <20130309213428.GB7559@khazad-dum.debian.net>
References: <20130305174838.GA7276@redhat.com>
	<CACBanvqHRDsOQiMsQMw5_QDt1wFrb8_DRoiASSvqeA6XdFrwZQ@mail.gmail.com>
	<20130305180542.GA12738@redhat.com>
	<CACBanvr7XvXbFjphpRwKHHJKzVuA-s6sF-qkPiizBV3+uqzpJw@mail.gmail.com>
	<20130305232603.GA16045@khazad-dum.debian.net>
	<20130306154420.GA7697@redhat.com>
	<20130306233232.GA12645@khazad-dum.debian.net>
	<20130307175305.GA15631@redhat.com>
	<20130307175359.GB15631@redhat.com>
	<CACBanvqP0jx_d-LtV5+fRD7M698M_b6j0Sv=v0uoTBpjEusQCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACBanvqP0jx_d-LtV5+fRD7M698M_b6j0Sv=v0uoTBpjEusQCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mandeep Singh Baines <msb-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Artem Savkov <artem.savkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 07 Mar 2013, Mandeep Singh Baines wrote:
> On Thu, Mar 7, 2013 at 9:53 AM, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > hotkey_kthread() does try_to_freeze() under hotkey_thread_mutex.
> >
> > We can simply kill this mutex, hotkey_poll_stop_sync() does not need
> > to serialize with hotkey_kthread(). When kthread_stop() returns the
> > thread is already dead, it called do_exit()->complete_vfork_done().
> >
> > Reported-by: Artem Savkov <artem.savkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Reported-by: Maciej Rutecki <maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >
> 
> Reviewed-by: Mandeep Singh Baines <msb-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Acked-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
