From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Date: Mon, 29 Mar 2004 19:17:50 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040329191750.4bec9da3.rddunlap@osdl.org>
References: <20040325033434.GB8139@atomide.com>
	<20040326030458.GZ9248@cheney.cx>
	<20040326033536.GA8057@atomide.com>
	<1080274911.748.130.camel@dhcppc4>
	<20040326043447.GD9248@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040326043447.GD9248-4Ww5XsWutDyeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Cheney <ccheney-4Ww5XsWutDyeZLLa646FqQ@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, patches-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 25 Mar 2004 22:34:47 -0600 Chris Cheney <ccheney-4Ww5XsWutDyeZLLa646FqQ@public.gmane.org> wrote:

| On Thu, Mar 25, 2004 at 11:21:51PM -0500, Len Brown wrote:
| > On Thu, 2004-03-25 at 22:35, Tony Lindgren wrote:
| > > * Chris Cheney <ccheney-4Ww5XsWutDyeZLLa646FqQ@public.gmane.org> [040325 19:06]:
| > > > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
| > > > 
| > > > BTW - Does this also solve the problem with needing USB to be compiled
| > > > directly into the kernel in 64bit mode?
| > > 
| > > OK, tried it and it does not help there. Also loding ACPI processor and
| > > thermal zone compiled in hangs the machine, but loading them as modules
| > > work.
| > 
| > where does it hang when processor and thermal are compiled-in?
| 
| You had mentioned before there is a way to decompile SSDT with 3rd party
| (non iasl.exe) asl tools, do you happen to know where to get them? Also
| does the usual dsdt override patch (acpi.sf.net) allow you to override
| the ssdt or does it only work for the dsdt?

There are some non-Intel ACPI (dumping) tools in CVS (acpidump and
pmtools/acpi*) at this SF.net project:
  https://sourceforge.net/projects/acpi/
I expect that I need to make those available as tarballs.

And Len has pmtools (and dmidecode) available here:
  http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

However, I'm not aware of any of these decompiling the SSDT...

--
~Randy


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
