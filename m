From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: ibm-acpi-0.1
Date: Sat, 14 Aug 2004 15:36:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040814133614.GA3139@hell.org.pl>
References: <20040810080826.GD28939@aero.ensim.com> <pan.2004.08.10.10.18.05.651578@yahoo.com> <pan.2004.08.10.11.37.29.407984@yahoo.com> <20040810231129.GN28939@aero.ensim.com> <20040810233238.GB16896@hell.org.pl> <pan.2004.08.11.00.33.03.494809@yahoo.com> <20040811074717.GB965@hell.org.pl> <20040814053410.GN20883@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040814053410.GN20883-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
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

Thus wrote Borislav Deianov:
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

I guess it might still be a good way to go with both, i.e. do the AML magic
to turn the device on _and_ generate an event in case the user wanted to
run hciattach for example. On the other hand, if that's a USB device
hotplug may suffice.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
