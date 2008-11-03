From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Mon, 03 Nov 2008 09:03:14 +0800
Message-ID: <1225674194.26020.4.camel@yakui_zhao.sh.intel.com>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com>
	 <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de>
	 <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk>
	 <4908C8EB.1010403@suse.de> <490ADD62.7090507@tuffmail.co.uk>
	 <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk>
	 <490B12F2.9050903@suse.de> <490B132A.3000904@tuffmail.co.uk>
	 <490B1C3C.2080305@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55444 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbYKCA4X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Nov 2008 19:56:23 -0500
In-Reply-To: <490B1C3C.2080305@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

On Fri, 2008-10-31 at 22:54 +0800, Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
> > Alexey Starikovskiy wrote:
> >> Alan Jenkins wrote:
> >>> Alexey Starikovskiy wrote:
> >>>> Alan Jenkins wrote:
> >>>>> Alexey Starikovskiy wrote:
> >>>>>> Alan Jenkins wrote:
> >>>>>>> Well, that didn't work.
> >>>>>> Pity...
> >>>>>> Could you produce a debug log from EC?
> >>>>>> Probably it's a good time to open a new bug report...
> >>>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
> >>>>> "Asus Eee PC hotkeys stop working after prolonged usage"
> >>>>>
> >>>>> I stuck at it, found a reliable test and bisected successfully.
> >>>>> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit.
> >>>>> (There were some conflicts, I fixed up the dock driver manually and
> >>>>> avoided building the rest).
> >>>> Alan, to make things clear -- reverting following commit makes EC work
> >>>> without
> >>>> a problem?
> >>>>
> >>>
> >>> Yes, that's right.
> >> Great!
> >> What kernel version is that -- 32 or 64?
Thanks for the patch. 
   It seems that the code path in the function of ec_parse_device is
incorrect.
   Whether the ec->global_lock is assigned to a value should be based on
the returned value of acpi_evaluate_integer(handle, "_GLK", NULL, &tmp).
   If AE_OK is returned, the ec->global_lock is assigned to true.
Otherwise it should be False.
   Is this OK?
 
Thanks.

  
> > 
> > 32 bit, my EeePC doesn't do 64.
> is the attached patch enough to fix ?
> 

