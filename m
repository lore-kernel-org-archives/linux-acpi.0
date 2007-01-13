From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Sat, 13 Jan 2007 13:33:12 +0000
Message-ID: <1e2af89e0701130533o7cdead43g9ab79b71f852ac71@mail.gmail.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com>
	 <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>
	 <1e2af89e0701130429x7083b6d7we89174dd7e130364@mail.gmail.com>
	 <45A8DAA9.3010300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422648AbXAMNdO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 08:33:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so996604uga
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jan 2007 05:33:12 -0800 (PST)
In-Reply-To: <45A8DAA9.3010300@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Hi,

> If BIOS does not export fan controls to OS via DSDT, it means that BIOS
> wants to control fans via its own means (hardware), this doesn't mean
> that your machine is at risk, it only means that you are not allowed to
> tamper with it...

Well, except the original poster complained that linux but not windows
was shutting down the fan - meaning - surely - that somehow linux is
tampering with the fan when it should not.

Best,

Matthew
