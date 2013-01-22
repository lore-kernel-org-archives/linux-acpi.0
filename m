From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] ACPI / PM: Expose power states of ACPI devices to
 user space
Date: Tue, 22 Jan 2013 15:42:48 -0800
Message-ID: <20130122234248.GB694@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <4247313.2G7Z3nCgM0@vostro.rjw.lan>
 <2760421.6nE3tkh92K@vostro.rjw.lan>
 <4706454.hY2fLkUfhN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:45753 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab3AVXmx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 18:42:53 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so3485750dan.9
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jan 2013 15:42:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4706454.hY2fLkUfhN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Tue, Jan 22, 2013 at 03:25:15AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to retrieve the current power state of a device with
> ACPI power management from user space via sysfs by adding two new
> attributes, power_state and real_power_state, to the sysfs directory
> associated with the struct acpi_device object representing the
> device's ACPI node.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

