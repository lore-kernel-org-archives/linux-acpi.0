From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI patch flow
Date: Wed, 10 Sep 2003 15:01:06 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD58@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I've re-named the linux-acpi* tree to be linux-acpi-release*; and made
the staging area for the release tree visible -- calling it
linux-acpi-test*

So a 2 stage release is now visible on the net:

1. linux-acpi-test-*
Staging area for linux-acpi-release-*  This is where to go to try out
the latest integrated patch that is being tested in preparation for push
into the release tree.  In the past this was not visible, and so it
limited the ability of others to test the integrated patch w/o
integrating it all themselves, and led to surprises when changes came
out in the release that people may not have seen on the list.  Exporting
this will also allow me to give contributors quicker feedback when their
changes have entered the release pipeline.

2. linux-acpi-release-*
Same release trees as before, with same usage -- just added "release" to
the name.  As before, whenever we update these and release to 2.4 and
2.6 we'll also post post the plain patch to
http://sourceforge.net/projects/acpi

As before, the BK trees live here:  http://linux-acpi.bkbits.com  If
there is demand for plain patches of the _test_ tree we can probably
also export those on http://sourceforge.net/projects/acpi too, but as
the test tree will change more often, those updates would have to be
on-demand or on significant events.

Thanks,
-Len

Ps. The release tree has always been sync'd with the latest baseline for
each release; and this will still be the case.  But this makes it more
difficult for people to apply the latest patch to older trees.  So now
there is a 2.4.22 tree that is the (frozen) 2.4.22 plus only the ACPI
updates.  I'll apply 2.4 patches there and then push them forward into
the 2.4.23 tree.  We'll do the same with 2.6 when stable 2.6 baselines
emerge.
