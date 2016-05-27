From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: IS_ERR_VALUE misuses
Date: Fri, 27 May 2016 13:15:12 -0700
Message-ID: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:34131 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557AbcE0UPN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 16:15:13 -0400
Received: by mail-io0-f173.google.com with SMTP id 190so78720764iow.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2016 13:15:12 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

This is just a heads-up: for some reason the acpi layer and nvdimm use
the IS_ERR_VALUE() macro, and they use it incorrectly.

To see warnings about it, change the macro from

#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

to do a cast to a pointer and back (ie make the "(x)" part be
"(unsigned long)(void *)(x)" instead, which then will cause warnings
like

  warning: cast to pointer from integer of different size
[-Wint-to-pointer-cast]

when passed an "int" argument.

The reason "int" arguments are wrong is that the macro really is
designed to test the upper range of a pointer value. It happens to
work for signed integers too, but looking at the users, pretty much
none of them are right. The ACPI and nvdimm users are all about the
perfectly standard "zero for success, negative error code for
failure", and so using

    if (IS_ERROR_VALUE(rc))
        return rc;

is just plain garbage. The code generally should just do

    if (rc)
        return rc;

which is simpler, smaller, and generates better code.

This bug seems to have been so common in the power management code
that we even have a coccinelle script for it. But for some reason
several uses remain in acpi_debug.c and now there are cases in
drivers/nvdimm/ too.

There are random various crap cases like that elsewhere too, but acpi
and nvdimm were just more dense with this bug than most other places.

The bug isn't fatal - as mentioned, IS_ERROR_VALUE() _does_ actually
work on the range of integers that are normal errors, but it's
pointless and actively misleading, and it's not meant for that use. So
it just adds complexity and worse code generation for no actual gain.

I noticed this when I was looking at similar idiocy in fs/gfs2, where
the code in question caused warnings (for other reasons, but the main
reason was "code too complex for gcc to understand it")

               Linus
