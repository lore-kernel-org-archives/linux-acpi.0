From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: Add _OST support for sysfs eject
Date: Thu, 10 May 2012 10:55:31 -0600
Message-ID: <1336668931.2581.27.camel@lorien2>
References: <1336507944-10219-1-git-send-email-toshi.kani@hp.com>
	 <1336507944-10219-4-git-send-email-toshi.kani@hp.com>
	 <1336581973.2498.15.camel@lorien2>
	 <1336587377.16730.150.camel@misato.fc.hp.com>
	 <1336664428.2581.21.camel@lorien2>
	 <1336667664.16730.201.camel@misato.fc.hp.com>
Reply-To: shuahkhan@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:18081 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab2EJQzd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 May 2012 12:55:33 -0400
In-Reply-To: <1336667664.16730.201.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: shuahkhan@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org

On Thu, 2012-05-10 at 10:34 -0600, Toshi Kani wrote:

> _OST is the ACPI standard method for the platform to receive the status
> of hotplug operations.  Some platforms may require the OS to support
> _OST in order to support ACPI hotplug operations.  For instance, if the
> platform has the management console where user can request a hotplug
> operation from, this _OST support would be required for the management
> console to show the result of a hotplug request to user.  
> 

This will be a good information capture in the change log.

Thanks Toshi. It is interesting to have platforms require optional
methods. Guess  you can never rule out weirdness in how these Specs.
actually get implemented :)


-- Shuah

