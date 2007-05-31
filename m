From: Andreas Mohr <andi@rhlx01.hs-esslingen.de>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Thu, 31 May 2007 18:46:39 +0200
Message-ID: <20070531164639.GA13742@rhlx01.hs-esslingen.de>
References: <1180614979.2693.26.camel@localhost.localdomain> <1180615994.3030.166.camel@cookie.hadess.net> <1180619002.2693.35.camel@localhost.localdomain> <1180626416.3469.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:43225 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbXEaQql (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 12:46:41 -0400
Content-Disposition: inline
In-Reply-To: <1180626416.3469.7.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On Thu, May 31, 2007 at 04:46:56PM +0100, Richard Hughes wrote:

+	if (!hotkeys_over_input) {
+		if (!key_event_valid) {
+			hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+			if (hci_result == HCI_SUCCESS) {
+				key_event_valid = 1;
+				last_key_event = value;
+			} else if (hci_result == HCI_EMPTY) {
+				/* better luck next time */

HCI_EMPTY is *by far* the most frequent state to occur I think
(users won't press keys all the time), thus it's probably better(?)
for branch prediction to have this placed first, right?
Not that it matters too much instruction-wise, but still...

Apart from that I'm very happy to see progress on this front
(speaking as a "proud" owner of an old Toshiba notebook requiring
this stuff).

Oh, and maybe merge the sprintf()s into a single one to reduce code size.

And I'd definitely move the multiple identical "Re-enabled hotkeys" parts
into one single non-inlined(!) function for the same reason.
Not to mention that it's BUTT UGLY to have the *same* fat
multi-line comment duplicated bazillion times.

Thanks a lot!

Andreas Mohr
