From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 19:09:05 +0000
Message-ID: <1103224145.5984.72.camel@tyrosine>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>
	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03>
	 <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>
	 <41C1CFA2.20304@gmx.net>  <1103222517.5924.24.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103222517.5924.24.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-12-16 at 19:41 +0100, Matthias Hentges wrote:

> 1: VGA POST
> 2. VESA reset

Can you try the vm86_video_post and vbestate programs from
http://www.srcf.ucam.org/~mjg59/laptops/ ? You want to do something like
this:

1) chvt away from X on suspend
2) vbestate save >/tmp/state
3) suspend
4) resume
5) vm86_video_post
6) vbestate restore </tmp/state
7) chvt back to X

This sequence (possibly with a dpms on in there somewhere) seems to work
on a fairly large number of machines.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
