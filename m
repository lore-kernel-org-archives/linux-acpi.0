Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF83C2D0E4
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Nov 2020 02:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2E20720
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Nov 2020 02:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgKXCaC (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:30:02 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:51632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728069AbgKXCaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 21:30:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BFE0F181D3026;
        Tue, 24 Nov 2020 02:30:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brass76_52018ef2736a
X-Filterd-Recvd-Size: 2652
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 02:29:59 +0000 (UTC)
Message-ID: <2b5803f8d4fd9764c1b6f5b32e7a9716fa64024c.camel@perches.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        fthain@telegraphics.com.au,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 23 Nov 2020 18:29:57 -0800
In-Reply-To: <CAKwvOdkxY4pXN4wbYM_B1cLjr8uX6sQ2iS=m=rRGL_TkJQUFZw@mail.gmail.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <202011201129.B13FDB3C@keescook>
         <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <202011220816.8B6591A@keescook>
         <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
         <20201123174648.6a22575b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <CAKwvOdkxY4pXN4wbYM_B1cLjr8uX6sQ2iS=m=rRGL_TkJQUFZw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-11-23 at 18:05 -0800, Nick Desaulniers wrote:
> (minus all of these lists, except LKML, CBL, and ACPI)
> 
> On Mon, Nov 23, 2020 at 5:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Mon, 23 Nov 2020 17:32:51 -0800 Nick Desaulniers wrote:
> > > On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> > > > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > > > If none of the 140 patches here fix a real bug, and there is no
> > change
> > > > > to machine code then it sounds to me like a W=2 kind of a warning.
> > > > 
> > > > FWIW, this series has found at least one bug so far:
> > > > 
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> > 
> > > 
> > > So looks like the bulk of these are:
> > > switch (x) {
> > >   case 0:
> > >     ++x;
> > >   default:
> > >     break;
> > > }
> > > 
> > > I have a patch that fixes those up for clang:
> > > https://reviews.llvm.org/D91895

Pity.  It's a good warning.  gcc not warning is a mistake in my view.


