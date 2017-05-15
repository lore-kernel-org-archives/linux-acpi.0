From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() invocations
Date: Mon, 15 May 2017 12:41:30 +0300
Message-ID: <877f1imp85.fsf@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com> <22b130fe0cf3fca19b0e14c69426fe36766cf2ee.1494311429.git.lv.zheng@intel.com> <CAN+gG=G_yh77Vab_bvWxTOVHsiUm21-X8bajo14utjaCwf1x=Q@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CEA2BB0@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E886CEA2E0E@SHSMSX101.ccr.corp.intel.com> <CAN+gG=GazunH_RFDUusbnT+ncNoejLuA5=v-49KDFFJ4oy8xuw@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CEA38F0@SHSMSX101.ccr.corp.intel.com> <CAN+gG=E1FX7Fxur62WoEOcgcuX51HPY0BfP-7FbPf+pRMPTamw@mail.gmail.com> <87a86emryv.fsf@intel.com> <CAN+gG=EDRbFBqkKTDKutv0QSrD-qgEFbKYQ0SXRrCU7aJ4cQZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4644 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760081AbdEOJjI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 May 2017 05:39:08 -0400
In-Reply-To: <CAN+gG=EDRbFBqkKTDKutv0QSrD-qgEFbKYQ0SXRrCU7aJ4cQZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 15 May 2017, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
> On Mon, May 15, 2017 at 10:42 AM, Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
>> On Mon, 15 May 2017, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>>> I'll answer everything in the other thread, where there are slightly
>>> more other points raised: https://lkml.org/lkml/2017/5/15/10
>>
>> If you are discussing changes impacting i915, please keep intel-gfx list
>> in the loop.
>>
>
> I can add intel-gfx to the other thread if you want, but this will IMO
> just add more noise to your list.
> The question is whether or not the kernel should provide a fake state
> for the _LID acpi call, and until we reach an agreement on how to
> handle things, there is no point changing the currently working code
> in i915.

Fair enough.

> It is true that there is an issue in i915 regarding the fact that
> intel_lid_notify() doesn't use the provided value but calls
> acpi_lid_open(), but this is something that can be solved in
> https://bugs.freedesktop.org/show_bug.cgi?id=100923, when the
> situation clarifies.

The snarky reply here might be that we're just following the
documentation of acpi_lid_notifier_register(), acpi_lid_open(), and
friends. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
