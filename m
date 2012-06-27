From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/8] free memory device if acpi_memory_enable_device()
 failed
Date: Tue, 26 Jun 2012 21:12:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262112430.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97EA5.9010904@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34158 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab2F0EM6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 00:12:58 -0400
Received: by dady13 with SMTP id y13so818482dad.19
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jun 2012 21:12:58 -0700 (PDT)
In-Reply-To: <4FE97EA5.9010904@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

On Tue, 26 Jun 2012, Wen Congyang wrote:

> If acpi_memory_enable_device() fails, acpi_memory_enable_device() will
> return a non-zero value, which means we fail to bind the memory device
> to this driver. So we should free memory device before acpi_memory_device_add()
> returns.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
