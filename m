From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/4] numa: avoid export acpi_numa variable
Date: Tue, 19 Feb 2013 13:25:09 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302191324520.6322@chino.kir.corp.google.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360894992-14818-3-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39392 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758931Ab3BSVZM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 16:25:12 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so3584834pab.18
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2013 13:25:11 -0800 (PST)
In-Reply-To: <1360894992-14818-3-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

On Fri, 15 Feb 2013, liguang wrote:

> acpi_numa is used to prevent srat table
> being parsed, seems a little miss-named,
> if 'noacpi' was specified by cmdline and
> CONFIG_ACPI_NUMA was enabled, acpi_numa
> will be operated directly from everywhere
> it needed to disable/enable numa in acpi
> mode which was a bad thing, so, try to
> export a fuction to get srat table
> enable/disable info.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
