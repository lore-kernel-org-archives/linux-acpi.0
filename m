From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Mon, 30 May 2005 09:48:58 -0700
Message-ID: <1117471738.398.18.camel@localhost.localdomain>
References: <1117244104.21648.1.camel@localhost.localdomain>
	 <20050528101450.GA19354@fingerbrecher>
	 <1117397912.24721.5.camel@localhost.localdomain>
	 <20050530130147.GH32472@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050530130147.GH32472-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-05-30 at 15:01 +0200, Bruno Ducrot wrote:
> On Sun, May 29, 2005 at 01:18:32PM -0700, James Sparenberg wrote:
> > Ok Laptop in question is an Acer Aspire 3000 which other than acpi
> > hardware is 100% (nice feeling)  Rather than put up all of the errors
> > I'll break them into 3 groups.
> > 
> > 1.  1094 error (which I've a feeling if I fix others will follow) of
> > which there are 3 types. 
> > 
> >       dsdt.dsl   743:                     0x0100, 0x00,,)
> >       Error    1094 -                                   ^ Missing
> > ResourceSource string (required)
> > 
> >       dsdt.dsl   750:                     , AddressRangeMemory,
> > TypeStatic)
> >       Error    1094 -            Missing ResourceSource string
> > (required) ^
> > 
> > The second one I have about 20 of .... each time the Add........ line
> > appears so one fix style should get me.
> 
> 
> I suspect your iasl is broken somehow: a ResourceSource string is optional.
> 
> > 2.  The other errors I'm not finding docs on are related to PPC 
> > 
> >       dsdt.dsl  2506:                             If (LNot (LEqual
> > (\_PR.CPU0._PPC, 0x00)))
> >       Error    1022 -                                      Object does
> > not exist ^               (\_PR.CPU0._PPC)
> > 
> >       dsdt.dsl  2508:                                 Store (0x00,
> > \_PR.CPU0._PPC)
> >       Error    1022 -                                     Object does
> > not exist ^  (\_PR.CPU0._PPC)
> > 
> >       dsdt.dsl  2516:                             If (LLess
> > (\_PR.CPU0._PPC, Local1))
> >       Error    1022 -                               Object does not
> > exist ^  (\_PR.CPU0._PPC)
> > 
> > There are about 10 of these.
> 
> This node is likely defined under another ACPI table called SSDT.
> Please get ACPI spec from www.acpi.info but only if you are curious
> about SSDT and the like..
> 
> I will check this but I need a full ACPI dump.
> 
> Could you please send a web link or, if you can not, send to me
> privately the output from acpidmp after doing something like that:
> 
> wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
> tar xjvfp pmtools-20031210.tar.bz2
> cd pmtools-20031210/acpidmp
> make
> sudo ./acpidmp > acpidmp.out
> bzip2 acpidmp.out 
> 
> I will also check if I'm correct with point 1.
> 
> Cheers,
> 

Bruce,  

   First thanks for the offer of help and yes I'm starting to did into
the spec.  Shorter read than the LSB though not by much *grin*

I sent the outputs asked for via a direct mail as you asked.  But I
didn't want to post those links into a forum than gets publicly
archived.  If anyone else wants the data I'll be glad to let them see it
as well.  

The reason for starting this endevor is a set of acpi related error
messages that fill up my logs (at the rate of about 1 every 2 seconds) 

    ACPI-0352: *** Error: Looking up [Z007] in namespace, AE_NOT_FOUND
search_node cbec2e20 start_node cbec2e20 return_node 00000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.BAT1._BST]
(Node cbec2d20), AE_NOT_FOUND


I've noticed 2 rather interesting things ...

1.  Windows is only slightly better on power management with this DSDT
than Linux.  
2.  This DSDT does have the "Windows Only" settings in it.  Surprisingly
it doesn't have an entry for WindowsXP.   (I've a feeling somebody cut
and pasted an older DSDT.)

I did file a bug so to speak with Acer a prompt "Thank you for the
information we are looking into the matter type letter", but somehow it
did have a feel about it that it did raise and eyebrow so maybe they can
help sometime in the next 6 months to a year.  *grin*

James




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
