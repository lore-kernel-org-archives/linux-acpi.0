From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How to debug (not working)S3?
Date: Sun, 8 Aug 2004 18:01:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e79639220408080901266da510@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "gruetzner-Mmb7MZpHnFY@public.gmane.org" <gruetzner-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 "gruetzner [at] gmx.de" <gruetzner [at] gmx.de> wrote
> I use a FSC Lifebook E2010 and I'd like to get acpi suspend to ram working.
> The notebook seems to suspend properly but it doesn't come up anymore after
> I press the power button while in suspend(I use kernel 2.6.7). With a
> minimalistic kernel(no console-framebuffer, almost no hardware support(usb,
> sound, etc.))
this should be no hardware support, make everything as module and make
sure no module is loaded when you try
> and with suspending out of X11 I could manage it to resume one
> time. That's why I guess the video doesn't wake up proberly(radeon 340M IGP).
Does it have an agp-driver? My intel-agp never survives resume

> How can I find out, what exactly causes the hang during resume? I cannot acces
> the notebook via network - could a serial console work?
You should be able to type afterwards and to do some cpu or
hd-intensive commands and hear the activity ..
If you are at this stage you know that you can resume, and you can
proceed to some tricks to get your video back, if not you can try
again with pci=noacpi.
Perhabs do a cat /proc/interrupts to see the bad drivers.

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
