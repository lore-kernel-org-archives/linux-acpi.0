From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Wed, 16 Jul 2003 13:36:10 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE94@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>, hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org] 

> Concerning code size, the 70K number in ACPI's Kconfig help is
> out of date. A minimal ACPI (all user-selectable suboptions
> disabled) adds 145K to my 2.6.0-test1 kernel.

Are you talking to the compressed or uncompressed kernel? Maybe we got
it backwards, but the 70K number was the bzImage size difference.
(Actually I just tried it again. We're 80K now. I blame gcc. ;-))

(And of course, since the kernel (incl. ACPI) dynamically allocates
memory, even the uncompressed kernel image doesn't account for the
kernel's true memory footprint...)

Regards -- Andy
