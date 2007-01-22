From: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: RE: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Date: Mon, 22 Jan 2007 09:25:27 +0530
Message-ID: <5B3EF00AF56209498A59172917BFE8130168F0B6@bgsmsx412.gar.corp.intel.com>
References: <20070119092936.GA5590@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18753 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbXAVDzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jan 2007 22:55:32 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070119092936.GA5590@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: inux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>

My initial idea was to execute only block device resume on the separate
thread, as it take almost 80% of the total device resume time ( I did
detailed profile of each device resume through rdtsc() counter) and rest
of them takes less than 20% in total( each device ( including char and
net)on its own takes less than 0.03 seconds). I could still save some
good amount of resume time ( apprx 1.2 sec). However Given this ratio,
and the fact that block device resume happening way at the end of the
list, I tried this with only taking care of Block devices. 
	I am not sure if there is a case where any scenario where Char
devices would take more resume time than normally it would. If so I can
modify the patch to put only block devices in separate thread for resume
Thanks
-hari
-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 
Sent: Friday, January 19, 2007 3:00 PM
To: Seshadri, Harinarayanan
Cc: inux-pm@lists.osdl.org; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request
for Comment

Hi!

> [RFC][PATCH] Power S3 Resume optimisation 
> 	Here is a simple patch for optimising the S3 resume. With this
> patch the resume time is 0.85. Given the fact that device
initialisation
> on the resume takes almost 70% of time, By executing the whole
> "device_resume()" function on a seperate kernel thread, the resume
gets
> completed( ie. the user can precieve) by ~0.85 sec.

Yep, but you also break it completely...

> 	To avoid any possible race condition while processing the IO
> request and to make sure all the io request are queued till the device
> resume thread exits, the IO schedulars (patched cfq and as) checks a
for
> system_resume flag, which is set when the device resume thread starts,
> if the flag is set, it doesnt put the request in the dispatch queue.
> Once the flag is cleared i.e when the device resume thread is
complete,
> the IO-schedular behave as in normal situation.

And you noticed that, so you fixed obvious problems on block devices.
Ignoring char and net devices completely.


> @@ -1088,6 +1088,19 @@
>         if (list_empty(&ad->fifo_list[adir]))
>                 return 0;
> 
> +       /*
> +        * Check here for the System resume flag to be cleared, if
flag
> is
> +       *  still set the resume thread hasnt completed yet, and hence
> dont
> +       *  takeout any new request from the FIFO
> +       */
> +       extern int system_resuming;
> +       if (system_resuming != 0)
> +       {

Locking. CodingStyle.

> -static void suspend_finish(suspend_state_t state)
> +static int dev_resume_proc(void * data)
> {
> +       /* Set the global resume flag, this will be checked by the
> IO_schedular

Broken mail client.

> +       * before dispatching the IO request
> +       */
> +       system_resuming =1;

Add mdelay(1 hour) here. Then try to use your wifi card and your tv
grabber.

>         device_resume();
> +       system_resuming = 0;
> +#ifdef DEBUG
> +       printk(" reseting system_resume \n");
> +#endif

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures)
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
