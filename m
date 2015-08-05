From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Question about ACPI 6 and the Linux kernel
Date: Wed, 05 Aug 2015 15:46:23 +0200
Message-ID: <11330052.dDMj2NJ2Yp@vostro.rjw.lan>
References: <CAGXs5wVGn1DUXPw94cEXp5KZWq=bUCBpNPE_irgO32y94V8C0g@mail.gmail.com> <55C08E7E.50102@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49266 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751780AbbHENTS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 09:19:18 -0400
In-Reply-To: <55C08E7E.50102@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Kevin Wilson <wkevils@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, August 04, 2015 06:05:50 PM Hanjun Guo wrote:
> Hi Kevin,
> 
> On 08/04/2015 12:35 PM, Kevin Wilson wrote:
> > Hi all,
> > Is the current ACPI linux subsystem, that you find in the official Linus tree,
> >   compliant (even partially) with ACPI 6 ? (which was released in April 2015)
> >
> > or is it now compliant only with ACPI 5 ?
> 
> ACPI 6 have lots of new features, such as add support for NVDIMM
> (persistent memory), hierarchical lower-power idle states of CPUs, CPU
> clusters, and some support for ARM platforms (GIC, SMMU and etc.),
> and more...
> 
> so what the specific features are you referring to?
> 
> >
> > What are the plans for ACPI 6? Is there already some git branch for it ?
> 
> For all the ACPI 6 new features, ACPICA already add its support in 4.2,
> and some of the ACPI driver support also is ready, such as support for
> persistent memory [1] is ready, and Linaro is leading the ACPI 6.0 for
> ARM support, but as far as I can know, some of ACPI 6.0 features are
> still under development at now.
> 
> I think the main support for ACPI 6.0 is in Rafael's tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
> [1]: https://lwn.net/Articles/640891/

Right.

The question should not be "Is it compliant?", though.  It rather should be
"Is new ACPI 6 material covered?".  The majority of ACPI 6 is the same as
ACPI 5, of course.

Thanks,
Rafael

