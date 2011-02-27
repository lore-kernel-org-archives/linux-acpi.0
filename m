From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] intel_idle: disable NHM/WSM HW C-state auto-demotion (v3)
Date: Sun, 27 Feb 2011 17:17:53 +0100
Message-ID: <AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS@mail.gmail.com>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
	<alpine.LFD.2.02.1101190035200.14668@x980>
	<alpine.LFD.2.02.1102160119430.843@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62985 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1B0QR4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Feb 2011 11:17:56 -0500
In-Reply-To: <alpine.LFD.2.02.1102160119430.843@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 16, 2011 at 7:22 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> Hardware C-state auto-demotion is a mechanism where the HW overrides
> the OS C-state request, instead demoting to a shallower state,
> which is less expensive, but saves less power.
I'm interrested, for pytimechart, to have trace information of what
actual c-state got reached after each idle request.
Do you have any info on how to get that?

Regards
Pierre
