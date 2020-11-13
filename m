Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFBC388F7
	for <linux-acpi@archiver.kernel.org>; Fri, 13 Nov 2020 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B4220797
	for <linux-acpi@archiver.kernel.org>; Fri, 13 Nov 2020 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKMQ34 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:29:56 -0500
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:47578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgKMQ34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 11:29:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1CE8118224D75;
        Fri, 13 Nov 2020 16:29:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wren57_400b39e27310
X-Filterd-Recvd-Size: 3413
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 16:29:53 +0000 (UTC)
Message-ID: <61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Nov 2020 08:29:52 -0800
In-Reply-To: <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
         <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
         <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
         <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
         <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2020-11-13 at 09:14 +0100, Miguel Ojeda wrote:
> On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > 
> > Thank you for the explicit diagnostics observed.  Something fishy is
> > going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC to
> > handle include/linux/compiler_attributes.h.
> > 
> > The C preprocessor should make it such that MSVC never sees
> > `__attribute__` or `__fallthrough__`; that it does begs the question.
> > That would seem to imply that `#if __has_attribute(__fallthrough__)`
> > somehow evaluates to true on MSVC, but my godbolt link shows it does
> > not.
> > 
> > Could the upstream ACPICA project be #define'ing something that could
> > be altering this? (Or not #define'ing something?)
> > 
> > Worst case, we could do as Joe Perches suggested and disable
> > -Wfallthrough for drivers/acpi/acpica/.
> 
> I agree, something is fishy. MSVC has several flags for conformance
> and extensions support, including two full C preprocessors in newer
> versions; which means we might be missing something, but I don't see
> how the code in compiler_attributes.h could be confusing MSVC even in
> older non-conforming versions.

I believe this has nothing to do with linux and only
to do with compiling acpica for other environments
like Windows.

From: https://acpica.org/

The ACPI Component Architecture (ACPICA) project provides an
operating system (OS)-independent reference implementation of the
Advanced Configuration and Power Interface Specification (ACPI).

It can be easily adapted to execute under any host OS.


