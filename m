From: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Sat, 14 Aug 2004 14:23:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040814212308.GA6264@aero.ensim.com>
References: <200408141536.i7EFa66Y083568@sana.init-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

On Sat, 14 Aug 2004 15:41:20 +0000 (UTC) Takanori Watanabe <takawata-PURzwyb9WQGaMJb+Lgu22Q@public.gmane.org> wrote:
>
> Hmm, SBDC, GBDC method under HKEY device may be related.
> SBDC takes two mask value.( 0x2 seems Wireless lan related and
> 0x4 is Bluetooth attach method, it seems). 

That's what I'm using to control bluetooth in 0.2. As far as I can
tell, 0x2 turns bluetooth on and off, but I have no idea what 0x4
does. It doesn't seem to affect the wireless in any way, so I think
it's also bluetooth-related. I've left it as "unknown" in
/proc/acpi/ibm/bluetooth, hopefully somebody who has bluetooth support
and devices can figure out what it does.

Boris


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
