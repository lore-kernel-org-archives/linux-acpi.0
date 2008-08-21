From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 1/2] acpi: add checking for NULL early param
Date: Thu, 21 Aug 2008 08:46:12 +0200
Message-ID: <8763pun9vv.fsf@basil.nowhere.org>
References: <200808202341.m7KNfkb8005410@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56756 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806AbYHUGqO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 02:46:14 -0400
In-Reply-To: <200808202341.m7KNfkb8005410@imap1.linux-foundation.org> (akpm@linux-foundation.org's message of "Wed, 20 Aug 2008 16:41:45 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, gorcunov@gmail.com

akpm@linux-foundation.org writes:

> From: Cyrill Gorcunov <gorcunov@gmail.com>
>
> The early_param handling function could recieve NULL pointer as argument
> in case if user didn't enter parameter value.  So we have to be ready for
> a such situation and do check for NULL pointer if needed.
>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Queued for 2.6.27. Thanks.

But I wonder if it wouldn't be generally safer for the caller to just pass
an empty string instead of NULL in this case?

-Andi
