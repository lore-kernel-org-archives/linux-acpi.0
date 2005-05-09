From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Resume -> higher power drain?
Date: Mon, 09 May 2005 14:38:06 +0100
Message-ID: <1115645886.27560.6.camel@elrond.flymine.org>
References: <427CC869.1050506@kernelconcepts.de>
	 <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <1115475297.10424.4.camel@localhost>
	 <20050507144417.GA3100@isilmar.linta.de>
	 <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de>
	 <20050507200225.GB8212@elf.ucw.cz>
	 <20050509090724.GA7781@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050509090724.GA7781-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

On Mon, 2005-05-09 at 11:07 +0200, Stefan Seyfried wrote:
> On Sat, May 07, 2005 at 10:02:25PM +0200, Pavel Machek wrote:
> 
> > > So at least for my T42p I can recommend NOT to use vbetool at all for
> > > suspend/resume but rather to use s3_bios!
> > 
> > Can you suggest a patch to Documentation/power/video.txt?
> 
> according to some X guys, vbetool vbestate save/restore is "problematic"
> at least and should only be used as a measure of last resort, if everything
> else fails.

The main advantage of saving/restoring the VBE state is that the code to
do so is likely to actually be there, which is something that you can't
say about POSTing. As far as I can tell, there shouldn't be any issue in
making vbestate calls from text mode, especially in situations where the
alternative is to have no graphics functionality at all. It would be
interesting to look at video card state to see what the difference is
afterwards...

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
