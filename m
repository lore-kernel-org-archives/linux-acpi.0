From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] acpi: fix pwr_btn_event_pending build error
Date: Sun, 22 Jul 2012 00:52:43 +0300
Message-ID: <20120721215243.GA15362@shutemov.name>
References: <20120721214156.GA2515@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120721214156.GA2515@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 21, 2012 at 02:41:56PM -0700, Paul E. McKenney wrote:
> Hello!
>=20
> A recent build for KVM on x86 resulted in the following build error:
>=20
> drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event_pending=E2=
=80=99 defined but not
> +used [-Wunused-variable]
>=20
> This patch silences this error.
>=20
> Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 8856102..18347aa 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -57,7 +57,9 @@ MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on=
 suspend.");
>  MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
> =20
>  static u8 sleep_states[ACPI_S_STATE_COUNT];
> +#ifdef CONFIG_ACPI_SLEEP
>  static bool pwr_btn_event_pending;
> +#endif /* #ifdef CONFIG_ACPI_SLEEP */

__maybe_unused ?

--=20
 Kirill A. Shutemov
