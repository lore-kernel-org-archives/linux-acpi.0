From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 26 Dec 2004 15:52:13 -0500
Message-ID: <41CF247D.3030505@joshuawise.com>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome> <41B377AE.7080108@joshuawise.com> <41CE656C.1050500@joshuawise.com> <20041226073113.GA919@redhat.com> <41CF1DF0.60504@joshuawise.com> <20041226203637.GB26474@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041226203637.GB26474-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> The 855 should work fine with the in-kernel GART driver. The NVidia driver
> I can't say, but I'd be surprised if it doesn't also support it.
Right. The in-kernel GART's AGP support works, but suspend to RAM 
doesn't (or I guess, more accurately, restore from RAM...) The system 
hangs if the NVidia driver is using the GART when suspending/resuming, 
however if I disable AGP, suspend/resume works fine. (well, on the 
graphics driver front, at least.)

> 		Dave
joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
