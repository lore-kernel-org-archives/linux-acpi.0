From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Harddisk problems after S3
Date: Tue, 29 Mar 2005 20:57:20 +0200
Message-ID: <20050329185720.GC7929@elf.ucw.cz>
References: <20050323210009.15c78e66.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050323210009.15c78e66.albeclemit-whZMOeQn8C0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On St 23-03-05 21:00:09, Alberto Piai wrote:
> 
> Hi everybody,
> 
> the first part of the story is at
> http://bugme.osdl.org/show_bug.cgi?id=3586
> 
> After removing the pushl $0 line in wakeup.S i got a successful resume, and with vbetool the screen was back to life. Had to boot whit vga=normal and unload all modules to get this, will try later to find the showstopping module.
> 
> After the resume, when trying to do anything with the disk (like unmount a partition) i got this:
> 
> hda dma_timer_expiry: dma status==0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 {DriveReady SeekComplete DataRequest}
> ide: failed opcode was: unknown
> 
> each line came 15 or 20 seconds after the other, and the whole repeated 4 times. then i got the bash back and everything looked fine.... then when i rebooted it crashed...!!
> 
> Maybe this should be discussed togheter with people from other mailing-lists? can somebody point me to the appropriate address?
> 

Ask ide maintainers...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
