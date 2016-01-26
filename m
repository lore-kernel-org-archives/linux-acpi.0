From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write
 operations
Date: Tue, 26 Jan 2016 09:41:27 -0700
Message-ID: <56A7A1B7.30808@codeaurora.org>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
 <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
 <CAOZdJXX5moGhs_+EMr00z0k4CW+n3s3s6HfzLZKk8VcVnNCS-w@mail.gmail.com>
 <CAJ5Y-eZ5w7o2GFaqn8M3JciCQi5OPDJ8THfQGN9JijQi0H-qNw@mail.gmail.com>
 <56A68A03.4090101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53136 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbcAZQla (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2016 11:41:30 -0500
In-Reply-To: <56A68A03.4090101@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

Hi Ashwin/Timur,
>> Unless Rafael thinks otherwise, I see no major issues in V2, so there
>> is no need for a respin.
>
> I think stripping away the __iomem is wrong.  The whole point behind the 'sparse' tool is to catch invalid accesses to I/O memory.  When you typecast it away, then prevent sparse from catching those problem.

Thanks for your inputs. I will wait for few more days for feedback from Rafael and others before another respin with the suggested changes.

Thanks,
Prashanth
