From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: make acpi_bus_register_driver() return zero for success, not device count
Date: Thu, 28 Jul 2005 09:26:41 -0600
Message-ID: <200507280926.41472.bjorn.helgaas@hp.com>
References: <200507271628.25844.bjorn.helgaas@hp.com> <20050728115816.GA29744@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050728115816.GA29744-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 28 July 2005 5:58 am, Karol Kozimor wrote:
> Thus wrote Bjorn Helgaas:
> > pci_register_driver() used to return the number of devices claimed,
> > and we made acpi_bus_register_driver() consistent with that.  But
> > pci_register_driver() recently changed to return only success/failure
> > (because the interface is to register the *driver*, not claim devices,
> > and devices may be hot-plugged later).
> > 
> > So let's do the same with acpi_bus_register_driver().
> > 
> > Note that asus_acpi.c used to unregister itself if it didn't claim
> > any devices.  Now it will remain registered, like everything else
> > in drivers/acpi.
> 
> Ugh, not again... we've been there (early 2.6.x), done that and it was
> absolutely confusing (I mean users reporting bogus bugs just because the
> module was loaded type of confusing). Note that there's currently no easy
> way to probe for a specific HID in ACPI namespace other than
> acpi_bus_register_driver(), and unlike pci_register_driver() the former
> has no hotplug mechanism to help. 

True.  But your driver can use its own mechanism to determine whether
it claimed any devices, and if not, call acpi_bus_unregister_driver()
and then return -ENODEV from the module init function to cause the
module to be unloaded.

Or is there some problem that would prevent that?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
