From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Soundcard malfunction after suspend/resume cycle
Date: Sun, 20 Nov 2005 22:53:08 +0000
Message-ID: <20051120225308.GD2556@spitz.ucw.cz>
References: <20051118074456.GA18225@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051118074456.GA18225-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri 18-11-05 08:44:56, Pavel Troller wrote:
> Hi!
>   My notebook (Clevo D610SU aka Mironet) exhibits the following problem: 
>   When suspended and resumed, either to RAM or to disk, when a sound is played
> during the suspension, it has problems to continue after resume. Direct access
> to soundcard (either ALSA or OSS emulation) obviously causes the playing
> program (mp3blaster, xmms) to either crash or not to continue playing until
> at least the song is reselected. With artsd from KDE, the sound continues to
> play, but artsd eats almost all CPU cycles, the sound is choppy, even a small
> action like window moving causes drops and interruptions, and artsd finally
> detects system overload and kills itself.
>   Reopening the sound device (restarting artsd/playing program) restores
> normal functionality.
>   I'm not sure whethere it is an ACPI related thing or the soundcard driver
> bug, so I'm asking here for some help, what to do next to debug the thing.

Better report this on ALSA lists...

								Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
