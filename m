From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: RE: [linux-pm] [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Fri, 10 Jul 2009 03:26:45 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298BB5F3EA2@bgsmsx502.gar.corp.intel.com>
References: <aec7e5c30907081952t4b88f1ccjeec6ab11b1d913b8@mail.gmail.com>
	<Pine.LNX.4.44L0.0907090937530.5823-100000@iolanthe.rowland.org>
 <aec7e5c30907090831y180b0972o6dcb961dd292a3c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27908 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbZGIV4x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2009 17:56:53 -0400
In-Reply-To: <aec7e5c30907090831y180b0972o6dcb961dd292a3c0@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

Hi,

I am newbee to this mailing list. Please excuse me if I am talking nons=
ense here.



On Thu, Jul 9, 2009 at 10:48 PM, Alan Stern<stern@rowland.harvard.edu> =
wrote:
>> On Thu, 9 Jul 2009, Magnus Damm wrote:
>>
>>> Clocks should be stopped as soon as possible without any delay. The
>>> clock stopping is very cheap performance wise. Also, the clock
>> stopping is done on bus level without invoking any driver callbacks.
>>> Delaying the clock stopping does not make any sense to me.
>>
>> In that case the device driver or bus subsystem should manage the
>> device's clock directly. =A0There's no need to tie it in with the ru=
ntime
>> PM framework. =A0Simply start the clock before each I/O operation an=
d
>> stop it afterward.

> It's not that easy. The clock needs to be enabled to let the hardware
> device perform device specific stuff. For instance, the clock for the
> LCD controller needs to be on to redraw the screen. When the driver
> knows that it's done with the clock it can notify the bus using
> Runtime PM.

Is there any plan to look into the "Clock Framework" that was developed=
 as part of OMAP and extending this to make it generic for all platform=
s?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
