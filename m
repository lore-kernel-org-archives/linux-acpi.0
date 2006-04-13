From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Hotkeys do not work after Suspend-to-RAM (Kernel 2.6.16 + Samsung P35)
Date: Thu, 13 Apr 2006 14:27:00 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1222C98@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15142 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964783AbWDMG1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2006 02:27:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Klaus-Martin Scheuer <k-mscheuer@visio-net.de>, linux-acpi@vger.kernel.org

=20
Please file a bug on bugzilla.kernel.org in acpi category.
Please try ec_intr=3D0

--Luming

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org=20
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of=20
>Klaus-Martin Scheuer
>Sent: 2006=C4=EA3=D4=C231=C8=D5 15:25
>To: linux-acpi@vger.kernel.org
>Subject: Hotkeys do not work after Suspend-to-RAM (Kernel=20
>2.6.16 + Samsung P35)
>
>Hi,
>
>I just upgraded my notebook to the kernel version 2.6.16 and=20
>encountered that=20
>after a suspend-to-ram cycle (suspend-to-disk makes no=20
>problems) the hotkeys=20
>did not work. I tried to rmmod asus_acpi before suspending and=20
>modprobe it=20
>after resuming with no success. Then I tried to rmmod and=20
>modprobe it only=20
>after resuming. Again no sccess.
>I can state that there are no hotkey events in /var/log/messages after=
=20
>resuming, it works before suspending.
>
>Almost the same configuration worked with kernel 2.6.14.
>
>Any suggestions?
>
>Regards
>Klaus-Martin Scheuer
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
