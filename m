From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 10:36:46 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A12B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Martin J. Bligh [mailto:mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org] 

> Would be a lot easier to read if you could seperate out the
> renames from the rest of the patch that actually does things.
> It all makes me slightly nervous as this stuff is really easy
> to break ... and it breaks wierd machines that are hard to test
> for (been there, done that ;-)).

Exactly why I wanted to clean up the code - too fragile! :)

Anyways, I will take a stab at redoing the changesets the way you
describe.

> +static u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = 
> BAD_APICID };
> 
> Looks odd. May have merged forward badly, that got renamed in 2.5.59
> to bios_cpu_apicid or something. 

You are right. I'll fix that.

> Anyway, I'll give it a spin on my wierdo box, and see what happens.

Cool, thanks.

Regards -- Andy
