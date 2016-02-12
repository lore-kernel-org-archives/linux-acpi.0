From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
Date: Fri, 12 Feb 2016 10:51:30 -0800
Message-ID: <20160212185130.GA10095@kroah.com>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37464 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbcBLSvb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2016 13:51:31 -0500
Content-Disposition: inline
In-Reply-To: <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>

On Fri, Feb 12, 2016 at 08:43:34PM +0300, Aleksey Makarov wrote:
> The function acpi_table_parse() has some problems:
> 1 It can be called only from __init code
> 2 It does not pass any data to the handler
> 3 It just throws out the value returned from the handler
> 
> These issues are addressed in this patch

Why not just fix acpi_table_parse(), like you have, and not add a new
API call with a "2" at the end of it.  That seems crazy to try to
maintain that level of apis.

But I'm not the acpi maintainer(s), so it's their call...

good luck,

greg k-h
