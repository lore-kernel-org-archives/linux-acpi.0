From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Mon, 31 Jan 2011 10:53:22 +0200
Message-ID: <4D467882.9060304@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D445319.5020803@pardus.org.tr> <4D45CA6F.8000002@pardus.org.tr> <201101302348.40509.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:55790 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab1AaIxW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 03:53:22 -0500
In-Reply-To: <201101302348.40509.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On 31.01.2011 00:48, Rafael J. Wysocki wrote:

> Does booting with "nolapic" help on all of the affected systems?
>
> Also, does disabling the CPUidle during boot help?
>
> Finally, is the problem reproducible with CONFIG_NO_HZ unset?

Well on two machines, nolapic cures the boot hang and on one machine it 
cures the random shutdown hangs.

I'll compile a kernel with CONFIG_NO_HZ to see what happens but how do I 
disable cpuidle during boot? I've checked the kernel-parameters.txt but 
there's no cpuidle related boot parameter there.

Thanks


-- 
Pardus Linux
http://www.pardus.org.tr/eng
