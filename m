From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: 2.6.21-rc4-mm1 and rc5-mm2 - problem with cpuidle routine
Date: Thu, 29 Mar 2007 22:17:27 -0400
Message-ID: <75b66ecd0703291917x4f497f53s464663a1e8a0fa3c@mail.gmail.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	 <1174433034.62033.16.camel@localhost>
	 <20070320223643.d8cbc3f6.akpm@linux-foundation.org>
	 <46017E56.7050400@lwfinger.net>
	 <20070321133815.304eb256.akpm@linux-foundation.org>
	 <20070322003315.GA17996@linux-os.sc.intel.com>
	 <460C670A.9060204@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:26244 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbXC3CR3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2007 22:17:29 -0400
Received: by ik-out-1112.google.com with SMTP id c21so295676ika
        for <linux-acpi@vger.kernel.org>; Thu, 29 Mar 2007 19:17:28 -0700 (PDT)
In-Reply-To: <460C670A.9060204@comcast.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ed Sweetman <safemode2@comcast.net>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Larry Finger <larry.finger@lwfinger.net>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On 3/29/07, Ed Sweetman <safemode2@comcast.net> wrote:
> NVRM: loading NVIDIA UNIX x86_64 Kernel Module  1.0-9746  Fri Dec 15 10:19:35 PST 2006
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> NVRM: loading NVIDIA UNIX x86_64 Kernel Module  1.0-9746  Fri Dec 15 10:19:35 PST 2006
> **WARNING** I2C adapter driver [NVIDIA i2c adapter ] forgot to specify physical

Please try to reproduce with an untainted kernel.

Lee
