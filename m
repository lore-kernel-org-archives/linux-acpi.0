From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Sat, 14 Aug 2004 17:34:34 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.14.14.34.33.639754@yahoo.com>
References: <20040810080826.GD28939@aero.ensim.com> <pan.2004.08.10.10.18.05.651578@yahoo.com> <pan.2004.08.10.11.37.29.407984@yahoo.com> <20040810231129.GN28939@aero.ensim.com> <20040810233238.GB16896@hell.org.pl> <pan.2004.08.11.00.33.03.494809@yahoo.com> <20040811074717.GB965@hell.org.pl> <20040814053410.GN20883@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

On Fri, 13 Aug 2004 22:34:10 -0700, Borislav Deianov wrote:
> Come to think of it, that interface already exists. Here is what the
> DSDT does for Fn-F5 (I slightly oversimplified in my previous
> message):
> 
> if a particular bit is set in the mask
> 	if hot key events are enabled
>         	generate ACPI event
> else
>         invoke default hot key behaviour
> 
> This means that if the driver leaves the mask alone on insmod, the
> function keys will continue with their default behavior (e.g. Fn-F5
> will toggle bluetooth, Fn-F7 will switch the screens, etc.). Once the
> mask is set to include the relevant bits, the default behavior is
> stopped and instead ACPI events are generated.
> 
> Version 0.1 set the mask on insmod for convenience, but the plan is to
> not do that in 0.2. If you want hotkey events, after insmod you'll
> have to:
> 
> echo enable > /proc/acpi/ibm/hotkey
> echo ffff > /proc/acpi/ibm/hotkey
> 
> How's that?
> 
> Boris

Hi Boris,

Right now, I am using the way you mentioned above, with the hotkey mask,
but it does not provide enough flexibility.
That is because now I can have one or another, but I cannot have both.
What should I do if I want to activate both bluetooth and wireless ?
I have to enable bluetooth AND have an hotkey event for activating the
wireless, because by default is taken care only of the USB bluetooth, but
nothing is done for the wireless.


Thanks,
Paul



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
