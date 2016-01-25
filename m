From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write
 operations
Date: Mon, 25 Jan 2016 14:48:03 -0600
Message-ID: <56A68A03.4090101@codeaurora.org>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
 <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
 <CAOZdJXX5moGhs_+EMr00z0k4CW+n3s3s6HfzLZKk8VcVnNCS-w@mail.gmail.com>
 <CAJ5Y-eZ5w7o2GFaqn8M3JciCQi5OPDJ8THfQGN9JijQi0H-qNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52913 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933140AbcAYUsH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 15:48:07 -0500
In-Reply-To: <CAJ5Y-eZ5w7o2GFaqn8M3JciCQi5OPDJ8THfQGN9JijQi0H-qNw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

Ashwin Chaugule wrote:
> Prashanth has been doing the right thing all along. I was CC'd on all
> his patchwork, but you changed it (and removed me) while replying.

I did not remove your CC:.

I can't explain it, but the patch "[Linaro-acpi] [PATCH V2 1/4] ACPI / 
CPPC: Optimize PCC Read Write operations" in my inbox does not list you 
on the CC:  This is what the header says:

From: Prashanth Prakash <pprakash@codeaurora.org>
To: rjw@rjwysocki.net
Date: Fri, 22 Jan 2016 18:07:17 -0700
Message-Id: <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linux-acpi@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>,
  linaro-acpi@lists.linaro.org
Subject: [Linaro-acpi] [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write
	operations
X-BeenThere: linaro-acpi@lists.linaro.org


When I look at the spinics.net archive, I see you are on it:

	http://www.spinics.net/lists/linux-acpi/msg63274.html

I do not understand why my email does not have your CC: on it.

> Unless Rafael thinks otherwise, I see no major issues in V2, so there
> is no need for a respin.

I think stripping away the __iomem is wrong.  The whole point behind the 
'sparse' tool is to catch invalid accesses to I/O memory.  When you 
typecast it away, then prevent sparse from catching those problem.
