From: Tyler Baicar <baicar.tyler@gmail.com>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date: Thu, 20 Dec 2018 13:28:39 -0500
Message-ID: <CABo9ajAVFkasgAhpQFX4-__q0TRdWBfb1_Mdk9-RhCwO9MDO8Q@mail.gmail.com>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545238252-79630-1-git-send-email-darcari@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Arcari <darcari@redhat.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 19, 2018 at 1:33 PM David Arcari <darcari@redhat.com> wrote:
>
> From: Lenny Szubowicz <lszubowi@redhat.com>
>
> In __ghes_panic() clear the block status in the APEI generic
> error status block for that generic hardware error source before
> calling panic() to prevent a second panic() in the crash kernel
> for exactly the same fatal error.
>
> Otherwise ghes_probe(), running in the crash kernel, would see
> an unhandled error in the APEI generic error status block and
> panic again, thereby precluding any crash dump.
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Signed-off-by: David Arcari <darcari@redhat.com>

Good catch!

Tested-by: Tyler Baicar <baicar.tyler@gmail.com>
