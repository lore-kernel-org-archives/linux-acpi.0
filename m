From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Mon, 22 Sep 2003 09:56:17 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
 <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at> <3F6EAADC.4020509@basmevissen.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F6EAADC.4020509-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sep 22, Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org> wrote:

> Markus Gaugusch wrote:
> > On Sep 18, Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> >>Reading the battery status still consumes insane amounts of CPU time
> >
> > Recently, a bug has been fixed by some nice person at intel - the AML code
> > was executed twice. Although half of the time is still not perfect, it is
> > a lot better now.
> >
>
> But on Windows, there is no slowdown noticeable. Is that just the
> different implementation or is there still something (too) slow in the
> Intel ACPI CA code?
I don't think, that the code is slow, but during execution of the battery
query (which takes some time, because it is on a slow bus) the kernel
seems to hang - probably a kernel thread would cure this problem, but I'm
no expert in this area.

Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
