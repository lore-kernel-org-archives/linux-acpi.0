From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Re: 2.6.0-test2: Lost USB mouse after resuming from S3
Date: Thu, 7 Aug 2003 20:51:00 +0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200308072051.00679.mflt1@micrologica.com.hk>
References: <200308070037.31630.mflt1@micrologica.com.hk> <20030806213941.GA7618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030806213941.GA7618-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 07 August 2003 05:39, Greg KH wrote:
> On Thu, Aug 07, 2003 at 12:37:31AM +0800, Michael Frank wrote:
> > Causes are that usb-host controller does no handle S3 yet _plus_
> > possibly (depending on your hardware) loss of PCI interrupt links as
> > current ACPI does not resume those.
>
> Known issue, please unload the usb modules before suspending them.
>
> The upcoming suspend patches will allow us to fix this "properly",
> please give us a few weeks :)
>

And mind the _plus_ issue - On my hardware you could debug dead interrupts 
in the host controller code forever...

Have posted a patch to fix ACPI, but no feedback as of yet ;)

Regards
Michael

-- 
Powered by linux-2.6-test2-mm4. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/
