From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Resum power drain, T42p final conclusion!
Date: Mon, 9 May 2005 22:51:07 +0200
Message-ID: <20050509205107.GC25273@message-id.gmane0305.slipkontur.de>
References: <427FAC68.2020106@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427FAC68.2020106-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 09, 2005 at 08:31:04PM +0200, Nils Faerber wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> I finally tested everything possible and double/triple checked the
> scripts and it came down to the very simple solution:
> 
> 	vbetool is evil is evil is evil

not what i have been telling, but what i have been told ;-)

> I already had vbetool savestate disabled but there was still a call to
> vbetool dpms in the scripts.
> After removing that too I am back to normal again, i.e. I use s3_bios
> option and nothing else to get video back (BTW: no framebuffer console,
> plain VGA text).

If you use vesafb, you probably need "s3_bios,s3_mode" to get the video
mode restored.

> Just to be very sure I did
> 	ln -sf /bin/true /usr/sbin/vbetool
> 
> 
> So, many thanks for the good ideas an advice!

Just to clarify: what vbetool calls were executed (and when: suspend?
resume? both?) and what did they cause?

And did the same happen with swsusp? If yes, which mode was set in 
/sys/power/disk (platform or shutdown)? Was vbetool also called on
swsusp?
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
