From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPI SPI slave device
Date: Tue, 1 Mar 2016 17:07:26 +0100
Message-ID: <20160301160726.GA23371@wunner.de>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
 <20160223073819.GK1770@lahna.fi.intel.com>
 <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
 <20160223150222.GL1770@lahna.fi.intel.com>
 <20160223153240.GM1770@lahna.fi.intel.com>
 <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
 <20160229082114.GC1770@lahna.fi.intel.com>
 <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
 <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:49667 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbcCAQG3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 11:06:29 -0500
Content-Disposition: inline
In-Reply-To: <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

Hi Leif,

On Tue, Mar 01, 2016 at 04:42:18PM +0100, Leif Liddy wrote:
> Do you know how I could print out the the name or id of the ACPI
> device from the acpi_device pointer?

printk("acpi_dev_name=%s\n", acpi_dev_name(adev));

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/acpi.h#n83
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/acpi/acpi_bus.h#n354

Best regards,

Lukas
