From: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no
	resume	after?undocking
Date: Wed, 3 Sep 2008 16:45:41 +0200
Message-ID: <20080903144541.GA10978@homac>
References: <200808301535.22419.sfking@fdwdc.com>
	<20080901112816.GA21970@khazad-dum.debian.net>
	<48BBDD2C.5020804@dbservice.com>
	<200809011205.05253.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200809011205.05253.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tomas Carnecky <tom-ix/z9KG6G0Jl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon 01. Sep - 12:05:04, Steven King wrote:
> On Monday 01 September 2008 5:16:44 Tomas Carnecky wrote:
> 
> > I just tested suspend/resume with the CDROM drive removed (an empty
> > bay). Suspend/resume now works just fine, regardless how I dock/undock
> > the laptop.
> 
> I'm seeing the exact same things as Tom.  Also, in my dmesg I see:
> 
> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: found ejectable bay
> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: Adding notify handler
> ACPI: Error installing bay notify handler
> 
> is this significant?

No, it's not. Bay driver is obsolete with 2.6.26's libata hotplug code.

Regards,
	Holger

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
