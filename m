From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Mon, 08 Nov 2004 13:53:25 -0800
Message-ID: <418FEAD5.1000007@root.org>
References: <20041108144947.GA31267@tate.loria.fr> <20041108213558.GB4607@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041108213558.GB4607-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: =?ISO-8859-1?Q?Emmanuel_Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, ole.rohne-vJEk5272eHo@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
>>Sorry I've been off for a week. Here is the version of the s3_late_bios
>>patch with the segment info coded in C.
>>
>>If somebody comes up with an attempt at resuming the video from the early
>>real mode phase by calling the pci bios, I'm all for testing it.
> 
> It looks good to me...

I'm not sure I understand the reason for this or how it works.  Does it 
POST VGA via the "lcall $0xc000,$3" or the "int 10h" method?  I assume 
the reason it's called by the PCI code is that you want the device to be 
set to D0 and device-specific resume methods called before POSTing it?
Why the switch to real mode to run the BIOS call?  Can't this be done 
from vm86 mode?

-- 
Nate


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
