From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 acpi: on wakeup, ljmp directly after writing CR0.PE
Date: Sun, 26 Oct 2008 13:29:00 -0700
Message-ID: <4904D30C.7080200@zytor.com>
References: <200810262038.51149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47524 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbYJZU3o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Oct 2008 16:29:44 -0400
In-Reply-To: <200810262038.51149.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Rafael J. Wysocki wrote:
> Ingo, Peter,
> 
> I have this patch in my queue, is it necessary or should I drop it?
> 

It's unclear if it's necessary, but I think it's more compliant and we 
should do it.

	-hpa
