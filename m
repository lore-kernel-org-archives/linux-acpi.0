From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: next-20170815 build: 2 failures 4 warnings (next-20170815)
Date: Tue, 15 Aug 2017 13:59:46 +0200
Message-ID: <13442814.gWUDHvzIl2@aspire.rjw.lan>
References: <E1dhZPk-0002d9-9k@optimist> <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54675 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751654AbdHOMIL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 08:08:11 -0400
In-Reply-To: <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday, August 15, 2017 1:16:12 PM CEST Mark Brown wrote:
> 
> --xqegarazqzvkdxmo
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build on arm64 due to:
> 
> > 	arm64-allmodconfig
> > 	arm64-defconfig
> > ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
> > ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token
> 
> caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
> which has an unresolved conflict in it.

Yes, I broke this, sorry.

Will fix it shortly.

Thanks,
Rafael

