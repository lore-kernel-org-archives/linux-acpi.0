From: Seunghun Han <kkamagui@gmail.com>
Subject: Re: [PATCH V4] acpi: acpica: fix acpi parse and parseext cache leaks
Date: Mon, 26 Jun 2017 14:26:00 +0900
Message-ID: <CAHjaAcQKYVtgjqqz2hWrwD_GrcNGZSr13rcM=cDGxhBJtxO1TA@mail.gmail.com>
References: <1498210597-112293-1-git-send-email-kkamagui@gmail.com>
 <CAHp75VfssiqaMG0Qm_0EG1pMotGg5pMt1_bZobAFYkoRUv1W3w@mail.gmail.com> <CAHjaAcRH6qnS8Fpkj4DC7ON7foBp0EQ1_w6YCnEu-BYhBP-O6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34667 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdFZF0C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2017 01:26:02 -0400
In-Reply-To: <CAHjaAcRH6qnS8Fpkj4DC7ON7foBp0EQ1_w6YCnEu-BYhBP-O6w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello, Andy.

Thank you for your reply.

Patch V4 is the last patch which is applied all changes from original code.
Due to maintainer's advice, Patch V1, V2, V3 have reverted and I made
the latest patch, Patch V4.
(the review is here, https://github.com/acpica/acpica/pull/278)

Therefore, it seems that incremental patch is not needed.

If you have any request, please let me know.

Best regards.

ps) I am sending email again after removing HTML part.

2017-06-26 7:12 GMT+09:00 Seunghun Han <kkamagui@gmail.com>:
> Hello, Andy.
>
> Thank you for your reply.
>
> Patch V4 is the last patch which is applied all changes from original cod=
e.
> Due to reviewer's advice, Patch V1, V2, V3 has reverted and I made the
> latest patch, Patch V4.
> Therefore, it seems that incremental patch is not needed.
>
> If you have any requests, please let me know.
>
> Best regards.
>
>
> 2017=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 1:13,=
 Andy Shevchenko <andy.shevchenko@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>>
>> On Fri, Jun 23, 2017 at 12:36 PM, Seunghun Han <kkamagui@gmail.com> wrot=
e:
>> > I'm Seunghun Han, and I work for National Security Research Institute =
of
>> > South Korea.
>>
>>
>> > -                                       /* Clean up */
>> > -                                       do {
>> > -                                               if (op) {
>> > -                                                       status2 =3D
>> > -
>> > acpi_ps_complete_this_op
>> > -                                                           (walk_stat=
e,
>> > op);
>> > -                                                       if (ACPI_FAILU=
RE
>> > -                                                           (status2))=
 {
>> > -
>> > return_ACPI_STATUS
>> > -
>> > (status2);
>> > -                                                       }
>> > -                                               }
>> > -
>> > -                                               acpi_ps_pop_scope(&
>> > -
>> > (walk_state->
>> > -
>> > parser_state),
>> > -                                                                 &op,
>> > -
>> > &walk_state->
>> > -
>> > arg_types,
>> > -
>> > &walk_state->
>> > -
>> > arg_count);
>> > -
>> > -                                       } while (op);
>>
>> I didn't get, do you send an incremental patch as a new version?!
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
