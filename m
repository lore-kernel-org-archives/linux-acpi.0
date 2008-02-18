From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Mon, 18 Feb 2008 11:15:36 +0100
Message-ID: <20080218111536.511c4fbc@crazy>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
	<20080216211603.bb4f3582.randy.dunlap@oracle.com>
	<20080216214410.b9699910.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xT1SwLM0.DwMzfaHcJ31kdy";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758714AbYBRKQJ@vger.kernel.org>
In-Reply-To: <20080216214410.b9699910.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, michael@free-electrons.com
List-Id: linux-acpi@vger.kernel.org

--Sig_/xT1SwLM0.DwMzfaHcJ31kdy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Le Sat, 16 Feb 2008 21:44:10 -0800,
Andrew Morton <akpm@linux-foundation.org> a =C3=A9crit :

> Bustage in x86-configurable-dmi-scanning-code.patch.  Previously,
> DMI=3Dy was just hardwired.  Now, it becomes selectable and stuff
> breaks.
>=20
> I guess the DMI=3Dn version of dmi_check_system() could become a macro
> so we don't emit a reference to its argument, but that might generate
> unused-variable warnings elsewhere.

Thanks for your report. The issue is that some DMI fixup tables and
callbacks are defined inside #ifdef CONFIG_DMI, some others are not. We
need to normalize that to fix the build issue in all situations.

I've thought about it, and I see two options, but I can't decide which
one is the best, so I request your opinion on that.

 1) Remove the #ifdef CONFIG_DMI around DMI fixup tables and callbacks
    definition, so that everything exists and gcc is happy. gcc is able
    to optimize out the DMI fixup table (it is not present in the binary
    when compiling with DMI=3Dn), but gcc doesn't seem to be able to
    optimize out the DMI fixup callbacks (they are still present in the
    binary). So this would leave some unused code in the binary, which
    is not completely satisfying.

 2) Define macros such as DECLARE_DMI_FIXUP_TABLE and
    DECLARE_DMI_FIXUP_CALLBACK, which could then be used like this:

DECLARE_DMI_FIXUP_CALLBACK(set_bios_reboot, __init, d, {
	if (reboot_type !=3D BOOT_BIOS) {
		reboot_type =3D BOOT_BIOS;
		printk(KERN_INFO "%s series board detected. Selecting BIOS-method for reb=
oots.\n", d->ident);
	}
	return 0;
});

DECLARE_DMI_FIXUP_TABLE(reboot_dmi_table, __initdata, {
	{	/* Handle problems with rebooting on Dell E520's */
		.callback =3D set_bios_reboot,
		.ident =3D "Dell E520",
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
			DMI_MATCH(DMI_PRODUCT_NAME, "Dell DM061"),
		},
	}
});

     And use them everywhere, so that DMI fixup tables and callbacks
     are properly compiled out when DMI=3Dn. Here are the macro definition:

#ifdef CONFIG_DMI

#define DECLARE_DMI_FIXUP_TABLE(name, opts, contents...) \
	static struct dmi_system_id opts name [] =3D contents

#define DECLARE_DMI_FIXUP_CALLBACK(name, opts, id, contents...) \
	static int opts name(const struct dmi_system_id *id) contents

#else

#define DECLARE_DMI_FIXUP_TABLE(name, opts, contents...)

#define DECLARE_DMI_FIXUP_CALLBACK(name, opts, contents...)

#endif

     The issue I have with this option is that there are sometimes
     "driver_data" associated to DMI callbacks (see
     drivers/input/misc/wistron_btns.c for example) and I don't exactly
      see how to create a similar DECLARE_DMI_FIXUP_CALLBACK_DATA macro.

Thanks for your insights,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1500 pages!)

--Sig_/xT1SwLM0.DwMzfaHcJ31kdy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHuVrI9lPLMJjT96cRApEuAKChZnxIsgU2EZackWY9ZneC2QAd3QCfRqGx
oq9KqM+4pf3fMnCx0ESN9ZU=
=i3J8
-----END PGP SIGNATURE-----

--Sig_/xT1SwLM0.DwMzfaHcJ31kdy--
