From: =?UTF-8?B?TWFjaWVqIEtvdGxpxYRza2k=?= <makotlinski@gmail.com>
Subject: Re: regression 2.6.38-rc4 -> 2.6.38-rc5 suspend fails
Date: Fri, 18 Feb 2011 16:27:27 +0100
Message-ID: <4D5E8FDF.7040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59301 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab1BRP1n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2011 10:27:43 -0500
Received: by ewy5 with SMTP id 5so1583339ewy.19
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2011 07:27:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I had the same problem on Toshiba Tecra M5 laptop.
Reverting commit 9b29050 (tpm-tis: Use timeouts returned from TPM) 
eliminated this problem.
