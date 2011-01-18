From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 09:14:43 +0800
Message-ID: <AANLkTi=nGmW=3XGRzxJ1avbz-PcE_QSdVBddOM1yMiBh@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101172349.06993.rjw@sisk.pl>
	<201101180114.42664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33201 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1ARBOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 20:14:44 -0500
Received: by iwn9 with SMTP id 9so5243870iwn.19
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jan 2011 17:14:43 -0800 (PST)
In-Reply-To: <201101180114.42664.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>
Cc: linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jan 18, 2011 at 2:55 AM, Brown, Len <len.brown@intel.com> wrote=
:
> added Linux-acpi to cc
>
> any difference if you boot with acpi_sleep=3Dnonvs ?

That works.

On Tue, Jan 18, 2011 at 8:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> What happens if you replace the acpi_os_map_memory() in
>> suspend_nvs_save() with ioremap_cache() and the acpi_os_unmap_memory=
() in
>> suspend_nvs_free() with iounmap() ?
>
> IOW, can you please test if the patch below makes a difference?
> =A0drivers/acpi/nvs.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)

That works too.

Now I have another problem which might be totally unrelated. Just
realized that my notebook can't suspend to "disk" ... used to work
last week. So, something has changed as well. May be someone has
already reported/fixed this.


Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
