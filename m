From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] resource: Add @flags to region_intersects()
Date: Tue, 1 Dec 2015 09:19:05 -0800
Message-ID: <CA+55aFw22JD8W2cy3w=5VcU9-ENXSP9utmhGB2NeiDVqwpnUSw@mail.gmail.com>
References: <1448404418-28800-1-git-send-email-toshi.kani@hpe.com>
	<1448404418-28800-2-git-send-email-toshi.kani@hpe.com>
	<20151201135000.GB4341@pd.tnic>
	<CAPcyv4g2n9yTWye2aVvKMP0X7mrm_NLKmGd5WBO2SesTj77gbg@mail.gmail.com>
	<20151201171322.GD4341@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36123 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbbLARTG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 12:19:06 -0500
In-Reply-To: <20151201171322.GD4341@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, Linux MM <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Dec 1, 2015 at 9:13 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Oh sure, I didn't mean you. I was simply questioning that whole
> identify-resource-by-its-name approach. And that came with:
>
> 67cf13ceed89 ("x86: optimize resource lookups for ioremap")
>
> I just think it is silly and that we should be identifying resource
> things in a more robust way.

I could easily imagine just adding a IORESOURCE_RAM flag (or SYSMEM or
whatever). That sounds sane. I agree that comparing the string is
ugly.

> Btw, the ->name thing in struct resource has been there since a *long*
> time

It's pretty much always been there.  It is indeed meant for things
like /proc/iomem etc, and as a debug aid when printing conflicts,
yadda yadda. Just showing the numbers is usually useless for figuring
out exactly *what* something conflicts with.

               Linus
