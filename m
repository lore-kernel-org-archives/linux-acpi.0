From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 3/5] acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
Date: Mon, 4 Feb 2013 11:44:34 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302041142550.10378@chino.kir.corp.google.com>
References: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com> <1359967426-32629-4-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:62254 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab3BDTog (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2013 14:44:36 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2807938dak.14
        for <linux-acpi@vger.kernel.org>; Mon, 04 Feb 2013 11:44:36 -0800 (PST)
In-Reply-To: <1359967426-32629-4-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Mon, 4 Feb 2013, liguang wrote:

> srat table should present only on acpi domain,
> seems mm/ is not the right place for it.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> ---
>  arch/x86/kernel/acpi/Makefile |    1 +
>  arch/x86/mm/Makefile          |    1 -
>  arch/x86/mm/srat.c            |  191 -----------------------------------------
>  3 files changed, 1 insertions(+), 192 deletions(-)
>  delete mode 100644 arch/x86/mm/srat.c
> 

I was excited for a moment because this would have been one great cleanup, 
but you never readded the code to arch/x86/kernel/acpi.  (You probably 
need to do "git add <newfile>" before generating the patch file.)  I do 
like the idea of moving it, though, if it's build tested thoroughly.
