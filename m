From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Tue, 9 Nov 2004 13:55:22 +0100
Message-ID: <20041109125522.GA8015@tate.loria.fr>
References: <20041108144947.GA31267@tate.loria.fr> <20041108213558.GB4607@elf.ucw.cz> <418FEAD5.1000007@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <418FEAD5.1000007-Y6VGUYTwhu0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Mon, Nov 08, 2004 at 01:53:25PM -0800, Nate Lawson wrote:
> I'm not sure I understand the reason for this or how it works.  Does it 
> POST VGA via the "lcall $0xc000,$3" or the "int 10h" method?  I assume 

lcall.

> the reason it's called by the PCI code is that you want the device to be 
> set to D0 and device-specific resume methods called before POSTing it?

acpi_vgapost is meant to hook into the device-specific resume methods.
Indeed, the pci device is set to D0 prior to calling acpi_vgapost.

Doing POST from the early resume phase seems just too early ; too many
things are unitialized at this point. Doing it later on is more
convenient.

> Why the switch to real mode to run the BIOS call?  Can't this be done 
> from vm86 mode?

Yes it can, at least I think so. You're welcome to tweak this to do it in
a vm86 mode if you like.

E.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
