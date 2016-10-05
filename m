From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI material for v4.9-rc1
Date: Wed, 5 Oct 2016 10:29:40 -0700
Message-ID: <CA+55aFwFVZVkApwrei5A68kfc5+D32x5JKkvnuqiJS731Nv=Ew@mail.gmail.com>
References: <CAJZ5v0ij+mUnjJZ3RR37yUFgc+RPndwPNhTGa3RF4PNFQ+RH8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34619 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbcJER3l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2016 13:29:41 -0400
In-Reply-To: <CAJZ5v0ij+mUnjJZ3RR37yUFgc+RPndwPNhTGa3RF4PNFQ+RH8Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On Sun, Oct 2, 2016 at 3:56 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> This goes early as I will be traveling for a good part of the next week.

So you're presumably traveling, but I thought I'd mention this anyway,
since it seems to be new (but maybe I just never noticed before)..

I now get this during early bootup:

   ACPI Error: [\_SB_.PCI0.XHC_.RHUB.HS11] Namespace lookup failure,
AE_NOT_FOUND (20160831/dswload-210)
   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog
(20160831/psobject-227)
   ACPI Exception: AE_NOT_FOUND, (SSDT:xh_rvp08) while loading table
(20160831/tbxfload-228)
   ACPI Error: 1 table load failures, 8 successful (20160831/tbxfload-246)

and it has no actual other negative effects except that it makes my
boot screen flicker (because the boot wants to show me errors in
between the usual graphical "clean" boot screen).

Are those failures so bad that they should be marked as errors?

                Linus
