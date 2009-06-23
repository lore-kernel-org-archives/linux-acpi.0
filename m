From: Lin Ming <lin@minggr.cn>
Subject: Re: Question about AML code
Date: Tue, 23 Jun 2009 13:24:34 +0800
Message-ID: <d3f22a0906222224r3e375e07mfdf8bf68c1f95f92@mail.gmail.com>
References: <ff05f3d00906222109g5e6aa02fp495946e7966c8b61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:44261 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbZFWFYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 01:24:31 -0400
Received: by rv-out-0506.google.com with SMTP id f6so18154rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2009 22:24:34 -0700 (PDT)
In-Reply-To: <ff05f3d00906222109g5e6aa02fp495946e7966c8b61@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Jun 23, 2009 at 12:09 PM, Edward Shao<laface.tw@gmail.com> wrote:
> Dear folk,
>
> Sorry, I does not familiar with ASL.
> I would like to ask if below ASL is valid or not.
>
> While (LLess (Local0, 0x0B))
> {
>        Name (_T_0, Zero)
>        Store (LCDD, _T_0)
>        If (LEqual (_T_0, 0x01DFE430))
>        {
>                ...
>        }
>        Else
>        {
>                ...
>        }
> }
>
> I got ACPI error like below.
> [   37.457772] nssearch-0145 [12] ns_search_one_scope   : Name [_T_0]
> (Integer) f7444780 found in scope [GBQC] f741cc00
> [   37.457775] ACPI Error (dswload-0790): [_T_0] Namespace lookup
> failure, AE_ALREADY_EXISTS
> [   37.457779]  dsutils-0089 [08] ds_clear_implicit_retu: Removing
> reference on stale implicit return obj f772d348
> [   37.457782] ACPI Exception (psloop-0227): AE_ALREADY_EXISTS, During
> name lookup/catalog [20081204]

It's because _T_0 is created multiple times in the while loop.
You can move "Name (_T_0, Zero)" outside of the while loop, as below,

Name (_T_0, Zero)
While (LLess (Local0, 0x0B))
{
    Store (LCDD, _T_0)
    .....
}

Lin Ming
