From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Wed, 16 Jul 2003 22:55:26 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200307162055.h6GKtQl9027858@harpo.it.uu.se>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 16 Jul 2003 13:36:10 -0700, "Grover, Andrew" wrote:
> > From: Mikael Pettersson [mailto:mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org] 
> 
> > Concerning code size, the 70K number in ACPI's Kconfig help is
> > out of date. A minimal ACPI (all user-selectable suboptions
> > disabled) adds 145K to my 2.6.0-test1 kernel.
> 
> Are you talking to the compressed or uncompressed kernel? Maybe we got
> it backwards, but the 70K number was the bzImage size difference.
> (Actually I just tried it again. We're 80K now. I blame gcc. ;-))

Uncompressed: size vmlinux. gcc-3.2.2.
