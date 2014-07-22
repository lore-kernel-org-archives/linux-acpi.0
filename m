From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH v2] acpi-video: Fix backlight taking 2 steps on a brightness keypress
Date: Tue, 22 Jul 2014 16:35:35 +0200
Message-ID: <871ttdlavc.fsf@nemi.mork.no>
References: <1405686771-15483-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:37869 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbaGVOgn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2014 10:36:43 -0400
In-Reply-To: <1405686771-15483-1-git-send-email-hdegoede@redhat.com> (Hans de
	Goede's message of "Fri, 18 Jul 2014 14:32:50 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi All,
>
> Here is v2 of my cleaned up version of Linus' patch to fix this. New =
this
> version is that the module option is left as a boolean, and the keypr=
esses
> handling simply always gets delayed 100 ms.
>
> Bj=C3=B8rn, can you please re-test to make sure I've not accidentally=
 broken
> anything ? Note this still applies on top of the revert.

Still works fine for me.  Sorry about the testing delay.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
