From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 15:14:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919151416.U10583@parcelfarce.linux.theplanet.co.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <1032428873.6326.5.camel@momo> <20020919144450.T10583@parcelfarce.linux.theplanet.co.uk> <1032443504.6326.20.camel@momo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1032443504.6326.20.camel-nTaTgD4n72I@public.gmane.org>; from fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org on Thu, Sep 19, 2002 at 03:51:44PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 19, 2002 at 03:51:44PM +0200, Federico Di Gregorio wrote:
> acpi kernel is much better than marcelo's. i get a lot of errors on it.

ok, so that's a +1 for the patch ;-)

> > Interesting ... could you send the output from /sbin/lspci -s 00: I
> > suspect a bug in your machine's _PRT -- it's describing routing for a
> > device which doesn't exist.  Maybe we should silently ignore that.

> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)

So the _PRT is describing routing for ISA devices which don't exist... but
I wonder if they _might_ exist?  Is it possible that if you plug
your laptop into a docking station those devices appear, for example?

Ah, checking the code:

        /* 
         * Locate PCI Device
         * -----------------
         * Locate matching device in PCI namespace.  If it doesn't exist
         * this typically means that the device isn't currently inserted
         * (e.g. docking station, port replicator, etc.).
         */

        if (!data->dev) {
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
                        "Device %02x:%02x:%02x.%02x not present in PCI namespace
\n",
                        data->id.segment, data->id.bus, 
                        data->id.device, data->id.function));

Can I suggest we turn that ACPI_DB_ERROR into ACPI_DB_WARN or even
ACPI_DB_INFO?  This really isn't an _error_.

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
