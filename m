From: Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
Date: Tue, 9 Sep 2003 20:38:19 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309092038.19059.adq@lidskialf.net>
References: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com.suse.lists.linux.kernel> <p734qzlkcn3.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <p734qzlkcn3.fsf-G4cFiJVhTpkYitT5tn2FcQ@public.gmane.org>
Content-Disposition: inline
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 09 September 2003 20:03, Andi Kleen wrote:
> David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org> writes:
> > at acpi_pci_link_calc_penalties
>
> Try this (untested) patch
>
> (2.6 version untested, I tested a similar patch on the 2.4 backport of
> ACPI):
>

Hi, you beat me to it. Just tested your patch on my patched linux-2.6.0-test4. 
Works ok for me.
