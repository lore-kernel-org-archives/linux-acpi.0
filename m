From: "sdfa" <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>
Subject: hard drive errors on acpi s3 resume
Date: Fri,  4 Nov 2005 01:39:46 -0500 (EST)
Message-ID: <20051104063946.BB9CA3DF4@xprdmailfe12.nwk.excite.com>
Reply-To: slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


i've been trying to get s3 working on my sony vaio, but i'm having some problems concerning the hard drive during resume. after a resume i see these messages in dmesg:



hda: lost interrupt

 evevent-0299: *** Error: No installed handler for fixed event [00000002]

Restarting tasks... done

hda: dma_timer_expiry: dma status == 0x21

hda: DMA timeout error

hda: dma timeout error: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

hda: status error: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

hda: no DRQ after issuing MULTWRITE_EXT

hda: status error: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

hda: no DRQ after issuing MULTWRITE_EXT

hda: lost interrupt

hda: status error: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

hda: no DRQ after issuing MULTWRITE_EXT

hda: status error: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

hda: no DRQ after issuing MULTWRITE_EXT

ide0: reset: success



sometimes i also see this message right before all of this, i'm not sure if it's related:

acpi_bus_0200 [77] bus_set_power      : Device is not power manageable



the drive eventually spins up and the resume is a success, but it takes like two minutes(too long) and i'm afraid it may be damaging my hard drive.



the drive is an ide ata drive with an ich4-m controller.

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
