From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 26 Dec 2004 02:31:13 -0500
Message-ID: <20041226073113.GA919@redhat.com>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome> <41B377AE.7080108@joshuawise.com> <41CE656C.1050500@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41CE656C.1050500-NtISFavHD68j5TC/SZClsA@public.gmane.org>
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

On Sun, Dec 26, 2004 at 02:17:00AM -0500, Joshua Wise wrote:
 > Joshua Wise wrote:
 > >Hm. First, I tried just setting Option "NvAGP" "1" in my XF86Config 
 > >without downgrading, and that seemed to do the trick! I am running the 
 > >latest NVidia drivers: 6629. However, when the system 'comes back to 
 > >life', the wireless is non-functional, as described below. The 
 > >wacom-acpi driver also seems to need to be reloaded: on resume, dmesg 
 > >reports that ttyS4 failed the LSR safety check.
 > 
 > Well, digging this out of the archive.... I figured out why NvAGP 1 
 > "fixed" the problem. It seems that the tc1100's AGP host bridge is in 
 > fact unsupported by the NVIDIA AGP driver, so when we force the NVIDIA 
 > driver's AGP mode, we effectively disable AGP and only use PCI. I wonder 
 > if kernel AGPGART is not doing some sort of appropriate AGP magic before 
 > the NVIDIA driver comes back up?

What does lspci say about the host/pci bridge ?

		Dave



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
