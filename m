From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Wed, 1 Apr 2015 10:01:45 -0700
Message-ID: <CAL85gmDE5qD2tTABuz-6ccoVtnN4zN1Vbyyz+nQbdhT74UH37A@mail.gmail.com>
References: <1427836680-13008-1-git-send-email-fkan@apm.com>
	<20150401074553.GV1524@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:37841 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751433AbbDARBr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2015 13:01:47 -0400
Received: by obvd1 with SMTP id d1so89341534obv.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 Apr 2015 10:01:45 -0700 (PDT)
In-Reply-To: <20150401074553.GV1524@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 1, 2015 at 12:45 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
>> This will add support for ACPI parsing of the mboxes attribute
>> when booting with ACPI table. The client will have a attribute
>> mimic the dts call "mboxes". In the ACPI case, the client will
>> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
>>
>>       Name (_DSD, Package () {
>>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>               Package () {
>>                       Package (2) {"mboxes", "ACPIHID"},
>>               }
>>       })
>
> Instead of this, why not match against the DT compatible property?
>
>         Name (_HID, "PRP0001")
>
>         Name (_DSD, Package () {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                         Package (2) {"compatible", "your-dt-compatible-string"},
>                 }
>         })
I think my description was not clear enough. The _DSD section is not
meant to identify the mailbox driver, but used by the acpi node that will
request the mailbox channel. The dts version would be as below.

   mailbox: {
   }

   user-mbox: {
      mboxes: <&mailbox 0>
   }

The mboxes attribute in the user of the mbox has to specify the HID of the
mbox in order to retrieve channel pointer.

>
> This all will be done for you automatically with zero changes in the
> code.
