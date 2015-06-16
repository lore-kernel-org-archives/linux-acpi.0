From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH 00/12] ACPI: constify patches and other minor fixes
Date: Tue, 16 Jun 2015 07:20:32 +0200
Message-ID: <CA+rthh_P_7jSyThmkFX-mEcQ4_62pugB5MO2fZaD7E4V5RcPyg@mail.gmail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
	<1575178.P3pyudAmuh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35785 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbbFPFUe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2015 01:20:34 -0400
Received: by wiga1 with SMTP id a1so97601379wig.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2015 22:20:33 -0700 (PDT)
In-Reply-To: <1575178.P3pyudAmuh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On 16 June 2015 at 00:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, June 13, 2015 02:26:48 PM Mathias Krause wrote:
>> this series constifies a few variables in the ACPI code that are read
>> only and therefore can be const. The main goal is to constify all users
>> of struct acpi_device_id, but while digging through the code I found a
>> few other places that could be improved too (constifying other variables
>> in patches 1, 2, 4 and 9 as adding __init annotations where sensible in
>> patch 7 or dropping bogus annotations in patch 3).
>
> I've queued up the series for 4.2 except for patches [3/12] and [4/12].
>
> My recollection of the __refdata in the processor driver is that it was needed
> for some obscure reason, so that one requires some more thorough code inspection

I guess it was needed for the __cpuinit annotation (see e.g.
v3.11-rc1:drivers/acpi/acpi_processor.c). But that one was dropped
during the development of v3.11 in commit fe7bf106ebc2 "acpi: delete
__cpuinit usage from all acpi files", obsoleting the need for the
__refdata annotation.

Should I update the patch description and resend a v2?

> and the [4/12] gets in the way of something (I'll apply it later when I'm done
> with that other thing).

Okay, thanks.


Mathias
