From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Mon, 23 Sep 2002 16:09:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020924080844.IAAXC0A82654.59A07363@mvf.biglobe.ne.jp>
References: <1032443504.6326.20.camel@momo> <20020919151416.U10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020919151416.U10583-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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
>                         "Device %02x:%02x:%02x.%02x not present in PCI namespace
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
