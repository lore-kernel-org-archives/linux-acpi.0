From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] 2.5.58 hangs at boot
Date: Thu, 16 Jan 2003 13:38:52 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Michael Dreher <dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Michael Dreher [mailto:dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org] 
> 2.5.58 hangs during booting, at this place:
> 
> ......
> BIO: pool of 256 setup, 15Kb (60 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> ACPI: Subsystem revision 20030109
> 
> 2.5.56 was working OK, except the usual usb problems.

Hi Michael,

Can you stick a printk in ev_sci_handler and see if that's being called
repeatedly?

If not, then could you please narrow down where after the version
printout things are getting hung up?

Thanks -- Regards -- Andy
