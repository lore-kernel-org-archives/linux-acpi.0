From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Date: Tue, 10 Dec 2002 21:40:31 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com> <1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1039481341.12046.21.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I concur with your pros and cons. This makes me think that if S4BIOS support
> > ever gets added, it should get added to 2.4 only.

And S4BIOS will never get added to 2.4 since it needs driver model
:-(.

> That assumes no box exists where S4bios works an S4 doesnt (eg due to
> bad tables or "knowing" what other-os does)

We have full control over S4 (== swsusp), so we can fix that in most
cases.

S4BIOS is still little friendlier to the user -- no need to set up
swap partition and command line parameter, can't go wrong if you boot
without resume=, etc.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
