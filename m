From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 4/6] printk: Break out printk_time
Date: Sat, 19 Feb 2011 17:51:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102191732120.27722@chino.kir.corp.google.com>
References: <20110219024705.308511527@gulag1.americas.sgi.com> <20110219024705.979810372@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:4101 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab1BTBvP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Feb 2011 20:51:15 -0500
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id p1K1pD66003890
	for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:13 -0800
Received: from pwj4 (pwj4.prod.google.com [10.241.219.68])
	by kpbe18.cbf.corp.google.com with ESMTP id p1K1pBRC016325
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:12 -0800
Received: by pwj4 with SMTP id 4so1063852pwj.24
        for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:11 -0800 (PST)
In-Reply-To: <20110219024705.979810372@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, 18 Feb 2011, Mike Travis wrote:

> Clean up printk_time by making it a separate function.
> 
> Signed-off-by: Mike Travis <travis@sgi.com>

Acked-by: David Rientjes <rientjes@google.com>
