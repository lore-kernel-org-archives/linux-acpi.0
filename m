From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Sun, 22 Aug 2004 20:02:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408222002.31563.stefandoesinger@gmx.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <200408202147.51250.stefandoesinger@gmx.at> <20040822103542.GA17227@gamma.logic.tuwien.ac.at>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040822103542.GA17227-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>ACPI: Looking for DSDT in initrd ... found (at offset 20)!
> found customized DSDT with 23575 bytes!
Which kernel? The dsdt in initrd patch doesn't work with 2.6.8.1 for some 
reason. Try the patch which compiles the dsdt into the kernel. Read the 
"another extensive manual", 9a

> Umpf, well, yes, this works. But now even making a
> 	ps -ax
> makes the redrawing stumble. This cannot be the solution, the only one?!
> Are there any other patches I could try?
Do you use a framebuffer? Try without.

Stefan


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
