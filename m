From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Mon, 9 May 2005 19:56:43 +0200
Message-ID: <20050509175643.GA24233@message-id.gmane0305.slipkontur.de>
References: <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de> <20050507200225.GB8212@elf.ucw.cz> <427D46DE.7010301@kernelconcepts.de> <20050509101930.GB24478@atrey.karlin.mff.cuni.cz> <427F434C.80002@kernelconcepts.de> <1115637140.6149.26.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1115637140.6149.26.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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

On Mon, May 09, 2005 at 07:12:20PM +0800, Ow Mun Heng wrote:

> > OK, I removed the extra "X"'es from the table ;)
> 
> Put one on for D600 for S3_Bios..  didn't try S3_mode

This is not a generally "known good" solution :-(
All my D600 and D800 reboot instead of resuming with _any_ acpi_sleep=
parameter. They only work with vga=normal and the X.org radeon driver
(D600) or the binary NVidia driver (D800) brings back the gfx card.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
