From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [patch 32/59] x86_64: get boot_cpu_id as early for k8_scan_nodes
Date: Sat, 11 Aug 2007 21:05:45 -0700
Message-ID: <86802c440708112105s745c6164v61dfeab23b455ac6@mail.gmail.com>
References: <200708102200.l7AM019i011880@imap1.linux-foundation.org>
	 <200708112242.04946.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:63599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXHLEFp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 00:05:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1412079wah
        for <linux-acpi@vger.kernel.org>; Sat, 11 Aug 2007 21:05:45 -0700 (PDT)
In-Reply-To: <200708112242.04946.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, ak@suse.de, clameter@sgi.com

On 8/11/07, Len Brown <lenb@kernel.org> wrote:
> I hate to burst this bubble,
> but we have evidence that the only reliable way to enumerate
> processors on an ACPI systems is to parse the DSDT.

the only reliable way? is that too ...

YH
