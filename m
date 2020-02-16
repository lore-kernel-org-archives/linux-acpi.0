Return-Path: <SRS0=VaGJ=4E=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6534C76199
	for <linux-acpi@archiver.kernel.org>; Sun, 16 Feb 2020 09:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1122522
	for <linux-acpi@archiver.kernel.org>; Sun, 16 Feb 2020 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581844941;
	bh=AShLB9lpSyhhHZDJUHq89eCP18SVDcNGHkXSqQLyNrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XKGG//q4uUXqDC+rr6D+zAmtnVRrGO9110vU7q0R9xWgllvbNKztoI9VFTTe426pM
	 /SHnbL7BzCOPpdXePH5UL6i1N6fNqfm4czPhmsuJQ1XOvrsxmaSRJ4FR1WmPy6KCAo
	 nhfooNNWGrPQYIL8TIUtYiZf1/msilQsjpaUqid4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgBPJWU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 16 Feb 2020 04:22:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40124 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgBPJWU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Feb 2020 04:22:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so13897791oii.7
        for <linux-acpi@vger.kernel.org>; Sun, 16 Feb 2020 01:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MzBipauxMFBl4WoUzUOWicnk3dMZV0Pt2YH95IdQKI=;
        b=Fuuefm+33MhLX0Iiyn8hs7cdzhXIWAsURLZEsP1ddO/7wYNAKXXhdP8wEpgXD+6OHG
         J969VM7/wEe+X8R0SV1Z08utIiL3TPgp6sLK/die3ZdlnrtA9NwsPxHwVGt07t8Qldgk
         UzQP0qclzTpXkfQ7jyq05tI7z83F4fQ5xDJVRWqK+/kTUYAOp7tXJbjk5vARkWj3rzvW
         LzU/uUVbBr7dVBSTwVkuFpjeRc+vIIFdE96wZC8DUwZIv8twpcP1HeW0ftnxL7qWsf5J
         BRqr9Ge3VaQGW2b1i0ipm8xbWUfo84GcsJDhLsn2MCwq9CKIDwnKvRDNP+Q0j+h9brKT
         wnBA==
X-Gm-Message-State: APjAAAUGj8C/7yCxVTfEPqtX5dNUF2K8xwYOI6nd+etdiEMsI//7nPPP
        9hMJbDNbpUpt+qgbG1+VBygY85mw4SVBkuVD0OHSZA==
X-Google-Smtp-Source: APXvYqz0Jhv40xV8PmPRjX9wYiM76arv9CiWmckYQKPlWVq3YQaKTInsqIhaIW1DEJ+LHOyuyj8K4mqRmsBwZl5Dbg0=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr7080781oif.57.1581844940025;
 Sun, 16 Feb 2020 01:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20200214184804.15114-1-erik.kaneda@intel.com>
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 16 Feb 2020 10:22:08 +0100
Message-ID: <CAJZ5v0hNnBgrJMrxOLqr7v3bdnmQy--qYj+A3XShydhqG8fiYA@mail.gmail.com>
Subject: Re: [PATCH 00/10] ACPICA release 20200214
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 14, 2020 at 8:08 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This patch series contains the 20200214 release of ACPICA. For linux,
> this a relatively small release. Major changes include Enabling the
> sleep button on ACPI legacy wake. Aside from that, this release mainly
> consists of changes in the converter, type casts to suppress compiler
> warnings when building in 64 bit mode on msvc 2019, and updates to
> comments.
>
> This patch set is also available for viewing at the following link:
>
>
>
> Anchal Agarwal (1):
>   ACPICA: Enable sleep button on ACPI legacy wake
>
> Bob Moore (4):
>   ACPICA: Fix a comment "enable" fixed events -> "disable" all fixed
>     events.
>   ACPICA: Table Manager: Update comments in a function header
>   ACPICA: Fix a couple of typos
>   ACPICA: Update version to 20200214 Version 20200214.
>
> Erik Kaneda (2):
>   ACPICA: ASL-ASL+ converter: remove function parameters from
>     cv_init_file_tree ()
>   ACPICA: ASL-ASL+ converter: make root file a parameter for
>     cv_init_file_tree
>
> Sven Barth (3):
>   ACPICA: cast the result of the pointer difference to u32
>   ACPICA: cast length arguement to acpi_ns_build_normalized_path() as
>     u32
>   ACPICA: use acpi_size instead of u32 for prefix_path_length

The whole series has been queued up as 5.7 material, thanks!
