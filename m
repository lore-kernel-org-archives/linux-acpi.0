From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ACPI: add internal event mechanism
Date: Thu, 14 Jun 2007 23:28:11 -0400
Message-ID: <200706142328.12131.dtor@insightbb.com>
References: <20070601030628.642207B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:40451 "EHLO
	asav12.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbXFOD2O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2007 23:28:14 -0400
In-Reply-To: <20070601030628.642207B409F@zog.reactivated.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-acpi@vger.kernel.org

Hi Daniel,

On Thursday 31 May 2007 23:06, Daniel Drake wrote:
> This patch creates a new event system for communication between in-kernel
> ACPI drivers ("ievent"). It is simple - it should only be used to infrequently
> pass simple messages to a small audience.
> 
> This is used in an upcoming patch which makes the ACPI video driver listen for
> lid open events from the button driver. I hope it is generic enough to be
> useful to other ACPI drivers in the future.
> 

The same can be achieved within input layer framework (just register an input
handler latching onto EV_SW/SW_LID devices). Unless there are more users for
ACPI-specific implementation input layer might be better option.

-- 
Dmitry
