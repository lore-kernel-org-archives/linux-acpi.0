From: =?UTF-8?B?5ZC05ZCN?= <wkq5325@gmail.com>
Subject: Xeon(R) CPU X3220 wrong frequency reading??
Date: Wed, 9 Feb 2011 21:42:39 +0800
Message-ID: <AANLkTi=108MYQiLTTf3ncVBr9vWttq_Qj4q4yLckamYG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47967 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab1BINmk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Feb 2011 08:42:40 -0500
Received: by fxm20 with SMTP id 20so198164fxm.19
        for <linux-acpi@vger.kernel.org>; Wed, 09 Feb 2011 05:42:39 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
 My CPU is Xeon(R) X3220  2.4Ghz, but linux userspace governor gives 900Mhz.
The strange problem is that sometimes userspace governor gives correct
reading(after a new boot).
Is it the processor frequency scaling problem or linux problem?
(someone said it is hardware scaling mechanism) .
But I think it is linux problem. right?

Thanks.

wkq
