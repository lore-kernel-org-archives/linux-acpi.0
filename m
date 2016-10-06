From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Fri, 7 Oct 2016 00:58:10 +0300
Message-ID: <57F6C8F2.5030403@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbcJFV6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 17:58:15 -0400
In-Reply-To: <20161005150641.GA22282@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Lorenzo,

Lorenzo Pieralisi wrote:
> FWIW I had a quick look at dts bindings with "compatible = nokia,smia"
> and related kernel driver.
>
> Those nodes require properties like clocks and power supplies, it
> seems to me that there are already ACPI PM methods to control those
> properties and therefore they should not be handled with PRP0001,
> I am happy to be corrected if I am wrong.

Those properties are there for DT only. ACPI already has native 
mechanisms for power resources but the driver right now still requires 
explicit regulator and clock, meaning that it does not work on an ACPI 
system out of the box.

The patch making the regulator optional is here:

<URL:http://www.spinics.net/lists/linux-media/msg106156.html>

I'll provide another patch to make the clock optional as well *once I 
can fully test it*. Right now I can't.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
