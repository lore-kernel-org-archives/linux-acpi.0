From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Sun, 22 Aug 2004 21:45:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040822194512.GA8158@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <200408202147.51250.stefandoesinger@gmx.at> <20040822103542.GA17227@gamma.logic.tuwien.ac.at> <200408222002.31563.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408222002.31563.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Stefan!

On Son, 22 Aug 2004, Stefan Dösinger wrote:
> >ACPI: Looking for DSDT in initrd ... found (at offset 20)!
> > found customized DSDT with 23575 bytes!
>
> Which kernel? The dsdt in initrd patch doesn't work with 2.6.8.1 for some 
> reason. Try the patch which compiles the dsdt into the kernel. Read the 
> "another extensive manual", 9a

Hmm, strange, I have 2.6.8.1-mm4 plus the initrd/dsdt patch running and
the kernel tells me the above. So it tells me that the dsdt is found,
but not used. Thanks for the information, I will check on this.

> > Umpf, well, yes, this works. But now even making a
> > 	ps -ax
> > makes the redrawing stumble. This cannot be the solution, the only one?!
> > Are there any other patches I could try?
>
> Do you use a framebuffer? Try without.

No framebuffer. USB and all other stuff disabled or modular. Of course I
have tried all these already.

Thanks a lot for your patience, und schöne Grüße !

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
The major difference between a thing that might go wrong
and a thing that cannot possibly go wrong is that when a
thing that cannot possibly go wrong goes wrong it usually
turns out to be impossible to get at or repair.
                 --- One of the laws of computers and programming revealed.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
