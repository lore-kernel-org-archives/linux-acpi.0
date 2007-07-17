From: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Mon, 16 Jul 2007 19:10:21 -0700
Message-ID: <8f95bb250707161910j7b6e333cwd09d937709386a9f@mail.gmail.com>
References: <20070716180019.GA5112@google.com>
	 <1184636816.11983.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:33467 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbXGQCKb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 22:10:31 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id l6H2AQIW004916
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 19:10:26 -0700
Received: from wa-out-1112.google.com (wafk17.prod.google.com [10.114.187.17])
	by zps37.corp.google.com with ESMTP id l6H2A5Hw021546
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 19:10:22 -0700
Received: by wa-out-1112.google.com with SMTP id k17so2166803waf
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 19:10:22 -0700 (PDT)
In-Reply-To: <1184636816.11983.1.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, ak@suse.de, akpm@osdl.org

On 7/16/07, Shaohua Li <shaohua.li@intel.com> wrote:
> On Tue, 2007-07-17 at 02:00 +0800, Aaron Durbin wrote:
> >
> > Add the ability to reset the machine using the RESET_REG in ACPI's
> > FADT table.
> We could have another command for 'reboot' kernel command line.
>

I did this in a separate patch for x86_64. See

http://www.ussg.iu.edu/hypermail/linux/kernel/0707.2/0319.html
and
http://www.ussg.iu.edu/hypermail/linux/kernel/0707.2/0319.html

-Aaron
