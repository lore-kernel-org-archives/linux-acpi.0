From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI update (20030122)
Date: Thu, 23 Jan 2003 16:09:07 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137FB5@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Dave Jones [mailto:davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org] 
> I've noticed that with .59 some of my boxes no longer have
> functioning NICs unless I boot with acpi=off. Packets get
> transmitted, but nothing ever gets received.
> Seen this with a 3c509, an 8139, and an e100.
> 
> Known bug? Fixed in this patch ?

Known bug. Not fixed in this patch. Are you sure this is new in recent
kernels?

Regards -- Andy
