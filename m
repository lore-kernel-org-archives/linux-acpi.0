From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nfit: Don't check _STA on NVDIMM devices
Date: Sat, 25 Jul 2015 08:53:45 -0700
Message-ID: <CAPcyv4iLG+r5-4nTtskjsAKQU6oaoUp+J27FjA+tCu8Kaz+pVg@mail.gmail.com>
References: <20150722201721.GB7401@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38873 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbbGYPxq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Jul 2015 11:53:46 -0400
Received: by wibxm9 with SMTP id xm9so66643876wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 25 Jul 2015 08:53:45 -0700 (PDT)
In-Reply-To: <20150722201721.GB7401@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jul 22, 2015 at 1:17 PM, Linda Knippers <linda.knippers@hp.com> wrote:
>
> The _STA only applies to the root device, not the individual NVDIMMS,
> so don't check here. NVDIMM device state flags are checked elsewhere.
>
> Signed-off-by: Linda Knippers <linda.knippers@hp.com>

Applied and pushed out to 'libnvdimm-pending'
