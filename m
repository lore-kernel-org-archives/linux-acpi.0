From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 3 Oct 2017 18:04:46 +0200
Message-ID: <CAJZ5v0j+UPDJrWfiZzE26=PGSzmqZnQwMwCkei9N8+M1JkEmyg@mail.gmail.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <1668017.YFhvic4TWu@aspire.rjw.lan> <20171002211622.30d324ca@blatinox-laptop.localdomain>
 <5437275.MVdmGJ04h3@aspire.rjw.lan> <e0ab5224-1120-4b06-b625-822491d6b926@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:56598 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdJCQEr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Oct 2017 12:04:47 -0400
In-Reply-To: <e0ab5224-1120-4b06-b625-822491d6b926@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?B?SsOpcsOpbXkgTGVmYXVyZQ==?= <jeremy.lefaure@lse.epita.fr>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 3, 2017 at 2:34 PM, Colin Ian King <colin.king@canonical.com> w=
rote:
> On 03/10/17 12:39, Rafael J. Wysocki wrote:
>> On Tuesday, October 3, 2017 3:16:22 AM CEST J=C3=A9r=C3=A9my Lefaure wro=
te:
>>> On Mon, 02 Oct 2017 14:27:52 +0200
>>> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>>
>>>> ACPICA is soewhat special code, though and I'm not taking or ACKing pa=
tches
>>>> for it directly as a rule.
>>>>
>>>> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
>>> Why is it special code that can't use ARRAY_SIZE ? Is it because this
>>> macro is defined in linux/kernel.h ?
>
> However, ACPICA does have ACPI_ARRAY_LENGTH(x), see source/include/actype=
s.h

Fair enough, but that cleanup should go in via ACPICA upstream anyway.

Thanks,
Rafael
