From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Mon, 3 Feb 2003 17:25:38 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Ducrot Bruno [mailto:poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
> This patch is for s4bios support in 2.5.59 with acpi-20030123.
> 
> This is the 'minimal' requirement.  Some devices (especially the
> IDE part) are not well resumed.  Handle with care..
> 
> Note also that the resuming part (I mean IDE) was more stable
> with an equivalent patch when I tested with 2.5.54 (grumble 
> grumble)...
> 
> I think also that it is a 'good' checker for devices power management
> in general...

I'd really rather just have S4OS (aka swsusp) in 2.5 patches -- if the
OS can do S4 on its own, that is really preferable to S4bios.

Regards -- Andy
