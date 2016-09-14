From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 24/26] ACPI / APD: constify local structures
Date: Wed, 14 Sep 2016 02:54:21 +0200
Message-ID: <3479523.AUgAeqlLYs@vostro.rjw.lan>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr> <1473599168-30561-25-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57582 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932856AbcINAsO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 20:48:14 -0400
In-Reply-To: <1473599168-30561-25-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, September 11, 2016 03:06:06 PM Julia Lawall wrote:
> For structure types defined in the same file or local header files, find
> top-level static structure declarations that have the following
> properties:
> 1. Never reassigned.
> 2. Address never taken
> 3. Not passed to a top-level macro call
> 4. No pointer or array-typed field passed to a function or stored in a
> variable.
> Declare structures having all of these properties as const.
> 
> Done using Coccinelle.
> Based on a suggestion by Joe Perches <joe@perches.com>.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.

Thanks,
Rafael

