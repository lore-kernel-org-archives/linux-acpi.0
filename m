From: "Mitch Davis" <mjd-kernel-org@afork.com>
Subject: bugzilla.kernel.org bug 7988: Resume from RAM on Toshiba A100 fails
Date: Thu, 22 Feb 2007 01:48:43 +1100
Message-ID: <8956d4ca0702210648v43f99a5el53f5a15b2b99a8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:64175 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbXBUOso (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Feb 2007 09:48:44 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2246044nze
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2007 06:48:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I was inspired by Matthew Garrett's talk at LCA to find out why my
Toshiba laptop doesn't resume after a suspend.  I did what I could to
diagnose it, and logged the problem here:

 http://bugzilla.kernel.org/show_bug.cgi?id=7988

So far, no-one has commented, and my server logs say no-one has looked
at the diagnostic info I put on my website.

Can someone have a look and give me a clue please?

Is there more info I should provide?  A patch to try?  Maybe I should
sacrifice a chicken?

Thank you,

Mitch.
