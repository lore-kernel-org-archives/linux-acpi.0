From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Ask devices to powerdown before S3 sleep
Date: Tue, 21 Jan 2003 11:46:01 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030121104601.GB24349@atrey.karlin.mff.cuni.cz>
References: <20030119214642.GA27885@elf.ucw.cz> <Pine.LNX.4.44.0301210241290.2653-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301210241290.2653-100000-SOP5cCwKKQTHd+ljcrIm56Udfx7Bl9N1@public.gmane.org>
To: Zwane Mwaikambo <zwane-tGiaVUSOoeej7qYf8Sx8sA@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> > SUSPEND_DISABLE should be so simple that errors just should not be
> > there, and besides we would not know how to safely enable devices from
> > such weird state, anyway]. Please apply,
> 
> panic() is a bit on the extreme side no? I know diddly about ACPI and 
> the current code, but can't you check for _PS3 methods or _S3D mappings 
> for your devices before hand to be certain that the system can even go 
> down to S3 somewhat reliably?

At this point, you already DISABLED half of devices, and you don't
even know *which* ones. You can't just send them ENABLE and hope it
works.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
