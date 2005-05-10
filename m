From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Resume -> higher power drain?
Date: Tue, 10 May 2005 10:27:30 +0200
Message-ID: <42807072.7040005@gmx.net>
References: <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de> <20050507200225.GB8212@elf.ucw.cz> <20050509090724.GA7781@message-id.gmane0305.slipkontur.de> <1115645886.27560.6.camel@elrond.flymine.org> <20050509182836.GB25273@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050509182836.GB25273-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

Stefan Seyfried schrieb:
> On Mon, May 09, 2005 at 02:38:06PM +0100, Matthew Garrett wrote:
> 
>>On Mon, 2005-05-09 at 11:07 +0200, Stefan Seyfried wrote:
>>
>>
>>>according to some X guys, vbetool vbestate save/restore is "problematic"
>>>at least and should only be used as a measure of last resort, if everything
>>>else fails.
> 
> 
> Again, to be clear: this is not my wisdom but from people who know the radeon
> chips prettty good (Matthias Hopf, among others)
> 
> 
>>The main advantage of saving/restoring the VBE state is that the code to
>>do so is likely to actually be there, which is something that you can't
>>say about POSTing. As far as I can tell, there shouldn't be any issue in
> 
> 
> The radeon X driver apparently knows enough about the chips to re-post them.
> Excerpt from my X log:
> (WW) RADEON(0): zero MEMSIZE, probably at D3cold. Re-POSTing via int10.
> (II) RADEON(0): Primary V_BIOS segment is: 0xc000

Can you please ask the gurus: What is the difference between POSTing with
the X driver and POSTing with vbetool, if both versions use int10? And can
I have the "better int10" of the X driver as an isolated piece of code so
that resume will eventually work even if X is not running?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
