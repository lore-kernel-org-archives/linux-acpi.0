From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH V3 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Sun, 29 Jul 2012 21:31:53 +0200
Message-ID: <50158FA9.7080700@gmx.net>
References: <50158321.4030007@gmx.net> <201207292122.28249.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:51311 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753359Ab2G2Tb4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2012 15:31:56 -0400
In-Reply-To: <201207292122.28249.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: bhelgaas@google.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 29/07/12 21:22, Rafael J. Wysocki wrote:

> Hi,
> 

[... long snip ...]

> 
> Do I understand correctly that you want to disable those things through
> sysfs?
> 
> Rafael
> 

Hi Rafael, 

the aim is to select a PNP ACPI option where resources can be disabled
(or are not needed).  E.g., the parallel port of the 600E can be used
with and without IRQ lines.  The means to allow for this is to use the
sysfs interface to select disabled resources (just like any other 
resource value).  In https://lkml.org/lkml/2011/7/3/41, I used the 
following example:

  echo disable > /sys/bus/pnp/devices/$device/resources
  echo clear > /sys/bus/pnp/devices/$device/resources
  echo set irq disabled > /sys/bus/pnp/devices/$device/resources
  echo fill > /sys/bus/pnp/devices/$device/resources
  echo activate > /sys/bus/pnp/devices/$device/resources

The third line is made possible by the patch series.  All other
lines are already implemented. 

--- Witold
