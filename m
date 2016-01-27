From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
Date: Wed, 27 Jan 2016 09:41:56 -0800
Message-ID: <CAPw-ZTnj10eP+NDzYxbc4mJG5tG1dC3pr8VOOh5uJckJO8kS7A@mail.gmail.com>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
	<CAPw-ZTk=BbXAPgWAV=3Np0qvLA+i+U5eh+nxHS=2uMjKohdUfA@mail.gmail.com>
	<20160127115126.GB9522@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33253 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933653AbcA0Rl6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2016 12:41:58 -0500
Received: by mail-lb0-f175.google.com with SMTP id x4so9789008lbm.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2016 09:41:57 -0800 (PST)
In-Reply-To: <20160127115126.GB9522@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>

Hi,

> >
> > I had tested this with X-Gene Mustang board. It applies cleanly
> > against 4.5.0-rc1 and detected all CPU's. For those of you want to try
> > this, you need an FW update if you are using APM Tianocore. Otherwise,
> > it will stuck in very early booting stage.
>
> We can take this as a Tested-by, right ?


Yes... if you want one.

-Loc
