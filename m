From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: High frequency sound when loading the processor module --   Please help
Date: Fri, 8 Apr 2005 22:39:34 +0200
Message-ID: <20050408203934.GA18490@isilmar.linta.de>
References: <200504081428.48477.gkanis@cems.umn.edu> <200504081447.02303.gkanis@cems.umn.edu> <4256E783.9090607@gmx.net> <200504081528.51796.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504081528.51796.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 08, 2005 at 02:28:51PM -0600, Vasileios Gkanis wrote:
> Hi,
> 
> I have two objections to what you said:
> If what you are saying is correct (I am not arguing with you on the quality of 
> the switches ....you might be right ...)
> 1) I should hear this sound in Windows, but I do not
> 2) I should hear the sound only when the system switches between the states, 
> and not all the time. 
> 
> I think it is a driver issue.

It is the CPU being woken up 1000 times a second, thus switching between the
states indeed this often. You can either use HZ - modifying patch or a patch 
making the system "tickless" to avoid these sounds. Both patch types are 
quite / very experimental, however.

	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
