From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [gpm] Untangling the sleep hotkey mess
Date: Wed, 30 Aug 2006 21:49:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25520 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751544AbWHaBtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2006 21:49:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, desktop_portables@lists.osdl.org

>> >> But input layer will be a hub of sorts and I am arguing for ACPI
>> >> to be converted to use input layer directly.
>> >
>> >What does lkml think of ACPI using the input layer directly? 
>> 
>> I think it is a good idea.
>> 
>> The only question I have is how to transition.
>> If I replace the acpi_bus_generate_event() calls for
>> power/sleep/lid/hotkeys
>> and replace them with input_report_key(), will there be something up
>> there
>> listening for these events when acpid does not get them?
>> 
>
>Let's start with adding reporting through input layer while still
>reporintg through /proc/acpi/event, this will allow gradual transition.
>
>What do you think about the patch below (should be applied on top of
>cleanup patch which is attached)? I will need to adjust it to
>!CONFIG_INPUT, but it can be done later if we agree on principle.

sorry for the delayed response -- looks like this one arrived at the
tail end of the ottawa trip...

I agree with this patch in principle.
it would be good to cut over to handing the power/sleep/lid buttons
as input device sooner rather than later.  Hopefully we don't get
all confused with double reporting of the events and can do one
or the other in user-space.

I don't understand some parts of the diff, including why the LID
event is always assumed to be an open event, and some of the diff
seemed to be moving code around and I wasn't clear on why.

thanks,
-Len
