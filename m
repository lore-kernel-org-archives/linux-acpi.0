From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Status
Date: Fri, 13 Sep 2002 10:22:21 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE5D@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Marc Giger' <gigerstyle-OI3hZJvNYWs@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Marc Giger [mailto:gigerstyle-OI3hZJvNYWs@public.gmane.org] 
> What is the current status of acpi in 2.4 / 2.5 kernels???
> 
> The most things on http://acpi.sourceforge.net/ are outdated:-((
> To acpi developers: Is it possible to make a Changelog like 
> Linus, Alan and Marcello and Co does??
> And it would be nice, if there were a document which 
> describes the current development status..(what is already 
> implemented and what not)

Oops, web content a little stale...

Try checking out the sf.net acpi project page - sf.net/projects/acpi. You
can d/l releases there and each release has a changelog.

As to development status:

Everything is code complete (more or less) EXCEPT:

- S3/S4 support
- userspace library
- using ACPI for device PnP and resource determination

If you're interested with following ACPI progress, I'd recommend subscribing
to the acpi-devel mailing list.

Regards -- Andy
