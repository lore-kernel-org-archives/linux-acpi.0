From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH v2 0/7] ideapad: hotkey enablement
Date: Thu, 9 Dec 2010 09:39:46 +0100
Message-ID: <AANLkTimUpXe34tSzvOJ_oo=fyqdAhwkk6xnN10BbdWrH@mail.gmail.com>
References: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 9, 2010 at 8:56 AM, Ike Panhc <ike.pan@canonical.com> wrote=
:
> Here are the enablement patches for hotkey events on ideapads and the=
se patches
> are made against current checkout of mainline kernel.
>
> After last time posting on LKML, there are several feedback and these=
 patches
> are modified.
>
> From Dmitry Torokhov, using markup on functions to let the compiler k=
nows where
> to put and passing private variable instead of using global vairable.=
 The

Great,

> acpi_handle is still a global variable becuase we need to pass handle=
 pointer
> to rfk_set with its opcode but only one data argument available.

Of course there is only one data argument available, but since it's a
void *, you
can use a struct with your handle and the opcode :).

> From Dave Hansen, select INPUT_SPARSEKMAP to fill the dependency.
>
> These patches are available in the git repository at:
> =C2=A0git://kernel.ubuntu.com/ikepanhc/ideapad-laptop.git ideapad-lap=
top
>
> Ike Panhc (7):
> =C2=A0ideapad: add platform driver for ideapad
> =C2=A0ideapad: let camera power control entry under platform driver

Maybe you could document that ? See
Documentation/ABI/testing/sysfs-platform-* files.

> =C2=A0ideapad: add hotkey support
> =C2=A0ideapad: select INPUT_SPARSEKMAP
> =C2=A0ideapad: add markups, unify comments and return result when ini=
t
> =C2=A0ideapad: pass ideapad_priv as argument (part 1)
> =C2=A0ideapad: pass ideapad_priv as argument (part 2)
>
> =C2=A0drivers/platform/x86/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A01 +
> =C2=A0drivers/platform/x86/ideapad-laptop.c | =C2=A0255 +++++++++++++=
+++++++++----------
> =C2=A02 files changed, 176 insertions(+), 80 deletions(-)


--=20
Corentin Chary
http://xf.iksaif.net
