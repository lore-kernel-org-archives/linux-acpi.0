From: <gava-7azNGskkaze/k5lE4H/icg@public.gmane.org>
Subject: Re: Re: ACPI, Acer Aspire 1700 series and Kernel 2.6
Date: Sat, 7 Feb 2004 17:33:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <00d101c3ed98$3a226390$21b35452@KXPP>
References: <16420.5826.162449.28729@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Henny Wilbrink <wsdwhw-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank's very much Henny,
it works!!
i suggesto also to Praveen C (mesasage [ACPI] acpi on r40e) to vrify if he
has
P&P support enable on kernel configuration
Regards
   kolja

----- Original Message ----- 
From: "Henny Wilbrink" <wsdwhw-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org>
To: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Friday, February 06, 2004 11:35 PM
Subject: [ACPI] Re: ACPI, Acer Aspire 1700 series and Kernel 2.6


> Hi,
>
> >> * thermal module can't be loaded
> >>   if thermal module is started automatically get a system shutdown
cause a
> >> 255c CPU themp was retreived.
>
> I have an Acer Aspire 1703 and also experience your 255C CPU
> temperature shutdown at boot
>
> but only if a enable:
>
> Device Drivers > Plug and Play support > Plug and Play BIOS support
>
> in xconfig.
>
> Your dmesg shows that you have enabled Plug and Play BIOS support so
> give it a try without Plug and Play BIOS support.
>
>
> Regards,
> Henny Wilbrink
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
