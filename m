From: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Subject: Re: [PATCH v2] ACPI: move acpi_no_s4_hw_signature() declaration into
 #ifdef CONFIG_HIBERNATION
Date: Tue, 16 Oct 2012 15:21:43 +0800
Message-ID: <20121016072143.GH1965@yliu-dev.sh.intel.com>
References: <1350365052-27304-1-git-send-email-yuanhan.liu@linux.intel.com>
 <20121016062453.GA1505@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121016062453.GA1505@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 16, 2012 at 02:24:53PM +0800, Fengguang Wu wrote:
> On Tue, Oct 16, 2012 at 01:24:12PM +0800, Yuanhan Liu wrote:
> > acpi_no_s4_hw_signature is defined in #ifdef CONFIG_HIBERNATION blo=
ck,
> > but the current code put the declaration in #ifdef CONFIG_PM_SLEEP =
block.
> >=20
> > I happened to meet this issue when I turned off PM_SLEEP config man=
ually:
> > arch/x86/kernel/acpi/sleep.c:100:4: error: implicit declaration of =
function =E2=80=98acpi_no_s4_hw_signature=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>=20
> This should be more clear:
>=20
> Fix build error on !CONFIG_PM_SLEEP:

Actually, there are more erros besides the followling one on !CONFIG_PM=
_SLEEP.
This patch just fix one obvious one: the logical is wrong.

Thanks,
Yuanhan Liu
>=20
> arch/x86/kernel/acpi/sleep.c:100:4: error: implicit declaration of fu=
nction =E2=80=98acpi_no_s4_hw_signature=E2=80=99
>=20
> The root cause is, acpi_no_s4_hw_signature() is defined in
> #ifdef CONFIG_HIBERNATION block, but the current code put the
> declaration in #ifdef CONFIG_PM_SLEEP block.
>=20
> Thanks,
> Fengguang
>=20
> > v2: take better title and add build error message suggested by Feng=
guang
> >=20
> > Signed-off-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
> > Reviewed-by: Fengguang Wu <fengguang.wu@intel.com>
> > ---
> >  include/linux/acpi.h |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 90be989..a468429 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -257,8 +257,11 @@ int acpi_check_region(resource_size_t start, r=
esource_size_t n,
> > =20
> >  int acpi_resources_are_enforced(void);
> > =20
> > -#ifdef CONFIG_PM_SLEEP
> > +#ifdef CONFIG_HIBERNATION
> >  void __init acpi_no_s4_hw_signature(void);
> > +#endif
> > +
> > +#ifdef CONFIG_PM_SLEEP
> >  void __init acpi_old_suspend_ordering(void);
> >  void __init acpi_nvs_nosave(void);
> >  #endif /* CONFIG_PM_SLEEP */
> > --=20
> > 1.7.7.6
