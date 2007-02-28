From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Date: Wed, 28 Feb 2007 17:31:51 +0800
Message-ID: <1172655111.11100.50.camel@localhost.localdomain>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	 <20070226172716.b2e956b7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44748 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXB1Jc5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Feb 2007 04:32:57 -0500
In-Reply-To: <20070226172716.b2e956b7.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lm-sensors@lm-sensors.org, ibm-acpi-devel@lists.sourceforge.net, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Mon, 2007-02-26 at 17:27 +0100, Jean Delvare wrote:
> Hi Henrique,
> 
> On Sat, 24 Feb 2007 16:20:24 -0200, Henrique de Moraes Holschuh wrote:
> > I am working on a conversion of ibm-acpi to sysfs, and in the process I am
> > trying to do away with every non-generic interface I can.  At least two
> > ibm-acpi interfaces map directly to hwmon/lm-sensors style: fan and thermal.
> > I'd like to expose them as hwmon attributes, using the hwmon generic
> > interfaces for fan control and thermal sensor readings.
> 
> This would be really great. I was thinking about doing the same for the
> standard ACPI "fan" and "thermal" modules too, but I happen to be too
> busy for that :( Making these drivers compatible with the hwmon
> interface is one way to solve the ACPI vs. hwmon issues which have been
> reported and discussed lately.
> 
The standard ACPI "fan" and "thermal" modules?
I'm converting these two modules to sysfs. I think "thermal" has too
much ACPI specific information and is not that easy to have a generic
interface.
Could you give some more detailed descriptions please? :)

Thanks,
Rui
