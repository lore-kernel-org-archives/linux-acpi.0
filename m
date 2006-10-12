From: Daniel Drake <dsd@gentoo.org>
Subject: /proc/acpi/thermal_zone/THRM/temperature always reports 40C - is
 this a bug?
Date: Wed, 11 Oct 2006 21:03:27 -0400
Message-ID: <452D945F.6040709@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.iad.emailsrvr.com ([207.97.245.115]:28635 "EHLO
	smtp115.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S965242AbWJLBEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 21:04:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: eaburns@cisunix.unh.edu

Hi,

Ethan, at http://bugs.gentoo.org/142635 reports that the thermal zone 
always reads 40C. Is this something that should be filed at the kernel 
bugzilla for further investigation, or can we simply blame a 
buggy/unfixable BIOS? I understand that i2c/hwmon is the more common way 
of measuring temperatures.

Thanks,
Daniel
