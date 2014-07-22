From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] acpi-video: Fix backlight taking 2 steps on a brightness
 keypress
Date: Tue, 22 Jul 2014 17:10:55 +0200
Message-ID: <53CE7EFF.9060903@redhat.com>
References: <1405686771-15483-1-git-send-email-hdegoede@redhat.com> <871ttdlavc.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbaGVPLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jul 2014 11:11:16 -0400
In-Reply-To: <871ttdlavc.fsf@nemi.mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org

Hi,

On 07/22/2014 04:35 PM, Bj=C3=B8rn Mork wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>
>> Hi All,
>>
>> Here is v2 of my cleaned up version of Linus' patch to fix this. New=
 this
>> version is that the module option is left as a boolean, and the keyp=
resses
>> handling simply always gets delayed 100 ms.
>>
>> Bj=C3=B8rn, can you please re-test to make sure I've not accidentall=
y broken
>> anything ? Note this still applies on top of the revert.
>
> Still works fine for me.  Sorry about the testing delay.

np. thanks for testing.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
