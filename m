From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
Date: Wed, 14 Mar 2012 12:48:11 +0000
Message-ID: <20120314124811.GB5155@srcf.ucam.org>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
 <1331588747-1247-3-git-send-email-mjg@redhat.com>
 <4F5FF26C.5040004@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45636 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab2CNMsS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2012 08:48:18 -0400
Content-Disposition: inline
In-Reply-To: <4F5FF26C.5040004@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org

On Wed, Mar 14, 2012 at 09:20:44AM +0800, Lan Tianyu wrote:
> On 2012=E5=B9=B403=E6=9C=8813=E6=97=A5 05:45, Matthew Garrett wrote:
> >Built-in USB devices will typically have a representation in the sys=
tem
> >ACPI tables. Add support for binding the two together so the USB cod=
e can
> >make use of the associated methods.
> hi Matthew:
> 	acpi glue framework only can cover situation that the port has been
> connected with some device. so without device, no acpi handle can be =
used to
> access "UPC" and "PLD".
> 	Whether the usb port is user-visible or not is also useful when ther=
e
> is no device. For example, if it is known that the usb port is not us=
er-visible
> and connectable. The usb hub port can be power-off.
> 	So usb/acpi binding should consider those usb ports without plugging=
 device.
> Does this make sense? :)

I agree that this woud be useful, but right now we don't have port=20
objects so there's nowhere to expose this. Greg, do you have any=20
feelings about how this coud be handled?

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
