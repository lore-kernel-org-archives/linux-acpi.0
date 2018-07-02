From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
 is set
Date: Mon, 2 Jul 2018 11:06:22 +0200
Message-ID: <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Jeremy Linton <jeremy.linton@arm.com>, shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andrew Jones <drjones@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently we use the ACPI processor ID only for the leaf/processor nodes
> as the specification states it must match the value of ACPI processor ID
> field in the processor=E2=80=99s entry in the MADT.
>
> However, if a PPTT structure represents processors group, it match a
> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_=
VALID
> flag describe whether the ACPI processor ID is valid.
>
> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
> consistent instead of using table offset as it's currently done for non
> leaf nodes.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Hi,
>
> There's ongoing discussion on assigning ID based in OS using simple
> counters. It can never be consistent with firmware's view. So if the
> firmware provides valid UID for non-processors node, we must use it.

OK

Do you regard this as a fix for the recently merged PPTT material?  If
so, I should apply it as a fix for 4.18.

Thanks,
Rafael
