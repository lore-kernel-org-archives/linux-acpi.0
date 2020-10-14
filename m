Return-Path: <SRS0=IuZU=DV=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28DC433DF
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Oct 2020 21:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D15C2223F
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Oct 2020 21:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgJNVNe (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 14 Oct 2020 17:13:34 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:42902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgJNVNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 17:13:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AF21E182CED28;
        Wed, 14 Oct 2020 21:13:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toy72_1009c2b2720f
X-Filterd-Recvd-Size: 2001
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 21:13:30 +0000 (UTC)
Message-ID: <567bd8f4f6080c6c3b414d1a9c18aff4c224946e.camel@perches.com>
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 14 Oct 2020 14:13:29 -0700
In-Reply-To: <BYAPR11MB325695B550880788DBED54DB87050@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20200707200716.GA4920@embeddedor>
         <CAJZ5v0iDz_EsrpdMQQDfaVC2orMQkEcubmR6-J6mvtrXmKXbRg@mail.gmail.com>
         <BYAPR11MB325602EDA2D2ACC2B28EAF4687670@BYAPR11MB3256.namprd11.prod.outlook.com>
         <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
         <ae54364041b99b89f818812d957d4a4bb4efdc25.camel@perches.com>
         <BYAPR11MB325695B550880788DBED54DB87050@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2020-10-14 at 20:48 +0000, Moore, Robert wrote:
> I'm afraid that the macro does not compile under MSVC:
> 
> warning C4067: unexpected tokens following preprocessor directive - expected a newline (compiling source file ..\..\source\tools\acpiexec\aetests.c)
> 
>  It looks like "__has_attribute" is not supported.

It looks more like compiler.h/compiler_types.h/compiler_attributes.h
doesn't support msvc.



