From: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Subject: Where do I send APIC victims?
Date: Wed, 3 Sep 2003 10:08:52 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030903080852.GA27649@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

As the maintainer of via-rhine, I get bug reports that almost in their
entirety are "fixed" by turning off APIC and/or ACPI. This has been going
on for several months now. Every now and then, something promising gets
posted on LKML, but so far if anything I've seen an _increase_ in those bug
reports. Maybe a fix is floating around and this will be a non-issue RSN. I
simply can't tell, since I don't have any IO-APIC hardware to play with.

Instead of just telling everybody to turn off APIC, I'd like to point bug
reporters to the proper place and tell them what information they should
provide so it can get fixed for real. According to MAINTAINERS, Ingo Molnar
does Intel APIC, but the problems are with VIA chip sets. So where do I
send my users? Any takers?

Roger
