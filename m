From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: fix potential suspend blocking issue
Date: Wed, 6 Mar 2013 20:32:32 -0300
Message-ID: <20130306233232.GA12645@khazad-dum.debian.net>
References: <201303042055.38040.maciej.rutecki@gmail.com>
 <1362504883-9180-1-git-send-email-msb@chromium.org>
 <20130305174838.GA7276@redhat.com>
 <CACBanvqHRDsOQiMsQMw5_QDt1wFrb8_DRoiASSvqeA6XdFrwZQ@mail.gmail.com>
 <20130305180542.GA12738@redhat.com>
 <CACBanvr7XvXbFjphpRwKHHJKzVuA-s6sF-qkPiizBV3+uqzpJw@mail.gmail.com>
 <20130305232603.GA16045@khazad-dum.debian.net>
 <20130306154420.GA7697@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36745 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128Ab3CFXcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Mar 2013 18:32:36 -0500
Content-Disposition: inline
In-Reply-To: <20130306154420.GA7697@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mandeep Singh Baines <msb@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 06 Mar 2013, Oleg Nesterov wrote:
> On 03/05, Henrique de Moraes Holschuh wrote:
> > On Tue, 05 Mar 2013, Mandeep Singh Baines wrote:
> > > This mutex seems wrong. Its held the entire time the kthread is
> > > running. I think its used to synchronize on the exit of the kthread. A
> > > completion would more appropriate in that case.
> >
> > From the top of the driver source:
> >
> > /* Acquired while the poller kthread is running, use to sync start/stop */
> > static struct mutex hotkey_thread_mutex;
> 
> I simply can't understand what this "sync start/stop" means...
> 
> Ignoring hotkey_kthread(), the only user is
> 
> 	static void hotkey_poll_stop_sync(void)
> 	{
> 		if (tpacpi_hotkey_task) {
> 			kthread_stop(tpacpi_hotkey_task);
> 			tpacpi_hotkey_task = NULL;
> 			mutex_lock(&hotkey_thread_mutex);
> 			/* at this point, the thread did exit */
> 			mutex_unlock(&hotkey_thread_mutex);
> 		}
> 	}
> 
> And I simply do not understand the comment. This thread has already exited
> when kthread_stop() returns (OK, it can be running do_exit() paths but this
> doesn't matter). So this mutex_lock() buys nothing afaics.

It was added due to an oops, waaaaay back then.  If it is not needed
anymore, and there is zero chance of the kthread still being active when
hotkey_poll_stop_sync() ends, hotkey_thread_mutex can be simply removed.

Note that hotkey_thread_data_mutex is still required.

> As for serializing with hotkey_poll_setup/etc, looks like this code relies
> on hotkey_mutex.
> 
> So I think hotkey_thread_mutex can be simply removed?

Looks like it, if the current semanthics of ktread_stop() are syncronous.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
