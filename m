From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Mon, 23 Jun 2014 22:21:22 +0200
Message-ID: <14353430.fIAk0MDUYn@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org> <5338610.xCINKmsENX@wuerfel> <CAJ5Y-eaA6vPvhbfMjys8PeSC7B+=ZLLBYh4Wi79Nh9=pwB3+sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56643 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbaFWUVd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2014 16:21:33 -0400
In-Reply-To: <CAJ5Y-eaA6vPvhbfMjys8PeSC7B+=ZLLBYh4Wi79Nh9=pwB3+sg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Patch Tracking <patches@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday 23 June 2014 15:46:08 Ashwin Chaugule wrote:
> Hello,
> 
> On 23 June 2014 15:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >> Fair point. The more I think about this, it seems that if we want to
> >> use the mailbox framework for ACPI kernels, we should have a PCC
> >> specific bypass, something like the one you suggested below. The ACPI
> >> spec defines PCC as the only "mailbox" like mechanism. There are 3 PCC
> >> clients defined as well; CPPC, MPST and RASF. Each of these have their
> >> own ACPI tables and so they dont require special DSDT entries.
> >
> > Ok, I see. Can you describe what data is in these tables?
> 
> For CPPC, its a field for version number, number of entries and then
> followed by a bunch of PCC entries that have the following structure:
> 
>  51 struct pcc_register_resource {
>  52     u8 descriptor;
>  53     u16 length;
>  54     u8 space_id;
>  55     u8 bit_width;
>  56     u8 bit_offset;
>  57     u8 access_size;
>  58     u64 address;
>  59 } __attribute__ ((packed));
> 
> These essentially describe the PCC register space to be used by the
> respective protocol. e.g. CPPC uses these to exchange CPU performance
> metrics between the OS and the firmware.
> I believe MPST and RASF also follow the same format.

Interesting. So I guess it's one entry per client of the PCC? How
exactly does the client know which index to use in this table?

	Arnd
