From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Wed, 18 Jul 2007 20:33:21 +0900
Message-ID: <20070718113321.GG5711@inferi.kami.home>
References: <1184520879452-git-send-email-malattia@linux.it> <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <d120d5000707160622v7b62eeb5sd962e6e96dafdfec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:50385 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbXGRLjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 07:39:16 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000707160622v7b62eeb5sd962e6e96dafdfec@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Mon, Jul 16, 2007 at 09:22:28AM -0400, Dmitry Torokhov wrote:
> Hi Mattia,
>
> On 7/15/07, Mattia Dongili <malattia@linux.it> wrote:
>> +static int sony_laptop_input_keycode_map[] = {
>> +       KEY_RESERVED,    /* no event... */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_DOWN */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_UP */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_UP_PRESSED */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_PRESSED */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_RELEASED */
>
> Jogdial events are never passed through key_dev, do they? If so then
> we should not allow remapping them as it is pointless. EVCSKEYCODE
> shoudl return -EINVAL wehn trying to remap them.

yes, JOG events are going to the other input_dev.

...
>> +       KEY_RESERVED,   /* SONYPI_EVENT_LID_CLOSED */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_LID_OPENED */
>
> EV_SW/SW_LID unless LID events are delivered through ACPI (in which
> case we should hide these events completely).

every event except jogdial's is also being delivered through ACPI. Will
hide these from input then.

...
>> +       KEY_RESERVED,   /* SONYPI_EVENT_ANYBUTTON_RELEASED */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_BATTERY_INSERT */
>> +       KEY_RESERVED,   /* SONYPI_EVENT_BATTERY_REMOVE */

ACPI only stuff as well?

>> +       KEY_RESERVED,   /* SONYPI_EVENT_FNKEY_RELEASED */
>
> Do we really want let userspace remap this event?

hehehe, no, I don't think so.

Thanks for the comments
-- 
mattia
:wq!
