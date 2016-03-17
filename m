From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / property: Export a couple of symbols.
Date: Thu, 17 Mar 2016 02:25:21 +0100
Message-ID: <CAJZ5v0gonFNuZhm+77C3o0qJ6kGouEjs1Xg8WoP566qpXr19Xw@mail.gmail.com>
References: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33946 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbcCQBZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 21:25:23 -0400
In-Reply-To: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tn@semihalf.com>, David Daney <david.daney@cavium.com>

On Thu, Mar 17, 2016 at 1:23 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> The acpi_dev_prop_read() and acpi_dev_prop_read_single() can be called
> by drivers.

May I see the driver code that uses them?

Thanks,
Rafael
