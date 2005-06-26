From: Janosch Machowinski <jmachowinski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Fw: ACPI and the idle loop - possible bug
Date: Sun, 26 Jun 2005 02:05:03 +0200
Message-ID: <1119744303.14822.9.camel@localhost>
References: <20050625151923.738504b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050625151923.738504b1.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Baums <baums@u.washington.edu>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Some Lenove (IBM) ThinkPad models (in my case the ThinkPad X41
> 2528-6NU) produce irritating high-pitch crackling noises under
> Linux in certain conditions
This Problem also occures on a lot of ASUS Laptops,
sounds a bit like the morse alpabet ;-)

> This noise only occurs when the processor is not busy (with, e.g.,
> compiling or video playback), so it seems to be related to the
> idle loop (see also below about 'idle=halt').  Furthermore, it
> seems to be caused by something that ACPI is doing to the
> processor: if the 'processor' module (and its dependants:
> 'speedstep_centrino'/'acpi_cpufreq' and 'thermal') are not loaded,
> the high-pitch noise does not occur.
> 
My suggestion is that this sounds are created by the powerconverters.
And it only occurs on my ASUS M6 when the processor is in C3.
So the described behaviour is clear, cause if you unload the processor
ACPI module, you processor will stop going in C3 and thou the sounds
stop. 


> If the 'processor' module (and its dependants) _are_ loaded, then
> the noise can be initially avoided by passing the boot parameter
> 
>    idle=halt

What exactly does this parameter do ? Using for all C-States the hlt
instruction ?

>    - First, for causing the high-pitch noise to start with, though
>      it could be argued that this is a hardware defect that is
>      just triggered by ACPI.  (However not by Windows XP, on the
>      same computer, so it is definitely avoidable.)
> 
Could also be that XP dosen't use C3 as much as Linux does


	Janosch



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
