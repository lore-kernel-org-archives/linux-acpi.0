From: Warren Turkal <wturkal-Ly1yJZSIA8M@public.gmane.org>
Subject: [BUG] linux laptop keyboard problem since 2.5.74
Date: Sat, 19 Jul 2003 01:22:57 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200307182149.58889.wturkal@cbu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry for the crosspost, but I didn't get a response originally from the 
acpi-devel list. Also, I am not subscribed to either list. Please CC me on 
replies that should go to me.

Something got merged between 2.5.73 and 74 that has messed with my system ever 
since. Some of the keys that are activated with Fn combinations are messed up.

Some of these combinations involve turning on external monitor output and 
showing battery status.

I suspect ACPI as that was the culprit last time when I could not use the Fn 
combinations at all. I compiled my kernel with acpi as modules and the 
problems happens even when not loading the modules for acpi. I also tried 
booting with acpi=off and that did not seem to change anything.

Like I said, 2.5.73 was fine and didn't lock like 2.5.74 to 2.6.0-test1 do. So 
the bug was somewhere in that revision.

I have a Gateway 600 series laptop with 256mb ram and 1.9Ghz P4. Does anyone 
know where I should start investigating for more info.

Thanks, Warren Turkal
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org
