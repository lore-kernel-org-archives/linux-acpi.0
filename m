From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Date: Thu, 1 Mar 2007 08:06:58 +0100
Message-ID: <20070301080658.64316c73.khali@linux-fr.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<1172655111.11100.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:1940 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932738AbXCAHIw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Mar 2007 02:08:52 -0500
In-Reply-To: <1172655111.11100.50.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lm-sensors@lm-sensors.org, ibm-acpi-devel@lists.sourceforge.net, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Wed, 28 Feb 2007 17:31:51 +0800, Zhang Rui wrote:
> The standard ACPI "fan" and "thermal" modules?
> I'm converting these two modules to sysfs. I think "thermal" has too
> much ACPI specific information and is not that easy to have a generic
> interface.
> Could you give some more detailed descriptions please? :)

Indeed, ACPI thermal zone may have more thermal trip points than the
hwmon interface specifies. Two of the trip points can be mapped to
temp1_max and temp1_crit, respectively. If we want to handle them all,
then probably we have to implement Henrique's suggestion and really
think in terms of thermal zones, i.e. the trip points would be mapped
to temp1_auto_point[1-*]_temp and possibly associated with a fan speed
output.

-- 
Jean Delvare
