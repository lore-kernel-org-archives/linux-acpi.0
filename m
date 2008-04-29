From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25 pci=noacpi
Date: Tue, 29 Apr 2008 00:04:11 -0700
Message-ID: <20080429000411.ce73230f.akpm@linux-foundation.org>
References: <20080425183807.366134771@ldl.fc.hp.com>
	<20080425183934.516655076@ldl.fc.hp.com>
	<4813B5AB.4060308@keyaccess.nl>
	<200804281507.38309.bjorn.helgaas@hp.com>
	<4816C605.4000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759505AbYD2HFb@vger.kernel.org>
In-Reply-To: <4816C605.4000601@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: linux-acpi@vger.kernel.org

On Tue, 29 Apr 2008 07:53:57 +0100 Richard <tuxbox.guru@gmail.com> wrote:

> Hi all,
> 
> Using an AMD Sempron notebook (HP Compaq 6715b) single processor 
> machine,  It shuts down during bootup when ACPI is fully enabled.  I 
> added pci=noacpi to the cmdline and it finally boots, but its extremely 
> slow...  (kdm times out with error saying it took too long to load and 
> disables graphical)
> 
> Dmesg doest show anything out of the ordinary, irq_stats only shows the 
> timer interrupts being incremented. (noirq also works, but same 
> behaviour) Can someone please offer me some pointers so I can fault find 
> this problem.
> 

Did any earlier kernels work OK?  If so, which versions?

Thanks.
