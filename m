From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 3.7-rc1 (nouveau_bios_score oops).
Date: Sun, 21 Oct 2012 20:13:14 +0300
Message-ID: <CA+55aFyFDQEgdmWZk5_WUUhMtJNngeg_-d6u36z8rE4e5xWaQQ@mail.gmail.com>
References: <1724445.dN2yMEzN6d@localhost> <20121020212036.GA1698@fritha.org>
 <20121020221948.GE5826@joi.lan> <2155889.FOmdXlva7q@localhost>
 <20121021120901.GA22587@joi.lan> <CA+55aFzYDY0FLGhVevqv9Gk0bnJnM4r13=JzWDO9hdySi8zFoA@mail.gmail.com>
 <20121021144908.GC22587@joi.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121021144908.GC22587@joi.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Heinz Diehl <htd@fritha.org>, Martin Peres <martin.peres@labri.fr>, Heinz Diehl <htd@fancy-poultry.org>, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, =?ISO-8859-2?Q?Pawe=B3_Sikora?= <pawel.sikora@agmk.net>
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 21, 2012 at 5:49 PM, Marcin Slusarz
<marcin.slusarz@gmail.com> wrote:
>
> I know. But this bug is not about broken firmware. It's about Linux kernel
> ACPI implementation, which (I think) wrongly interprets ACPI script.

Hmm. Len, care to comment? Marcin quoted the AML and our arguments in
an earlier thing. I don't read AML, so I was assuming it's the AML
itself that was buggy, not our interpretation of it..

               Linus
