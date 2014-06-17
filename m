From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI: use kstrto*() instead of simple_strto*()
Date: Mon, 16 Jun 2014 17:24:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406161724020.21018@chino.kir.corp.google.com>
References: <1402688998-20142-1-git-send-email-christophjaeger@linux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:45178 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbaFQAYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2014 20:24:15 -0400
Received: by mail-ig0-f173.google.com with SMTP id r2so3585772igi.12
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2014 17:24:14 -0700 (PDT)
In-Reply-To: <1402688998-20142-1-git-send-email-christophjaeger@linux.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Jaeger <christophjaeger@linux.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 13 Jun 2014, Christoph Jaeger wrote:

> simple_strto*() are obsolete; use kstrto*() instead. Add proper error
> checking.
> 
> Signed-off-by: Christoph Jaeger <christophjaeger@linux.com>

Acked-by: David Rientjes <rientjes@google.com>
