From: "Christian Convey" <christian.convey@gmail.com>
Subject: How to debug a lid button state problem?
Date: Mon, 19 Mar 2007 11:01:12 -0400
Message-ID: <6addebae0703190801r75d79dc3h49c86d5db69862d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:7134 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbXCSPBN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2007 11:01:13 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1296439wxd
        for <linux-acpi@vger.kernel.org>; Mon, 19 Mar 2007 08:01:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm not a kernel developer, but I have a problem that needs
addressing, and I fear that might mean me.  Any guidance would be
appreciated.

I've got an HP Pavilion dv4000 notebook.  I'm running Ubuntu Feisty
(pre-release), with this kernel: "Linux peace 2.6.20-12-generic #2 SMP
Sun Mar 18 03:07:14 UTC 2007 i686 GNU/Linux"

My problem is this:
Whenever I run this command:
   cat /proc/acpi/button/lid/LID0/state
I always get the result:
   state:      open

This happens even if I'm pressing down the lid button when I execute
the 'cat' command.  I believe this is the root cause of why none of
the normal ACPI goodness happens when I close the lid (aside from the
LCD back-light turning off, but I don't think ACPI is involved in
that.)

Does anyone know how I can debug this, or at least what information I
(as a non-kernel developer) can gather to help out the folks that try
to make this stuff work?

Thanks,
Christian
