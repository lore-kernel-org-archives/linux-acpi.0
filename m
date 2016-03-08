From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed insert/remove_resource()
Date: Tue, 8 Mar 2016 12:05:22 -0800
Message-ID: <CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36416 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcCHUFX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 15:05:23 -0500
In-Reply-To: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 10:08 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
>
> Add device-managed implementaions of insert_resource() and
> remove_resouce() functions.

Can we get an example of the users and show how much this would actually help?

insert_resource() is fairly unusual to begin with, and it should
basically *never* be used by a driver at all (it's more of a bus
thing).

The patch doesn't look _wrong_, but it does look potentially largely
pointless. Adding new interfaces to do things that aren't common
enough to worry about is counter-productive, imho.

                 Linus
