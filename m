From: jbarnes-sJ/iWh9BUns@public.gmane.org (Jesse Barnes)
Subject: Re: Re: [DMESG] cpumask_t in action
Date: Fri, 7 Nov 2003 10:13:15 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031107181315.GA1162@sgi.com>
References: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain> <20031107172456.GC23754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031107172456.GC23754-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Sylvain Jeaugey <sylvain.jeaugey-6ktuUTfB/bM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 07, 2003 at 05:24:56PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 07, 2003 at 09:13:11AM +0100, Sylvain Jeaugey wrote:
> > On Thu, 6 Nov 2003, Matthew Wilcox wrote:
> > These lines show you the numa topology of your machine (in our case, we 
> > have 2 CPUS per domain, and a memory area).
> > This is quite a big piece of information about hardware. Even if it is 
> > quite long, I think it should be part of the ACPI information.
> 
> Yes, but do we need to know it at boot time, or should it be available
> in some other way (eg /proc/acpi/srat or something).  I would argue
> that is more useful than seeing it in dmesg.

There's also /sys which contains information about which cpus are on
which nodes.

Jesse


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
