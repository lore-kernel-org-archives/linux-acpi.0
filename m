From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fixes to suspend-to-RAM
Date: Tue, 18 Feb 2003 16:00:27 -0600 (CST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302181556480.1035-100000@localhost.localdomain>
References: <20030218220740.GD21974@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030218220740.GD21974-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> Bootmem needs to be reserved pretty soon in the boot process, that
> might be a problem.

That's not the issue. The call to the arch code would only check if the 
bootmem had been reserved, and as far the arch code knew, it was OK to 
enable S3. 


> Based on recent talk... Will you act as S3 maintainer so that I can
> submit patches to you and you'll take care of forwarding to Linus?

Yes, but please don't flood me with patches yet. I'm getting reacquainted 
with some of the more esoteric details of suspend states, and verifying 
that we have a working PM model for 2.6.

	-pat
