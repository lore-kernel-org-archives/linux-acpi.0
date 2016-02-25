From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] IORT: Add in support for the SMMUv3 subtable
Date: Wed, 24 Feb 2016 18:32:30 -0700
Message-ID: <56CE59AE.5090908@redhat.com>
References: <56CE592B.1020206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbcBYBcb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Feb 2016 20:32:31 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 3F4D27F082
	for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2016 01:32:31 +0000 (UTC)
Received: from fidelio.ahs3 (ovpn-113-31.phx2.redhat.com [10.3.113.31])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1P1WUaE031368
	for <linux-acpi@vger.kernel.org>; Wed, 24 Feb 2016 20:32:31 -0500
In-Reply-To: <56CE592B.1020206@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 02/24/2016 06:30 PM, Al Stone wrote:
> The most recent version of the IORT specification adds in a definition
> for a subtable to describe SMMUv3 devices; there is already a subtable
> for SMMUv1/v2 devices.
> 
> Add in the definition of the subtable, add in the code to compile it,
> and add in a template for it.
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>

[snip...]

My apologies. Please ignore this patch. I inadvertently sent it to the
wrong mailing list.

Some day, I hope to know how to use email well... :/



-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
