From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] ACPI: Support for platform initiated graceful shutdown
Date: Thu, 07 Jul 2016 15:11:34 +0200
Message-ID: <22950960.04B50Jb3Jb@vostro.rjw.lan>
References: <1466706266-25513-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44742 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750902AbcGGNG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 09:06:58 -0400
In-Reply-To: <1466706266-25513-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, cov@codeaurora.org, ahs3@redhat.com, harba@codeaurora.org

On Thursday, June 23, 2016 12:24:26 PM Prashanth Prakash wrote:
> This patch adds support for platform initited graceful shutdown as
> described in sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec
> 
> The OSPM will get a graceful shutdown request via a Notify operator
> on \_SB device with a value of 0x81 per section 5.6.6. Following the
> shutdown request from platform the OSPM needs to follow the
> processing sequence as described in section 6.2.5.1.
> 
> v3
> * Switched to regular work with delays from delayed work
> * Dropped changes to actypes.h
> * Small style changes
> 
> v2
> * Switched from standalone driver to a simple notify handler
> 
> v1
> * Initial
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

Applied, thanks!

