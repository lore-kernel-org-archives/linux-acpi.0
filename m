From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 20:38:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408192038.26959.stefandoesinger@gmx.at>
References: <1091139240.26511.9.camel@6-allhosts> <200408052153.25467.stefandoesinger@gmx.at> <20040819174319.GB6913@dreamland.darkstar.lan>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040819174319.GB6913-sTXFmx6KbOnUXq0IF5SVAZ4oGUkBHcCu@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Cc: anib-La3J9u0raUk@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > *the boot-radeon.c program can ROM-post the radeon card(compile with gcc
> > boot-radeon.c -o boot-radeon -llrmi) You need the lrmi libs+headers. Call
> > it after resuming from S3.
>
> Is this radeon specific? AFAICS it should POST any card, right?
Ole Rohne says it's an old IBM PC feature:

"It is an old IBM PC like feature...

If the adapter has BIOS at $0xc000, it is supposed to contain a POST
entry point at $0xc000,$3 and int10/e6 is supposed to point to it."

Just give it a try. Note that the boot-radeon.c has the PCI information 1:0:0 
hardcoded, so you'll have to edit it if your video card is somewhere else.

Stefan


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
