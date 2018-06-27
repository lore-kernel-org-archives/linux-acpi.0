From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: small dmesg regression in kernel 4.17.3
Date: Wed, 27 Jun 2018 20:28:33 +0300
Message-ID: <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, erik.schmauss@intel.com
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

+Cc: Erik

On Tue, Jun 26, 2018 at 8:57 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> The attached dmesg contains non printable chars 0x01 33 around "ACPI BIOS=
 Error (bug): Could not resolve" which is a new issue compared to the dmesg=
 of 4.17.2
>
> System is a stable hardened Gentoo Linux at a ThinkPad T440s.

I bet the below commit makes this.

commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
Author: Erik Schmauss <erik.schmauss@intel.com>
Date:   Fri Jun 1 12:06:43 2018 -0700

   ACPICA: AML parser: attempt to continue loading table after error


So, it does add leading '\n' which flushes buffers followed by
printing the message you see. But, I'm guessing now, kernel adds a
default level since it's going to dmesg which you can see as
unprintable symbols.
Personally I'm not a fan of leading '\n':s since it brings more pain
than fixing something. It has special meaning (flushing buffers) and
many developers forget this.

--=20
With Best Regards,
Andy Shevchenko
