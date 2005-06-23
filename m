From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: video module limited after suspend
Date: Thu, 23 Jun 2005 18:39:36 +0200
Message-ID: <20050623163936.GH8899@poupinou.org>
References: <m28y199cf4.fsf@tnuctip.rychter.com> <m2k6kmagyy.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2k6kmagyy.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 22, 2005 at 11:17:09AM +0200, Jan Rychter wrote:
> > Hi,
> > I have ACPI compiled into the kernel and various subsystems as
> > modules. The 'video' module seems to have a problem, though -- it works
> > great on first boot, but doesn't work correctly after a suspend/resume
> > (I'm using suspend2, unloading and reloading the video module after
> > resuming).
> > 
> > The symptoms are that all subdirectories of /proc/acpi/video/VGA/
> > disappear -- which means I can no longer set the LCD brighness. All I
> > have is this:
> > 
> > total 0
> > -r--r--r--  1 root root 0 Jun 17 18:25 DOS
> > -r--r--r--  1 root root 0 Jun 17 18:25 POST
> > -r--r--r--  1 root root 0 Jun 17 18:25 POST_info
> > -r--r--r--  1 root root 0 Jun 17 18:25 ROM
> > -r--r--r--  1 root root 0 Jun 17 18:25 info
> > 
> > Any hints?
> 
> To narrow things down a bit: I've found out that it isn't really
> suspending that matters -- just doing 
> 
> modprobe video; rmmod video; modprobe video
> 
> gets me a system without the CRT, LCD, DVI and TV directories.
> 
> As a workaround, I've just compiled video into the kernel (e.g. not
> modularized) and I'm fine.
> 
> Is anyone actually interested in those bug reports? Should I bother?
> 

Me, but don't have time for linux kernel devel ATM

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
