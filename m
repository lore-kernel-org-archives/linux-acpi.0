From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 1/5] ACPI / processor_idle: introduce ACPI_PROCESSOR_CSTATE
Date: Wed, 11 May 2016 14:28:34 -0400
Message-ID: <CAJvTdKmTykoMBw9dCpw0X0ep2qTPSu94-zzUmdrFwUfDeXueqA@mail.gmail.com>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
	<1462981062-24909-2-git-send-email-sudeep.holla@arm.com>
	<CAJvTdKnJPZ9Nfib=CqBczMP4BERqfqAzeSR-+jjFOGZR51oVmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35124 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbcEKS2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2016 14:28:36 -0400
In-Reply-To: <CAJvTdKnJPZ9Nfib=CqBczMP4BERqfqAzeSR-+jjFOGZR51oVmg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, X86 ML <x86@kernel.org>, linux-ia64@vger.kernel.org

What is the functional goal/purpose of adding CONFIG_ACPI_PROCESSOR_CSTATE?

If the answer is that it saves code space on an ARM build, how much
space does it save?

Len Brown, Intel Open Source Technology Center
