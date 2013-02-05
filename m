From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 3/4] acpi: add clock_domain field to
 acpi_srat_cpu_affinity
Date: Mon, 4 Feb 2013 21:31:06 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302042127300.31498@chino.kir.corp.google.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360031838-26898-4-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:47986 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3BEFbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2013 00:31:09 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so9176914iaf.28
        for <linux-acpi@vger.kernel.org>; Mon, 04 Feb 2013 21:31:09 -0800 (PST)
In-Reply-To: <1360031838-26898-4-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Tue, 5 Feb 2013, liguang wrote:

> according to ACPI SPEC v5.0, page 152,
> 5.2.16.1 Processor Local APIC/SAPIC Affinity Structure,
> the last member of it is clock_domain.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
