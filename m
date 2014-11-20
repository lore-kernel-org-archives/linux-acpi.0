From: Ahmed Tamrawi <ahmedtamrawi@gmail.com>
Subject: Possible memory leak in function (acpi_video_init_brightness) not
 freeing (br->levels)
Date: Wed, 19 Nov 2014 20:13:13 -0600
Message-ID: <CAFZT-jL=2mDEQ-T69xUMGmb-MnPJAEAQbXjb8fNd=x04As7Esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:56307 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbaKTCNO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Nov 2014 21:13:14 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so1892143ier.28
        for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2014 18:13:13 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Bug Report Filed: https://bugzilla.kernel.org/show_bug.cgi?id=88531
Linux Version [3.17-rc1]
Configuration: Default configuration for x86

Reference to source code:
http://lxr.free-electrons.com/source/drivers/acpi/video.c#L1033

In function (acpi_video_init_brightness) in file (drivers/acpi/video.c):

The function allocates (br->levels) pointer at line (1033) and frees
it on some paths at line (1137). However, the problem occurs when the
function returns from line (1134) where the pointer (br->levels) is
not freed. Thus, causing a memory leak when the function returns from
line (1134).


~Ahmed
