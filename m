From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: the role of the dstd
Date: Thu, 24 Aug 2006 21:13:29 +0100
Message-ID: <E1GGLZx-00037U-00@skye.ra.phy.cam.ac.uk>
References: <44EDFDD9.5030504@student.kuleuven.be>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:13505 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1422631AbWHXUNb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 16:13:31 -0400
In-Reply-To: Your message of "Thu, 24 Aug 2006 21:28:25 +0200."
             <44EDFDD9.5030504@student.kuleuven.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joeri Hendrickx <joeri.hendrickx@student.kuleuven.be>
Cc: linux-acpi@vger.kernel.org

> For one, if the DSTD is part of the BIOS, how come windows does
> work, while it must rely on the same data

I'm not an ACPI expert but here is my understanding.  Hopefully it's
close enough to reality that the experts need to make only minor
corrections and can keep hacking.

Often, or rather always, the manufacturer tests the DSDT only with
Windows.  If Windows makes assumptions about how the DSDT code should
be interpreted that are different from what Linux assumes, even if
Linux's assumptions are compatible with the ACPI spec, then the DSDT
might fail when run with Linux.

For example, Windows serializes (runs in one thread) procedures
automatically, even if a procedure is labelled NotSerialized.  But
Linux ACPI, unless you pass a boot option to tell it to act like
Windows, will not serialize those procedures, and each one can run in
its own thread.

Therefore, race conditions from a sloppy DSDT, which might be hidden
in Windows, are often exposed in Linux.  And so S3 suspend might hang
because of one of those races or locking problems.  My old Thinkpad
600X improved its S3 suspend behavior somewhat when booting with the
"Act like Windows" option.

ACPI development on Linux is often: "My laptop doesn't suspend in
Linux" (for a modern laptop it's almost certain that it suspends in
Windows) and then people finding what bug needs to be introduced into
the Linux DSDT interpreter so that Linux can act just like Windows.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
