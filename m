From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 26 Dec 2004 15:36:37 -0500
Message-ID: <20041226203637.GB26474@redhat.com>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome> <41B377AE.7080108@joshuawise.com> <41CE656C.1050500@joshuawise.com> <20041226073113.GA919@redhat.com> <41CF1DF0.60504@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41CF1DF0.60504-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Cc: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 26, 2004 at 03:24:16PM -0500, Joshua Wise wrote:
 > >What does lspci say about the host/pci bridge ?
 > 
 > I'm not quite sure what you were asking for.
 > 
 > I first did an lspci -t, knowing that my video card was 01:00.0, and 
 > found the following line (coming off bus 00):
 >       +-01.0-[01]----00.0
 > 
 > So it looks like 00:01.0 is the AGP bridge. I looked in there with lspci 
 > -v -v -s:
 > joshua@shebang:~$ sudo lspci -v -v -s 00:01.0
 > 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller 

The 855 should work fine with the in-kernel GART driver. The NVidia driver
I can't say, but I'd be surprised if it doesn't also support it.

		Dave



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
