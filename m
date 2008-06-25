From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: don't walk tables if ACPI was disabled
Date: Wed, 25 Jun 2008 09:37:37 +0800
Message-ID: <1214357857.9800.20.camel@yakui_zhao.sh.intel.com>
References: <20080620135639.GA5073@damson.getinternet.no>
	 <alpine.LFD.1.10.0806201458500.3027@localhost.localdomain>
	 <19f34abd0806201340t502ce471n578dd2498a5f1992@mail.gmail.com>
	 <19f34abd0806201427h740ca3e7gc2f01c7e34616fd4@mail.gmail.com>
	 <19f34abd0806210119o64a1c9ban78710651a01530cf@mail.gmail.com>
	 <20080624114139.GC21890@elte.hu>
	 <19f34abd0806240452w2561040uc2b1b1d35562db71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755518AbYFYB05@vger.kernel.org>
In-Reply-To: <19f34abd0806240452w2561040uc2b1b1d35562db71@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Yinghai Lu <yhlu.kernel@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2008-06-24 at 13:52 +0200, Vegard Nossum wrote:
> On 6/24/08, Ingo Molnar <mingo@elte.hu> wrote:
> > i havent seen the warning reappear with your fix after thousands of
> > bootups - so i guess we can consider it fixed.
> >
> > Len, please consider the patch below. (it's in tip/out-of-tree)
> 
> No, please don't :-)
> 
> It fixes your particular case (the acpi_rtc_init() hunk of the patch),
> but the acpi_walk_namespace() part should be changed to a WARN(). But
> that is likely to cause a lot of "spurious" reports, so the other acpi
> drivers should be fixed as well.
In fact this issue is related with the following factors:
   a. when acpi is disabled, OS won't initialize the ACPI mutex, which
is accessed by many ACPI interface functions. For example:
acpi_walk_namespace, acpi_install_fixed_event_handler.
   b. When acpi is disabled, some drivers will call the ACPI interface
functions. For example: The acpi_walk_namespace is called in
dock_init/bay_init. The acpi_install_fixed_event_handler is called in
the acpi_rtc_init.
   
  
   Although the following warning message is harmless, it is still
confusing.
   > [    3.980213] ACPI Exception (utmutex-0263): AE_BAD_PARAMETER,
Thread F7C50000 could not acquire Mutex [3] [20080321]

   Maybe it is reasonable that the flag of acpi_disabled should be used
in the drivers using ACPI interface functions. Of course it will be safe
to use the flag of acpi_disabled in the function of acpi_walk_namespace.

Thanks.
   Yakui.
> I was waiting for Len to reply, but maybe I can submit the proper fix too.
> 
> 
> Vegard
> 
