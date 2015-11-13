From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] Fix nfit_test compilation error
Date: Fri, 13 Nov 2015 08:41:01 -0800
Message-ID: <CAPcyv4h9yoJRBxHUs+y0F+onXKGBS03DXOWWi0EdW4XvWqVE0w@mail.gmail.com>
References: <CAJN_NGZMaOUwdrWKRLZw9dLFwDihczCgP=Qey8_1BJuVfS0Org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37202 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933032AbbKMQlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2015 11:41:03 -0500
Received: by wmww144 with SMTP id w144so38401616wmw.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2015 08:41:02 -0800 (PST)
In-Reply-To: <CAJN_NGZMaOUwdrWKRLZw9dLFwDihczCgP=Qey8_1BJuVfS0Org@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Krivenok <krivenok.dmitry@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>

On Fri, Nov 13, 2015 at 5:51 AM, Dmitry Krivenok
<krivenok.dmitry@gmail.com> wrote:
> nfit_test wasn't changed in commit ca321d1c where "ARMED" was
> renamed to "NOT_ARMED". Adding one more change to fix the build.
>
> Signed-off-by: Dmitry V. Krivenok <krivenok.dmitry@gmail.com>

Thanks, I have this queued up in a branch heading upstream shortly.
