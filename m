From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Harddisk problems after S3
Date: Wed, 23 Mar 2005 21:00:09 +0100
Message-ID: <20050323210009.15c78e66.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


Hi everybody,

the first part of the story is at
http://bugme.osdl.org/show_bug.cgi?id=3586

After removing the pushl $0 line in wakeup.S i got a successful resume, and with vbetool the screen was back to life. Had to boot whit vga=normal and unload all modules to get this, will try later to find the showstopping module.

After the resume, when trying to do anything with the disk (like unmount a partition) i got this:

hda dma_timer_expiry: dma status==0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 {DriveReady SeekComplete DataRequest}
ide: failed opcode was: unknown

each line came 15 or 20 seconds after the other, and the whole repeated 4 times. then i got the bash back and everything looked fine.... then when i rebooted it crashed...!!

Maybe this should be discussed togheter with people from other mailing-lists? can somebody point me to the appropriate address?

Thanks,
Alberto




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
