From: FrAnKenstEin <fake-3RXyrymLNR0b1SvskN2V4Q@public.gmane.org>
Subject: Re: Armada 110
Date: Thu, 14 Nov 2002 23:17:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021114221725.GA1831@apollo.bingo-ev.de>
References: <20021113205208.GA30683@apollo.bingo-ev.de> <3DD34A64.57D3AC9C@monetplus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3DD34A64.57D3AC9C-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zden?k OGAR Skal?k <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Weee!

Thanks! That works ;)
I actually already had a look at those methods, but i wasn't sure about what the
methods did.. and started Store(..,Debug) - analyzing them ;)

Thanks for your quick help again...

Thomas Jakobi

On Thu, Nov 14, 2002 at 08:01:56AM +0100, Zden?k OGAR Skal?k wrote:
> Hi,
> 
> 	I have Armada 110 too & had the same problem. After fiddling with DSDT, I found
> solution (at least it's working for me :-)
> 	Try this: 
> 		a) dissasemble DSDT
> 		b) patch according to cpqlinux-page
> 		c) patch the method _BST in device BAT1 
>                    (should be in about 11% of file):
>                          Else
>                          {
> 				\_SB.Z000(0x8A)
> 				SEBS /* \_SB.BAT1.SEBS */()
> +				UPBS /* \_SB.BAT1.UPBS */()
> 			 }
> 		d) assemble & try
> 
> 	My own opinion is, that 
> 	a) SEBS is SetBateryStatus <-- store "static status" information about batery		
> 	b) UPBS is UpdateBatteryStatus <-- update according to "current state"
> 
> 	Hope it help :-) By
> 
> 		Zdenek OGAR Skalak
> -- 
> Ing. Zden?k OGAR Skal?k
> Monet+ a.s.
> Z?meck? 365
> 763 14 Zl?n - ?t?pa, CZ
> Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
