From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
Date: Tue, 03 Aug 2004 11:34:01 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091558040.27397.5523.camel@nighthawk>
References: <1091552426.4981.103.camel@tdi>
	 <1091554271.27397.5327.camel@nighthawk>  <1091557050.4981.135.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091557050.4981.135.camel@tdi>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-03 at 11:17, Alex Williamson wrote:
> On Tue, 2004-08-03 at 10:31 -0700, Dave Hansen wrote:
> > So, what kinds of generic, arch-independent interfaces should we
> > implement in the kernel that would reduce the need for something like
> > your driver?
> 
>    I agree with your intent, but I'm not sure a common kernel interface
> is feasible or desired.  This driver would be much more useful if it was
> cleverly abstracted by a userspace library.  Should we try to make the
> common layer be the library interface?  Obviously the more similar the
> kernel interface, the easier, but I'm not ready to sign-up to architect
> a generic interface.

Instead of architecting a generic interface, might you simply exclude
access from your driver to things that already have generic interfaces? 
I think there are things that we exclude from /proc/device-tree on ppc64
because there's a generic equivalent elsewhere.  

>    The ACPI interface could be used to do everything from switching a
> laptop display between the interfaces to listing and configuring/de-
> configuring specific pieces of hardware.  There will be a set of
> functionality that's common across multiple interfaces, but I don't want
> to prevent the usage that is very specific to the underlying
> implementation.

There are certainly some very platform-specific things that obviously
need to be done with direct access to the firmware, and that we don't
want to pollute the kernel with.  Parsing some of the firmware error
logs on ppc64 comes to mind.  You just need to be *very* careful with
the application authors because it's such a big gun :)

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
