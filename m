From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI defined devices not showing up under
 /sys/bus/platform/devices
Date: Mon, 22 Sep 2014 12:14:42 +0300
Message-ID: <20140922091442.GK1786@lahna.fi.intel.com>
References: <541ACA3B.3070309@redhat.com>
 <20140918140106.GU10854@lahna.fi.intel.com>
 <541B455C.4000601@redhat.com>
 <541B4870.2010906@gmail.com>
 <20140919084707.GB10854@lahna.fi.intel.com>
 <541C1821.30206@gmail.com>
 <20140919120103.GO10854@lahna.fi.intel.com>
 <541D3F4B.90504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8381 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbaIVJPN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2014 05:15:13 -0400
Content-Disposition: inline
In-Reply-To: <541D3F4B.90504@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcos Paulo de souza <marcos.souza.org@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sat, Sep 20, 2014 at 10:48:11AM +0200, Hans de Goede wrote:
> FOLT probably stands for Focaltech, and I bet this is the one which will show up in
> /sys/bus/acpi/devices/
> 
> If it does show up, is there any way to see how it is supposed to be connected ?

Well, given that the device name is PS2M I would expect it to be
connected via serio using PS/2 protocol.
