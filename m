From: "=?GB2312?B?0Lu42Q==?=" <xiegang112@gmail.com>
Subject: ACPI no hander for GPE
Date: Fri, 6 Apr 2007 17:09:15 +0800
Message-ID: <d364733c0704060209x47a5b442iefe8b9840496f09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:54474 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766521AbXDFJJQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Apr 2007 05:09:16 -0400
Received: by nz-out-0506.google.com with SMTP id s1so469440nze
        for <linux-acpi@vger.kernel.org>; Fri, 06 Apr 2007 02:09:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, all
I tried to set the register to trigger a SCI. But the system crashed
with output:
[ACPI]Error (evgpe-0711): No hander or method for GPE [2],disabling ......

Did I set wrong register?

The system's ioports map is different from ACPI register map defined
in Intel ICH8 manual. My kernel version is 2.6.18.

Any suggestion will be appreciated.

Thanks

Xie Gang
