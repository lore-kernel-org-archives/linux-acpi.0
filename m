From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Tue, 14 Dec 2010 10:20:41 +0100
Message-ID: <AANLkTi=0B2MHz-8ENz4+enkuB3KivPobLwaEc_BFEhQb@mail.gmail.com>
References: <AANLkTimahUpEL3cV6pFhkN8KqrphfVMSOw8xAN2=9jPy@mail.gmail.com>
	<AANLkTinarEEaJMLORBV9YozJ3GnFFVMJ-NOQhzRVJ0en@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinarEEaJMLORBV9YozJ3GnFFVMJ-NOQhzRVJ0en@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 13, 2010 at 4:43 PM, Sedat Dilek <sedat.dilek@googlemail.com> wrote:
> Hi Rafael,
>
> nice to see your patchset is in linux-next (next-20101213) now.
> More precisely in linux-acpi-2.6: 1/13 + 2/13 in release and rest/13
> in test GIT branch.
>
> What about the fix
> "Platform-x86-Make-fujitsu_laptop-use-acpi_bus_update_power.patch"
> [1]?
> Will this go over platform-x86/linux-next into linux-next GIT tree?
> Are you co-ordinating this with mjg?
>
> Regards,
> - Sedat -
>
> [1] https://patchwork.kernel.org/patch/357422/
> [2] http://git.kernel.org/?p=linux/kernel/git/mjg59/platform-drivers-x86.git;a=shortlog;h=refs/heads/linux-next
>

Thanks, the patch is now included in linux-next (next-20101214) (see [1]).

- Sedat -

[1] http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=5fd12c41e206d6bfda6eef1ed50e995a293e0777
