From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Resume -> higher power drain?
Date: Mon, 9 May 2005 20:28:36 +0200
Message-ID: <20050509182836.GB25273@message-id.gmane0305.slipkontur.de>
References: <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de> <20050507200225.GB8212@elf.ucw.cz> <20050509090724.GA7781@message-id.gmane0305.slipkontur.de> <1115645886.27560.6.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1115645886.27560.6.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
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

On Mon, May 09, 2005 at 02:38:06PM +0100, Matthew Garrett wrote:
> On Mon, 2005-05-09 at 11:07 +0200, Stefan Seyfried wrote:
> 
> > according to some X guys, vbetool vbestate save/restore is "problematic"
> > at least and should only be used as a measure of last resort, if everything
> > else fails.

Again, to be clear: this is not my wisdom but from people who know the radeon
chips prettty good (Matthias Hopf, among others)

> The main advantage of saving/restoring the VBE state is that the code to
> do so is likely to actually be there, which is something that you can't
> say about POSTing. As far as I can tell, there shouldn't be any issue in

The radeon X driver apparently knows enough about the chips to re-post them.
Excerpt from my X log:
(WW) RADEON(0): zero MEMSIZE, probably at D3cold. Re-POSTing via int10.
(II) RADEON(0): Primary V_BIOS segment is: 0xc000

> making vbestate calls from text mode, especially in situations where the
> alternative is to have no graphics functionality at all. It would be

Thats what i meant with "only be used as a measure of last resort" :-)

> interesting to look at video card state to see what the difference is
> afterwards...

Probably. Note that i have no knowledge about graphics cards at all, i just
tell what i have been told ;-)
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
