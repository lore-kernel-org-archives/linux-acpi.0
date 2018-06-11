From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Possible regression caused by commit a192aa923b66a
Date: Mon, 11 Jun 2018 10:09:39 +0200
Message-ID: <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, perryhelionsemail@gmail.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Rafael,
>
> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
> LPSS: Consolidate runtime PM and system sleep handling") is the first bad
> commit.
>
> From the looks of it, it didn't introduce any behavioral change. So your
> help is appreciated.
>
> [1] https://bugs.launchpad.net/bugs/1774950

Well, the only difference is the iosf quirk AFAICS, but that should be
easy enough to check.  I'll try to cut a patch for that later today.
