From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Sun, 22 Aug 2004 22:16:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040822201636.GA10152@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <200408202147.51250.stefandoesinger@gmx.at> <20040822103542.GA17227@gamma.logic.tuwien.ac.at> <200408222002.31563.stefandoesinger@gmx.at> <20040822194512.GA8158@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040822194512.GA8158-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
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

Hi Stefan!

On Son, 22 Aug 2004, Norbert Preining wrote:
> On Son, 22 Aug 2004, Stefan Dösinger wrote:
> > >ACPI: Looking for DSDT in initrd ... found (at offset 20)!
> > > found customized DSDT with 23575 bytes!
> >
> > Which kernel? The dsdt in initrd patch doesn't work with 2.6.8.1 for some 
> > reason. Try the patch which compiles the dsdt into the kernel. Read the 
> > "another extensive manual", 9a

Bingo. THanks for the hint. Now I am getting ac_adapter events. Great.

Now I have only to get S2D and S2R to be fixed ...

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
MAARUIG (n.)
The inexpressible horror experienced on walking up in the morning and
remembering that you are Andy Stewart.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
