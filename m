From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Mon, 23 Nov 2009 22:01:45 -0200
Message-ID: <be7a9f3d0911231601p4dcfa519q4d1504a8ee37fdad@mail.gmail.com>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>
	 <20091123134002.bac1e664.akpm@linux-foundation.org>
	 <4B0B1B62.2030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36153 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951AbZKXABk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 19:01:40 -0500
In-Reply-To: <4B0B1B62.2030302@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello,

On Mon, Nov 23, 2009 at 9:31 PM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 11/23/2009 03:40 PM, Andrew Morton wrote:
>>> [ =A0 =A00.000000] ACPI Error: A valid RSDP was not found
>>> (20090903/tbxfroot-219)
>>
>> No ACPI.
>>
>> Please raise a report against acpi_bios@kernel-bugs.osdl.org at
>> bugzilla.kernel.org, thanks.
>
> I believe that just means the machine doesn't support ACPI at all..

Yes; same as me.

Andrew should I report it anyway?

=46rom Alan message I understand that he believes it is a firmware
issue. I tried (without success) to contact DM&P about it asking for a
newer BIOS but nothing yet.

If I could workaround it, it would be nice since it could avoid issues
for users of those devices. I did research on Internet and found a lot
of users having the network adaptor not work and like and those
problems mostly looks like same issue I'm having.

--=20
Otavio Salvador                  O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854         http://projetos.ossystems.com.br
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
