From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() invocations
Date: Mon, 15 May 2017 11:21:22 +0200
Message-ID: <CAN+gG=EDRbFBqkKTDKutv0QSrD-qgEFbKYQ0SXRrCU7aJ4cQZA@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <22b130fe0cf3fca19b0e14c69426fe36766cf2ee.1494311429.git.lv.zheng@intel.com>
 <CAN+gG=G_yh77Vab_bvWxTOVHsiUm21-X8bajo14utjaCwf1x=Q@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2BB0@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2E0E@SHSMSX101.ccr.corp.intel.com>
 <CAN+gG=GazunH_RFDUusbnT+ncNoejLuA5=v-49KDFFJ4oy8xuw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA38F0@SHSMSX101.ccr.corp.intel.com>
 <CAN+gG=E1FX7Fxur62WoEOcgcuX51HPY0BfP-7FbPf+pRMPTamw@mail.gmail.com> <87a86emryv.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33463 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdEOJVY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2017 05:21:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so14271170wrc.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 May 2017 02:21:24 -0700 (PDT)
In-Reply-To: <87a86emryv.fsf@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, May 15, 2017 at 10:42 AM, Jani Nikula
<jani.nikula@linux.intel.com> wrote:
> On Mon, 15 May 2017, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>> I'll answer everything in the other thread, where there are slightly
>> more other points raised: https://lkml.org/lkml/2017/5/15/10
>
> If you are discussing changes impacting i915, please keep intel-gfx list
> in the loop.
>

I can add intel-gfx to the other thread if you want, but this will IMO
just add more noise to your list.
The question is whether or not the kernel should provide a fake state
for the _LID acpi call, and until we reach an agreement on how to
handle things, there is no point changing the currently working code
in i915.

It is true that there is an issue in i915 regarding the fact that
intel_lid_notify() doesn't use the provided value but calls
acpi_lid_open(), but this is something that can be solved in
https://bugs.freedesktop.org/show_bug.cgi?id=100923, when the
situation clarifies.

Cheers,
Benjamin
