From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] acpismp=force fix
Date: Mon, 23 Jun 2003 00:43:38 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A302@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Andrew Morton [mailto:akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org] 
> >    ACPI: make it so acpismp=force works (reported by Andrew Morton)

> But prior to 2.5.72, CPU enumeration worked fine without 
> acpismp=force. 
> Now it is required.  How come?

(I'm taking the liberty to update the subject, which I accidentally left
blank)

Because 2.4 has that behavior. One objection that people raised to
applying the 2.4 ACPI patch was that it changed that behavior. So I made
an effort to keep it there.

I think out of sheer inertia I also re-added it to the 2.5 tree.
Probably shouldn't have.

Does anyone have a reason why acpismp=force should be in 2.5/6? If not
I'll go ahead and zap it (again), and everyone should just be aware that
this is another way that 2.4 and 2.5 differ.

Regards -- Andy
