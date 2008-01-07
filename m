From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 5/8] rtc: don't write RTC century when setting a wake
 alarm
Date: Mon, 7 Jan 2008 12:02:21 -0800
Message-ID: <20080107120221.ff956e28.akpm@linux-foundation.org>
References: <200712132353.lBDNrct8024833@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38670 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402AbYAGUEO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 15:04:14 -0500
In-Reply-To: <200712132353.lBDNrct8024833@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, lkml@rtr.ca, david-b@pacbell.net, mlord@pobox.com

On Thu, 13 Dec 2007 15:53:38 -0800
akpm@linux-foundation.org wrote:

> From: Mark Lord <lkml@rtr.ca>
> 
> Fix /proc/acpi/alarm to not overwrite the RTC century field when setting a
> wake alarm.  The alarm hardware doesn't have a century field, and we really
> should not be fiddling with the RTC century field here.

So this bugfix was summarily ignored without comment and a different one
was merged which caused this patch to get 100% rejects.  Great stuff.

I'll drop this one.  Mark, could you please redo and retest and we'll have
another go.


