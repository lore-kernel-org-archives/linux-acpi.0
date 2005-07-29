From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Thu, 28 Jul 2005 17:52:17 -0700
Message-ID: <20050728175217.A1821@unix-os.sc.intel.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com> <b115cb5f0507241949da02aa7@mail.gmail.com> <512afbf905072711295f87ad24@mail.gmail.com> <b115cb5f05072803451836055c@mail.gmail.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b115cb5f05072803451836055c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>; from rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org on Thu, Jul 28, 2005 at 07:45:49PM +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajat Jain <rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kristen Accardi <kristen.kml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-newbie-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dkumar-QByN7dn/BetQWC9lL0RKGQC/G2K4zDHf@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 28, 2005 at 07:45:49PM +0900, Rajat Jain wrote:
> 
> Okay. I'm sorry but I'm not very clear with this. I'm just putting
> down here my understanding. So basically we have two mutually
> EXCLUSIVE hotplug drivers I can use for PCI Express:
> 
A hotplug slot can be controlled only by a single hotplug
technology - pcie shpc or acpiphp. However, different parts of
the I/O hierarchy can be controlled by different technologies.
For example, a host bridge I/O complex can be hotplugged using
acpiphp, but end devices under this IO complex may be hotpplugged
using pcie or shpc hotplug.

> 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> Native Hot-plug for PCI Express (which means that hot-plug will be
> handled by OS single handedly).
> 
> 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> allows only ITSELF to handle hot-plug events.
> 
No, acpi hotplug is not handled by BIOS only.
Both acpi and pcie hotplug need firmware support as well as hardware
support. Hardware in many (but not all) systems support both types of
hotplug and its up to the BIOS to decide which type to support. If the
platform supports pcie hotplug, you see an _OSC & _SUN methods in the
ACPI namespace and the pciehp driver controls hotplug slots. If the
system supports acpi hotplug, you see _ADR and _EJ0 methods in the ACPI
namespace and the acpiphp driver controls the corresponding hotplug slots.

Rajesh


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
