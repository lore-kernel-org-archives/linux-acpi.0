From: linux-JhLEnvuH02M@public.gmane.org
Subject: Re: [PATCH] acpi 2.6: consistent user-forced throttling (9/8) [Was: Re: [PATCHES] ACPI Processor update [idle, throttling, thermal, cpufreq]]
Date: Wed, 10 Sep 2003 14:53:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030910125347.GA4019@brodo.de>
References: <20030904222434.GC6350@brodo.de> <20030908132939.GD3944@openzaurus.ucw.cz> <20030909172135.GA4106@brodo.de> <20030909231303.GH211@elf.ucw.cz> <20030909232916.GA9561@brodo.de> <20030910000041.GC217@elf.ucw.cz> <20030910001716.GA10324@brodo.de> <1063191264.23733.1320.camel@idoru.kc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1063191264.23733.1320.camel-65LrUGLyukAb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 10, 2003 at 12:54:24PM +0200, Nils Faerber wrote:
> Am Mi, 2003-09-10 um 02.17 schrieb linux-JhLEnvuH02M@public.gmane.org:
> > As Pavel Machek has noted, it may be desireable for an user to force a
> > ceratin throttling level which is kept even if a thermal "decrease cooling"
> > commands are issued. So, save the user input, and make sure throttling is at
> > least set to this user_state
> [...]
> 
> This makes sense! Thanks!
> Additionally also the performance setting should be kept like this. I
> always have the problem when having used passive cooling that on its way
> down from max-temp the CPU is forced into P0 whereas P1 would conserve
> power and cause less heat.
> Manually resetting to P1 just causes it to be reset to P0 after some
> seconds.

This is one of the "features" in my patchset :-)

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
