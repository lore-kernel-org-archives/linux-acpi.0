From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Wed, 27 Jul 2005 17:06:49 -0600
Message-ID: <200507271706.49044.bjorn.helgaas@hp.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200507261356.08152.bjorn.helgaas@hp.com> <20050726170459.A5591@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050726170459.A5591-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
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
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 26 July 2005 6:05 pm, Keshavamurthy Anil S wrote:
> Having to call add() method for non-present device would be a bad idea,
> instead of this I prefer to see add() getting called when new device gets
> added. Again for this to happen the ACPI core should be changed to take 
> care of handling the SCI notifications and checking to see is there a driver 
> for this device and if it is present calling drivers add() method. This
> will eliminate all the driver having to walk the namespace and register
> a notification.

OK, this sounds like a fruitful area for inquiry.  At least
for memory and container, it looks like the code we run for 
ACPI_NOTIFY_DEVICE_CHECK is pretty generic and very similar.

I don't know very much about how notifiers work.  But I'll
poke around and see if there's a way to have the ACPI core
catch the event when a driver hasn't registered for it.
Then it could do the generic stuff leading up to acpi_bus_add(),
and the driver add() methods could do the rest.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
