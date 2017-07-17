From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] acpi/nfit: Fix memory corruption/Unregister mce
 decoder on failure
Date: Mon, 17 Jul 2017 09:52:44 -0700
Message-ID: <CAPcyv4hBNfHw6M39x=cE_j93iEFL_jyyW7naQuh=6kOfhmgWvw@mail.gmail.com>
References: <1496252383-6234-1-git-send-email-prarit@redhat.com>
 <20170531194651.GA30167@omniknight.lm.intel.com> <a0c81e37-74e3-aec1-af93-538750d38c47@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34462 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdGQQwp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2017 12:52:45 -0400
Received: by mail-yw0-f171.google.com with SMTP id l21so49861427ywb.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2017 09:52:45 -0700 (PDT)
In-Reply-To: <a0c81e37-74e3-aec1-af93-538750d38c47@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Linda Knippers <linda.knippers@hpe.com>, jmoyer <jmoyer@redhat.com>, lszubowi@redhat.com

On Mon, Jul 17, 2017 at 8:19 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>
> Rafael?
>
> ping?  It's been almost two months ...

This is my fault. I'll pick this up for 4.13-rc2.
