From: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Tue, 5 Apr 2005 22:23:17 +0200
Message-ID: <200504052223.17547.jfrey@gmx.de>
References: <200504042214.15648.jfrey@gmx.de> <200504051813.28983.jfrey@gmx.de> <20050405180826.GU2298@poupinou.org>
Reply-To: jfrey-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405180826.GU2298-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
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
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 05 April 2005 20:08, Bruno Ducrot wrote:
> On Tue, Apr 05, 2005 at 06:13:28PM +0200, Jan Frey wrote:
> > Really astonishing: CPU temperature seems to go up to roughly 70
> > degrees quite quickly and then it stays there nearly forever: it does
> > not matter whether CPU load is 0 or 1.. And: throttling also does not
> > lower CPU temp, I thought this would be main reason...
>
> BTW, are you sure throttling work OK?

At least you can notice remarkable slowdown and loss of responsiveness when 
throttling is supposed to be active. This effect is also dependent on the 
throttling level, the higher it is the more noticeable those delays are...
So at least on the "slow-down" side of things it seems to be working, but 
unfortunately it does not decrease CPU temp...

> Then mail me the acpidmp.out.bz2
 
I will do so as soon as possible.

> I'm still wondering if I'm right to think that its not an intel
> chipset.  If its an Intel one, then something is wrong.  Intel chipset
> support 8 throttling levels, not 16.  Could you please do a lspci -v?

Oh yes, I totally forgot. If I remember correctly it is some VIA chipset.
lspci output will also follow.

Br
Jan

-- 
Jan Frey
jfrey-Mmb7MZpHnFY@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
