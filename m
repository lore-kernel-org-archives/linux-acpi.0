Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3EC2D0E4
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Nov 2020 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A721D91
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Nov 2020 20:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKLUWZ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:22:25 -0500
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:50020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727000AbgKLUWZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 15:22:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7DB5E181D3025;
        Thu, 12 Nov 2020 20:22:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard96_2014c8327309
X-Filterd-Recvd-Size: 3419
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Nov 2020 20:22:21 +0000 (UTC)
Message-ID: <5cf1f03c2cf29ee173a7b3b81a0f2f8785b6aab8.camel@perches.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Nov 2020 12:22:20 -0800
In-Reply-To: <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
         <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
         <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-11-12 at 11:30 -0800, Nick Desaulniers wrote:
> On Thu, Nov 12, 2020 at 7:13 AM Moore, Robert <robert.moore@intel.com> wrote:
> > -----Original Message-----
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > On Wed, Nov 11, 2020 at 7:15 AM Moore, Robert <robert.moore@intel.com> wrote:
> > > Yes, but: isn't the "fallthrough" keyword compiler-specific? That is the problem for us.
> > It's not a keyword.
> > 
> > It's a preprocessor macro that expands to
> > __attribute__((__fallthrough__)) for compilers that support it.  For compilers that do not, it expands to nothing.  Both GCC 7+ and Clang support this attribute.  Which other compilers that support -Wimplicit-fallthrough do you care to support?
> > 
> > We need to support MSVC 2017 -- which apparently does not support this.
> 
> In which case, the macro is not expanded to a compiler attribute the
> compiler doesn't support.  Please see also its definition in
> include/linux/compiler_attributes.h.
> 
> From what I can tell, MSVC does not warn on implicit fallthrough, so
> there's no corresponding attribute (or comment) to disable the warning
> in MSVC.
> 
> That doesn't mean this code is not portable to MSVC; a macro that
> expands to nothing should not be a problem.

acpica is a special case as all the code is in a separate
repository and converted via Lindent to resemble linux
standard styles.

Perhaps it'd easier to avoid modifying acpica and add something like:
---
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 59700433a96e..469508a8d671 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
+ccflags-y			+= -Wno-implicit-fallthrough
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace


