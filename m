From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BUG] linux laptop keyboard problem since 2.5.74
Date: Fri, 25 Jul 2003 13:33:37 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEA8@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Warren Turkal <wturkal-Ly1yJZSIA8M@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Warren Turkal [mailto:wturkal-Ly1yJZSIA8M@public.gmane.org] 
> Something got merged between 2.5.73 and 74 that has messed 
> with my system ever 
> since. Some of the keys that are activated with Fn 
> combinations are messed up.
> 
> Some of these combinations involve turning on external 
> monitor output and 
> showing battery status.
> 
> I suspect ACPI as that was the culprit last time when I could 
> not use the Fn 
> combinations at all. I compiled my kernel with acpi as 
> modules and the 
> problems happens even when not loading the modules for acpi. 
> I also tried 
> booting with acpi=off and that did not seem to change anything.
> 
> Like I said, 2.5.73 was fine and didn't lock like 2.5.74 to 
> 2.6.0-test1 do. So 
> the bug was somewhere in that revision.
> 
> I have a Gateway 600 series laptop with 256mb ram and 1.9Ghz 
> P4. Does anyone 
> know where I should start investigating for more info.

I don't think it's ACPI to blame. The ACPI-related changesets applied
between 2.5.73 and 2.5.74 don't look like the culprit. Also, since it
continues to happen when acpi=off that also points away from ACPI.

I have other reports of things breaking in the same timeframe so I think
it's fair to say that something has regressed...somewhere.

Regards -- Andy
