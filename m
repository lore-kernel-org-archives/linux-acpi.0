From: Vincas Dargis <vindrg@gmail.com>
Subject: Re: Brightness keys on Asus X200MA don't work.
Date: Thu, 22 Dec 2016 19:00:35 +0200
Message-ID: <fea22453-7bd0-f3d7-7f0c-b2c1af3a8d3e@gmail.com>
References: <CAPi-ftoYwmPK+i-JpQYdwC6t_ua_t3Py-O7RkZp9jqUEi1Ot7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35743 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756928AbcLVRAk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2016 12:00:40 -0500
Received: by mail-lf0-f53.google.com with SMTP id b14so122700599lfg.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2016 09:00:39 -0800 (PST)
Received: from [192.168.0.10] (ip-77-221-87-116.kava.lt. [77.221.87.116])
        by smtp.gmail.com with ESMTPSA id f25sm7143599lji.47.2016.12.22.09.00.36
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2016 09:00:37 -0800 (PST)
In-Reply-To: <CAPi-ftoYwmPK+i-JpQYdwC6t_ua_t3Py-O7RkZp9jqUEi1Ot7g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

2016.12.22 03:15, Matthew Brooks wrote:
> Fn + F5 or F6 is supposed to lower or raise the brightness respectively.
> By default, nothing happens when pushing the buttons.

Similar for me. I had reported bug against Asus N551JM in linux-acpi [1][2] and
Launchad [3]. You could click "This bugs affect you" in Launchpad if you feel
like it.

> The "video.use_bios_initial_backlight=0", "acpi_osi=", and
> "acpi_backlight=vendor" kernel options where all tried, and none of
> them fixed the problem.

Strange, acpi_osi= does help in my case.

[1] https://marc.info/?l=linux-acpi&m=147292726831189&w=2
[2] https://marc.info/?l=linux-acpi&m=147550958501931&w=2
[3] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1608526

