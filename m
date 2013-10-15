From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 0/3] ACPI/Power: Fix infinite loop of runtime resume and suspend caused by turning on power resource
Date: Tue, 15 Oct 2013 23:05:04 +0200
Message-ID: <1957403.qYMK7iKccF@vostro.rjw.lan>
References: <1381849493-7977-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54963 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759708Ab3JOUxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 16:53:15 -0400
In-Reply-To: <1381849493-7977-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 15, 2013 11:04:50 PM Lan Tianyu wrote:
> Currently, clearing usb port(empty port) PM Qos NO_POWER_OFF flag twice will lead
> the usb port to fall into the infinite loop of runtime pm resume and
> suspend. This is caused by pm_request_resume() in the acpi_power_resume_dependent().
> Detail is in the following link.
> http://marc.info/?l=linux-acpi&m=138182749202885&w=2

As far as I can say, the bug is in USB, so I'm not quite sure why you want
to address it in the ACPI core?

Rafael

