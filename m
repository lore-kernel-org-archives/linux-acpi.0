From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Mon, 09 May 2005 19:12:20 +0800
Message-ID: <1115637140.6149.26.camel@neuromancer.home.net>
References: <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <1115475297.10424.4.camel@localhost>
	 <20050507144417.GA3100@isilmar.linta.de>
	 <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de>
	 <20050507200225.GB8212@elf.ucw.cz> <427D46DE.7010301@kernelconcepts.de>
	 <20050509101930.GB24478@atrey.karlin.mff.cuni.cz>
	 <427F434C.80002@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <427F434C.80002-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-05-09 at 13:02 +0200, Nils Faerber wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Pavel Machek wrote:
> > Hi!
> Hi!
> 
> [...]
> >>>>So at least for my T42p I can recommend NOT to use vbetool at all for
> >>>>suspend/resume but rather to use s3_bios!
> >>>Can you suggest a patch to Documentation/power/video.txt?
> >>I changed the file a little accordingly, a diff is attached.
> >>I think it would be a good idea to start some compatibitlity
> >>documentation, i.e. which device is known to work with which
> >>options/tricks. I appended a "compatibility matrix" to the end of the file.
> >>
> >>Tel me if you find this documentation useful or what can/should be
> >>added/changed.
> > 
> > I do not think we should list multiple ways to make it work. Thats
> > just too complicated. Just one "best" method should be listed...
> 
> OK, I removed the extra "X"'es from the table ;)

Put one on for D600 for S3_Bios..  didn't try S3_mode

but right now, I reverted to using suspend2 instead. 15 secs to
hibernate only.


-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 
98% Microsoft(tm) Free!! 
Neuromancer 19:12:19 up 2:47, 5 users, load average: 0.41, 0.60, 0.71 




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
