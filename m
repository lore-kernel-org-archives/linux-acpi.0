From: "Lee, Jung-Ik" <jung-ik.lee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Mon, 23 Sep 2002 16:29:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFE7E@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I use the following check to salience the annoying warnings for my PCI Hot
Plug platform.
Idea is not to print message if the ACPI device has EJECTABLE property.

thanks,
J.I.

         if (!data->dev) {
+	        if (!acpi_device.flags.{ejectable | removable})	// not real
C
                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
                         "Device %02x:%02x:%02x.%02x not present in PCI
namespace
 \n",
                         data->id.segment, data->id.bus, 
                         data->id.device, data->id.function));



-----Original Message-----
From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org]
Sent: Monday, September 23, 2002 4:09 PM
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: Re: [ACPI] CALL FOR TESTING



On Thu, 19 Sep 2002 15:14:16 +0100
Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> wrote:

> So the _PRT is describing routing for ISA devices which don't exist... but
> I wonder if they _might_ exist?  Is it possible that if you plug
> your laptop into a docking station those devices appear, for example?

The same situation also happens for hot-pluggable PCI slots case.
A server with more than 100 empty PCI slots will generate very
annoying massive warning messages on boot (as every slot descrive
8 ACPI Device's for each function).

> Ah, checking the code:
> 
>         /* 
>          * Locate PCI Device
>          * -----------------
>          * Locate matching device in PCI namespace.  If it doesn't exist
>          * this typically means that the device isn't currently inserted
>          * (e.g. docking station, port replicator, etc.).
>          */
> 
>         if (!data->dev) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
>                         "Device %02x:%02x:%02x.%02x not present in PCI
namespace
> \n",
>                         data->id.segment, data->id.bus, 
>                         data->id.device, data->id.function));
> 
> Can I suggest we turn that ACPI_DB_ERROR into ACPI_DB_WARN or even
> ACPI_DB_INFO?  This really isn't an _error_.

Right,
I think we should ignore the case unless we are debugging ACPI <-> PCI
device matching.  So I'd vote ACPI_DB_INFO.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
