From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Processor C states and USB problem
Date: Fri, 9 Jan 2004 09:35:53 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040109093553.31aa1c79.rddunlap@osdl.org>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84E6C@PDSMSX403.ccr.corp.intel.com>
	<1073640699.10144.14.camel@ltspc67.epfl.ch>
	<Pine.LNX.4.58.0401091102120.20682@pcd403z.vsb.cz>
	<1073643322.10144.23.camel@ltspc67.epfl.ch>
	<20040109165421.6fc2483a.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040109165421.6fc2483a.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Diego.SantaCruz-p8DiymsW2f8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 9 Jan 2004 16:54:21 +0100 Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org> wrote:

| On Fri, 09 Jan 2004 11:15:22 +0100
| Diego SANTA CRUZ <Diego.SantaCruz-p8DiymsW2f8@public.gmane.org> wrote:
| 
| > On Fri, 2004-01-09 at 11:05, Petr Olivka wrote:
| > > in 2.4 kernel I have to unload all usb modules. Then power drop to C3
| > > state. If I remember, only usbcore can be loaded (on my D600).
| > > 
| > 
| > But even booting with init=/bin/sh and without ever loading any USB
| > module I get permanent bus mastering activity. Any ideas?
| 
| I see the same on my notebook with a 2.4 kernel. Sometimes it works, but most of the time
| there is Bus master acitivty.
| With 2.6 I only see that if I have a USB device plugged in (mouse) that gets polled.

It seems like one of the early usb uhci host controller drivers (HCDs)
generated lots of bus master activity.  Are you sure that uhci or
usb-uhci is not loaded (in the 2.4 problem case), even though no
USB device drivers are loaded?

--
~Randy
MOTD:  Always include version info.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
