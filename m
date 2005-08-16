From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space
 differences on resume from S3
Date: Tue, 16 Aug 2005 11:52:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508161148570.18302-100000@iolanthe.rowland.org>
References: <1124206957.19419.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1124206957.19419.12.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, USB development list <linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[Removed CC: to mailing lists for which this thread might not be 
appropriate]

On Tue, 16 Aug 2005, Erik Slagter wrote:

> On Tue, 2005-08-16 at 11:37 -0400, Alan Stern wrote:
> > > Diff between "lspci -vvvxxx" before and after resume for all
> > > problematic devices on my machine is attached.
> > > 
> > > Are there any patches I can try?
> > 
> > The uhci-hcd driver _does_ restore the config space for its devices 
> > properly.
> 
> Apparently something is sort of wrong though, because I need to rmmod
> uhci_hcd and hci_usb before suspending, otherwise nasty things happen.

Can you be more specific?  Start with the kernel version you're using.  
What happens if you rmmod hci_usb and leave uhci_hcd alone?  What shows up 
in dmesg?  What shows up if you set CONFIG_USB_DEBUG?

Alan Stern



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
