From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: ACPI support for add-on devices driver
Date: Thu, 6 Feb 2003 11:44:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206114436.G32277@parcelfarce.linux.theplanet.co.uk>
References: <3E41EFA3.8060406@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E41EFA3.8060406-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>; from sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org on Thu, Feb 06, 2003 at 10:46:19AM +0530
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: siva <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 06, 2003 at 10:46:19AM +0530, siva wrote:
> I like know what I need to do if I want to have ACPI power management 
> support in my driver for an add-on device. When I am browsing APM 
> implementation, I found that Linux kernel have general PM Interfaces 
> like pm_regsiter and pm_unregsiter. In APM driver, pm_send is being 
> called to send notification to all registered add-on devices.

Presumably you're talking about a PCI device?  If so, you should implement the
`new-style' PCI driver interface (Documentation/pci.txt), and provide
implementations for ->suspend, ->resume and ->save_state.  Also see
Documentation/power/pci.txt.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
