From: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: partial S3 success with 2.6.12-rc5-mm1 and Dell Precision M70
Date: Sun, 29 May 2005 15:16:40 -0700
Message-ID: <9540d010505291516217a7025@mail.gmail.com>
Reply-To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

With 2.6.12-rc4 I've had no luck getting the Precision M70 to enter S3
suspend; however, with 2.6.12-rc5-mm1 and the scsi suspend/resume
patch from Jens Axboe at http://lkml.org/lkml/2005/5/3/54 applied, I'm
able to suspend to S3 and resume provided that:

1) I don't have the tg3 module loaded -- if I suspend with tg3 loaded,
upon resume it spews that it can't reset firmware/can't find the Power
Management capability, and then the machine proceeds to enter into a
cycle where it freezes for 15 seconds or so and then has a burst of
activity.  lspci after resume reports:

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev ff) (prog-if ff)
        !!! Unknown header type 7f

2) I don't have the nvidia binary module loaded -- with the module
loaded, as soon as I see "Back to C!" the LCD backlight goes dark, and
the machine effectively locks; nothing on the serial console, no
response to local keyboard.

I've mailed nvidia about the second issue; any ideas what could be
causing the first?  The two issues may even be related, as whatever is
causing the PCI configuration space for tg3 to be screwed up may also
be causing the same problem for the nvidia device, prompting a hang.

Note that without Jens' patch applied, the machine's LCD would never
come back upon resume (I wouldn't see Back to C or similar), though I
did have control of the machine before it locked up on HD access -- no
combination of vbetool/dpms seemed to revive it without the patch.

dmesg/full lspci/dsdt/etc. output is at
http://bugzilla.kernel.org/show_bug.cgi?id=3D4652 (which I originally
filed for 2.6.12-rc4).

Thanks for any info,
     - Vlad


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
