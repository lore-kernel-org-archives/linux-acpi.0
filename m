From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Date: Sun, 2 Nov 2003 03:16:44 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0310251706470.15711-iK9260SApOA@public.gmane.org>
To: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 01, 2003 at 04:35:11PM -0800, Noah J. Misch wrote:
> Greetings,
> 
> I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and
> drivers/acpi/Kconfig to be a bit redundant and hard to follow.  It appears to do
> the following:

I posted a similar patch here:

http://marc.theaimsgroup.com/?l=linux-ia64&m=106555019402117&w=2

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
