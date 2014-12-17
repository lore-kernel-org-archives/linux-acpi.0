From: "Charles Garcia-Tobin" <charles.garcia-tobin@arm.com>
Subject: RE: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Wed, 17 Dec 2014 13:43:31 -0000
Message-ID: <000001d019ff$734ee6d0$59ecb470$@arm.com>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel> <20141216152707.GH11565@e104818-lin.cambridge.arm.com> <5490C83A.2080600@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51150 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbaLQNnm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Dec 2014 08:43:42 -0500
In-Reply-To: <5490C83A.2080600@linaro.org>
Content-Language: en-gb
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Al Stone' <al.stone@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linaro-acpi-bounces@lists.linaro.org [mailto:linaro-acpi-
> bounces@lists.linaro.org] On Behalf Of Al Stone
> Sent: 17 December 2014 00:03
> To: Catalin Marinas; Arnd Bergmann
> Cc: linaro-acpi@lists.linaro.org; Rafael J. Wysocki; ACPI Devel Mailing
> List; Olof Johansson; linux-arm-kernel@lists.infradead.org
> Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
> 
> On 12/16/2014 08:27 AM, Catalin Marinas wrote:
> > On Tue, Dec 16, 2014 at 11:27:48AM +0000, Arnd Bergmann wrote:
> >> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> >>> TODO List for ACPI on arm64:
> >>> ============================
> [snip..]
> >>> 4. Set clear expectations for those providing ACPI for use with
> Linux
> >>>    * Problem:
> >>>      * Hardware/Firmware vendors can and will create ACPI tables
> that
> >>>        cannot be used by Linux without some guidance
> >>>      * Kernel developers cannot determine whether the kernel or
> firmware
> >>>        is broken without knowing what the firmware should do
> >>>    * Solution: document the expectations, and iterate as needed.
> >>>      Enforce when we must.
> >>>    * Status: initial kernel text available; AMD has offered to make
> >>>      their guidance document generic; firmware summit planned for
> >>>      deeper discussions.
> >>
> [snip...]
> >
> > Another example is SMP booting. The ACPI 5.1 spec mentions the
> parking
> > protocol but I can't find a reference to the latest document. In the
> > meantime, we stick to PSCI.
> 
> Hrm.  A bug in the spec.
> 
> Every external document mentioned in the ACPI spec is supposed to have
> a link that will eventually get you to the source document.  All links
> in the spec should point here http://www.uefi.org/acpi which in turn
> has links to the authoritative original documents.  However, it looks
> like the parking protocol document pointed to (the "Multiprocessor
> Startup" link) may not be the most recent version.  The reference in
> the spec to the protocol (Table 5-61, Section 5.2.12.14)) also appears
> to be useless (it points to http://infocenter.arm.com/help/index.jsp
> which doesn't have the document either).  I've filed a change request
> with ASWG to fix this.

I also raised both of these a while back, I expect the next errata release
to correct this.

> 
> That being said, the early systems still don't provide PSCI.  They will
> at some point in the future, but not now.  Regardless, I think it's
> reasonable for us to say that if you want ACPI support, PSCI must be
> used for secondary CPU startup.  People can hack something up to get
> the parking protocol to work on development branches if they want, but
> I personally see no need to get that into the kernel -- and it needs
> to be said explicitly in arm-acpi.txt.
> 
> 
> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Linaro Enterprise Group
> al.stone@linaro.org
> -----------------------------------
> 
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-acpi



