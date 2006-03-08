From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Re is there an easy way to tell if anacpi_deviceis on a PCI bus?
Date: Wed, 8 Mar 2006 16:10:02 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30065236FA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:36277 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751127AbWCHVKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 16:10:07 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k28LA6rt002339
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 21:10:06 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k28LA4jU029104
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 21:10:06 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030813100632046
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 13:10:06 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org


>To find if an acpi_device is a child of a PCI bus, it seems
>that you need to look at its parent, and parents of parents...
>to see if any are a PCI bus, eg have HID PNP0A03.

Alternatively, you could go top-down,
acpi_get_devices( PCI_ROOT_HID_STRING,
	and provide a callback to walk below the PCI bus found
	to see if you find your device.

-Len

