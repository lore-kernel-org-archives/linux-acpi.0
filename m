From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 19:33:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403161933.07816.dtor_core@ameritech.net>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <1079479694.5408.47.camel@cog.beaverton.ibm.com> <20040317001324.GA19180@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040317001324.GA19180@hell.org.pl>
Content-Disposition: inline
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: john stultz <johnstul@us.ibm.com>, Dominik Brodowski <linux@brodo.de>, acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> Thus wrote john stultz:
> > Hmm. This is untested, but I think this should do the trick.
> 
> Hmm... without the patch, neither cpu MHz nor bogomips are updated, with
> the patch cpu MHz value seems correct (both using acpi.ko and
> speedstep-ich.ko, but the bogomips is still at its initial value.
> Best regards,
> 

Karol, do you have a P4? AFAIK P4's TSC is stable even if core frequence
changes so loop_per_juffy (== bogomips) need not be updated.

-- 
Dmitry
