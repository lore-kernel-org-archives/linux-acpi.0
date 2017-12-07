From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Backporting patches that fix TBT at bootup
Date: Fri, 8 Dec 2017 00:32:19 +0100
Message-ID: <CAJZ5v0h4kcLz2owSBkLUAu_RT-FLqBbySKKhj7y=8A5GLo0yAw@mail.gmail.com>
References: <6677505e9b3347468bf639b7b14de11a@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33322 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdLGXcU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2017 18:32:20 -0500
Received: by mail-oi0-f67.google.com with SMTP id w131so6127505oiw.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Dec 2017 15:32:20 -0800 (PST)
In-Reply-To: <6677505e9b3347468bf639b7b14de11a@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>, Mika Westerberg <mika.westerberg@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

On Fri, Dec 8, 2017 at 12:23 AM,  <Mario.Limonciello@dell.com> wrote:
> Hi,
>
> During kernel 4.14 some issues were fixed for Thunderbolt enumeration at bootup.
> They were referenced in an issue
> (https://github.com/01org/thunderbolt-software-user-space/issues/24#issuecomment-328011428)
> There are 3 patches that Mika mentioned would be evaluated to be backported back to 4.13.
>
> As 4.14 has come and gone now, I wanted to see if there was any other thoughts about
> bringing those back to stable now on 4.13 (or did they come back and I just didn't know?)
>
> ecc1165b8b74 ACPICA: Dispatch active GPEs at init time
> 1312b7e0caca ACPICA: Make it possible to enable runtime GPEs earlier
> eb7f43c4adb4 ACPI / scan: Enable GPEs before scanning the namespace

I'm not aware of anything else needed at that point.

Mika, should the three commits above be sufficient?

Thanks,
Rafael
