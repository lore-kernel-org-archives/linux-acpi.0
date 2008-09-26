From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: 2.6.27 kernel disables frequency switching on x86_64 - stuck
	on lowest frequency
Date: Fri, 26 Sep 2008 23:40:40 +0800
Message-ID: <1222443640.4023.220.camel@yakui_zhao.sh.intel.com>
References: <200809260201.42206.jvdias@research.att.com>
	 <alpine.LFD.1.10.0809260806120.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbYIZPfx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 11:35:53 -0400
In-Reply-To: <alpine.LFD.1.10.0809260806120.3265@nehalem.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Vas Dias <jvdias@research.att.com>, Andrew Morton <akpm@linux-foundation.org>, andi@firstfloor.org, roland@redhat.com, molnar@redhat.com, linux-acpi@vger.kernel.org

On Fri, 2008-09-26 at 08:17 -0700, Linus Torvalds wrote:
> 
> On Fri, 26 Sep 2008, Jason Vas Dias wrote:
> > 
Hi, Jason
   Will you please attach the output of acpidump, dmesg?
   From the log it seems that the BIOS gives the incorrect ACPI table.
For example: the 32X/64X address don't match in FADT table.
   Of course you can open a new bug and attach the output of acpidump,
dmesg.
    http://bugzilla.kernel.org/acpi

thanks
     
> > There appears to be a serious problem with every 2.6.27-X kernel I've 
> > tried - and I've tried quite a few from the linux-2.6, linux-acpi-2.6, 
> > and linux-2.6-tip GIT trees, and the latest Fedora 10 kernels over the 
> > past few weeks trying to solve this problem:
> 
> So which trees work, and which don't? Also, since it seems entirely 
> repeatable, this is a prime candidate for "git bisect" - it will be 
> eventually faster to do than trying many different trees at random, even 
> if you will likely need to reboot/compile about 12 times or so (assuming 
> 2.6.27-rc1 is broken, and 2.6.26 works, which it sounds like).
> 
> Bisecting really isn't that hard. Get the git tree, do
> 
> 	git bisect start
> 	git bisect bad v2.6.27-rc1
> 	git bisect good v2.6.26
> 
> and off you go. You don't even need to know a lot about git, there's a few 
> quick tutorials out there if you haven't used it. See for example
> 
> 	http://www.kernel.org/doc/local/git-quick.html
> 
> which has an example git bisect run, in addition to just initial clone 
> insutrctions.
> 
> > CPU frequency switching is completely disabled, the 2.2Ghz AMD TL-64 
> > Dual Core CPU is stuck at 0.8Ghz, the machine cannot reboot or perform 
> > any ACPI actions.
> > 
> > There are no obvious failures indicated in the logs, only this:
> > 
> > [    0.000000] ACPI Error (tbfadt-0453): 32/64X address mismatch in "Pm2ControlBlock": [00008800] [0000000000008100], using 64X [20080609]
> 
> Hmm. I don't know if it's ACPI-related, but the fact that it cannot even 
> reboot etc sure seems to make it likely. Have you made the acpi lists 
> aware of it (linux-acpi@vger.kernel.org and lenb are listed in 
> MAINTAINERS)?
> 
> 		Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

