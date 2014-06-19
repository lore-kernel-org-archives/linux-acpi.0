From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: use kstrto*() instead of simple_strto*()
Date: Thu, 19 Jun 2014 02:04:53 +0200
Message-ID: <2154416.4nBnIoV6r0@vostro.rjw.lan>
References: <1402688998-20142-1-git-send-email-christophjaeger@linux.com> <alpine.DEB.2.02.1406161724020.21018@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54381 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752276AbaFRXrS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 19:47:18 -0400
In-Reply-To: <alpine.DEB.2.02.1406161724020.21018@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Christoph Jaeger <christophjaeger@linux.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 16, 2014 05:24:12 PM David Rientjes wrote:
> On Fri, 13 Jun 2014, Christoph Jaeger wrote:
> 
> > simple_strto*() are obsolete; use kstrto*() instead. Add proper error
> > checking.
> > 
> > Signed-off-by: Christoph Jaeger <christophjaeger@linux.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Applied, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
