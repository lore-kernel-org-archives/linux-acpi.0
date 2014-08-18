From: "xavier.gnata@gmail.com" <xavier.gnata@gmail.com>
Subject: Re: bug : Dell Inspiron 15 7000 : battery detection only after AC
 power adapter event.
Date: Mon, 18 Aug 2014 23:22:51 +0200
Message-ID: <53F26EAB.8050503@gmail.com>
References: <53F1E109.1030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:42848 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaHRVWy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2014 17:22:54 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so5595225wes.20
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2014 14:22:52 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8a7f:290:9dfa:6230:a05a:2ec1? ([2a01:e35:8a7f:290:9dfa:6230:a05a:2ec1])
        by mx.google.com with ESMTPSA id a4sm41563739wie.21.2014.08.18.14.22.51
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2014 14:22:52 -0700 (PDT)
In-Reply-To: <53F1E109.1030801@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 18/08/2014 13:18, xavier.gnata@gmail.com wrote:
> Hi,
>
> When I boot a Dell 15" serie 7000 with or without it AC power adapter 
> no battery is detected:
> acpi -i -b -a
> Adapter 0: off-line
>
> As soon as I plug or unplug the AC adapter, the battery is detected:
> acpi -i -b -a
> Battery 0: Charging, 62%, 01:13:00 until charged
> Battery 0: design capacity 3950 mAh, last full capacity 3850 mAh = 97%
> Adapter 0: on-line
>
> Attached : dmesg and dsdt.dsl. What else do you need?
> Looks like a buggy dsdt table but I'm not an expert.
>
> The bug is the same on 3.17-rc1, 3.16.1 and 3.13.
>
> Xavier

As a workaround one can boot with  acpi_osi=Linux . I don't see any side 
effects.

Xavier
