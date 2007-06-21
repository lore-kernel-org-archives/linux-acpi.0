From: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: A question about commit 88db5e1489f23876a226f5393fd978ddc09dc5f9
Date: Thu, 21 Jun 2007 12:08:27 +0800
Message-ID: <ac8af0be0706202108s2fb8a01epb9736cc5eabc4eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:61981 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbXFUEIa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 00:08:30 -0400
Received: by py-out-1112.google.com with SMTP id a29so748935pyi
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jun 2007 21:08:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alexey.y.starikovskiy@intel.com
Cc: linux-acpi@vger.kernel.org

Hi Alexey,

I'm a ACPI newbie, and just have a question about your comments for this commit

"   HP nx6125/nx6325/... machines have a _GPE handler with an infinite
    loop sending Notify() events to different ACPI subsystems.

    Notify handler in ACPI driver is a C-routine, which may call ACPI
    interpreter again to get access to some ACPI variables
    (acpi_evaluate_xxx).
    On these HP machines such an evaluation changes state of some variable
    and lets the loop above break.
"

I guess that this _GPE handler is provided by HP nx6125/nx6325/.. BIOS, right?

Thanks,
Forrest
