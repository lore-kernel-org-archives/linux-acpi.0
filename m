From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 14:31:22 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F99@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Andrew Walrond <andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Andrew Walrond [mailto:andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org] 
> Results from a an Asus PR-DLS Dual Xeon HT
> 
> Don't know if this is useful, but I'll try anything that might bring 
> back my e1000 ;) No joy though - doesn't find all the PCI 
> buses (14 and 
> 18 missing - see below)

Well, this patch shouldn't actually *improve* anything yet w.r.t. ACPI.
I just wanted to see if it made anything worse, before proceeding
further.

Looks like your machine didn't fail to boot, so great. :)

Regards -- Andy
