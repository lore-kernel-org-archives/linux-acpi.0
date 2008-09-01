From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no
	resume after	undocking
Date: Mon, 1 Sep 2008 08:28:16 -0300
Message-ID: <20080901112816.GA21970@khazad-dum.debian.net>
References: <200808301535.22419.sfking@fdwdc.com>
	<1220239048.24775.152.camel@rzhang-dt>
	<48BBC8FC.1020809@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48BBC8FC.1020809-ix/z9KG6G0Jl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tomas Carnecky <tom-ix/z9KG6G0Jl57MIdRCFDg@public.gmane.org>
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 01 Sep 2008, Tomas Carnecky wrote:
> There is one question though that was never answered: Is there any
> interaction needed from the userspace when docking/undocking? Something

Yes.  umount filesystems on any device in the dock, and issue the "power off
dock" command (i.e. tell the kernel to *eject* the dock).  This is *very*
important, although the ThinkPad firmware/hardware will _try_ to protect the
electronics if you just pull the laptop off the dock while it is still
powered (but it might just not be able to do it, so Don't Do That!).

Anyway, if your dock led is going off before you remove the laptop from the
dock, you're doing everything correctly as far as the hardware is concerned.

And the kernel will scream bloody murder if you remove a device with live
filesystems in it, so it should be trivial to check if that part is being
taken care of by your userspace as well.  Not that something like this would
be an excuse to fail to suspend/resume after being undocked, mind you.

> That behavior is consistent with my earlier experience, that is: If the
> notebook was _ever_ running in the docking station, it won't resume
> outside of it. No matter whether I start it outside the dock and then
> put it into the dock, or start it up in the dock - once the notebook has
> been docked, suspend/resume outside of the dock won't work anymore.
> My wild uneducated guess is that the kernel doesn't remove/disable some
> devices when undocking (the bay device?) and when it tries to resume
> without them present it will hang.

Your uneducated guess might well be right, there are a lot of patches for
dock that are not in mainline yet.  You clearly are experiencing some sort
of Linux bug, that much is pretty clear to me.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
