From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Fri, 26 Oct 2007 18:44:58 +0200
Message-ID: <E1IlSIs-0006qT-Kc@faramir.fjphome.nl>
References: <200710262024.06012.arvidjaar@mail.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml20.kpnxchange.com ([213.75.38.85]:49433 "EHLO
	hpsmtp-eml20.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764843AbXJZQpB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Oct 2007 12:45:01 -0400
In-reply-To: <200710262024.06012.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> I have lost battery in 2.6.24-rc1. Without CONFIG_ACPI_PROCFS I have
> no /proc/acpi/battery and cannot test netlink interface because right now
> there is no consumer of this.

This is a known issue. Please see:
http://lkml.org/lkml/2007/10/22/110

Cheers,
Frans Pop
