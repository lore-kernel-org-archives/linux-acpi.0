From: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Date: Thu, 26 May 2005 07:56:56 +0200
Message-ID: <20050526055656.GB26788@pern.dea.icai.upco.es>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050525212520.419ee442.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: pavel-+ZI9xUNit7I@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 25, 2005 at 09:25:20PM -0700, Andrew Morton wrote:
> Romano Giannetti <romanol-qvIf60buks8@public.gmane.org> wrote:
> >
> > Hi all,
> > 
> >    swsusp is not working for me with 2.6.12rc1. I compiled the kernel
> >    preempt, I am compiling now without preempt to test it. -mm3 has a
> >    similar behaviour.
> >    
> >    All the configuration, dmesg, lsmod etc is here: 
> >    http://www.dea.icai.upco.es/romano/linux/config-2.6.12-rc1/laptop-config.html   
> > 
> >    
> >    Perfectly working (swsup included) similar data is in: 
> >    http://www.dea.icai.upco.es/romano/linux/config-2.6.11-rg/laptop-config.html
> > 
> >    When suspending, it stops dead with thi two lines (hand copied) 
> >    
> >    ACPI: PCI interrupt 0000:00:07.5 [C] -> GSI 5 (level, low) -> IRQ5
> >    ACPI: PCI interrupt 0000:00:0e.0 [A] -> GSI 9 (level, low) -> IRQ9
> >    
> >    ...and nothing more. 
> >    
> 
> Romano, are you able to tell us whether 2.6.12-rc5 or 2.6.12-rc5-mm1 still
> exhibit this hang?

I will try over the weekend (it's a busy period here...). But I have to add
that this is not a real regression. 2.6.11 will suspend, but it did not
resume well if PREEMPT is enabled for me (a lot of "scheduling while atomic"
too). 

There is more data here: 

http://www.dea.icai.upco.es/romano/linux/br/acpi-preempt.txt

                Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
