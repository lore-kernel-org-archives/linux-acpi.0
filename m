From: Reinhard Tartler <Reinhard.Tartler@informatik.uni-erlangen.de>
Subject: Re: debugfs_create_dir return value in acer-wmi, intel_ips and ec_sys
Date: Fri, 26 Nov 2010 17:53:30 +0100
Message-ID: <878w0gvxf9.fsf@faui44a.informatik.uni-erlangen.de>
References: <4ceda4f7.0cedd80a.26b4.0222@mx.google.com>
	<Pine.LNX.4.64.1011250653370.15506@ask.diku.dk>
	<AANLkTikuHbF5FLT4OB8koZRgQkd5Ye7+O6HLrCY_vnq-@mail.gmail.com>
	<Pine.LNX.4.64.1011251119290.8543@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from apollon.tauware.de ([213.239.249.222]:35603 "EHLO
	apollon.tauware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab0KZRYH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2010 12:24:07 -0500
In-Reply-To: <Pine.LNX.4.64.1011251119290.8543@pc-004.diku.dk> (Julia Lawall's
	message of "Thu, 25 Nov 2010 11:21:20 +0100 (CET)")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Carlos Corbacho <carlos@>
Cc: Julia Lawall <julia@diku.dk>

On Thu, Nov 25, 2010 at 11:21:20 (CET), Julia Lawall wrote:

> On Thu, 25 Nov 2010, Corentin Chary wrote:
>
>> On Thu, Nov 25, 2010 at 7:01 AM, Julia Lawall <julia@diku.dk> wrote:
>> > On Thu, 25 Nov 2010, Corentin Chary wrote:
>> >
>> >> Hi,
>> >>
>> >> I was checking debugfs code in platform/x86, because I want to ad=
d
>> >> some files to eeepc-wmi. And I found something disturbing.
>> >>
>> >> The documentation says:
>> >>
>> >> > This call, if successful, will make a directory called name und=
erneath the
>> >> > indicated parent directory. =C2=A0If parent is NULL, the direct=
ory will be
>> >> > created in the debugfs root. =C2=A0On success, the return value=
 is a struct
>> >> > dentry pointer which can be used to create files in the directo=
ry (and to
>> >> > clean it up at the end). =C2=A0A NULL return value indicates th=
at something went
>> >> > wrong. =C2=A0If ERR_PTR(-ENODEV) is returned, that is an indica=
tion that the
>> >> > kernel has been built without debugfs support and none of the f=
unctions
>> >> > described below will work.
>> >>
>> >> But then, here is the code in acer-wmi:
>> >>
>> >> > static void remove_debugfs(void)
>> >> > {
>> >> > =C2=A0 =C2=A0 =C2=A0 debugfs_remove(interface->debug.devices);
>> >> > =C2=A0 =C2=A0 =C2=A0 debugfs_remove(interface->debug.root);
>> >> > }
>> >> >
>> >> > static int create_debugfs(void)
>> >> > {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0interface->debug.root =3D debugfs_cr=
eate_dir("acer-wmi", NULL);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!interface->debug.root) {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(A=
CER_ERR "Failed to create debugfs directory");
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >>
>> >> this code is *not* inside #ifndef CONFIG_DEBUG_FS, so debugfs_cre=
ate_dir
>> >> can return ERR_PTR(-ENODEV) right ?
>> >>
>> >> Then, remove_debug() will call debugfs_remove(ERR_PTR(-ENODEV)) r=
ight ?
>> >>
>> >> So, acpi-wmi seems to have an issue when debugfs is disabled, tha=
t's "ok".
>> >>
>> >> But then I took a look at intel_ips :
>> >>
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ips->debug_root =3D debugfs_create_d=
ir("ips", NULL);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ips->debug_root) {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(=
&ips->dev->dev,
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0"failed to create debugfs entries: %ld\n",
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0PTR_ERR(ips->debug_root));
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >>
>> >> Then PTR_ERR thing is strange, because ips->debug_root can only b=
e NULL
>> >> here...
>> >> But here, it's ok to only check NULL, because it's inside #ifndef
>> >> CONFIG_DEBUG_FS.
>> >>
>> >> So, two drivers checked, to weird error handling code. I did a qu=
ick grep and
>> >> opened
>> >> the first result: ec_sys.c.
>> >>
>> >> ec_sys.c depends on CONFIG_ACPI_EC_DEBUGFS but doesn't depend on
>> >> CONFIG_DEBUG_FS.
>> >>
>> >> Here, again, the code only check for !=3D NULL while it could be =
ERR_PTR(-
>> >> ENODEV):
>> >>
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ec_device_count =3D=3D 0) {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_ec_=
debugfs_dir =3D debugfs_create_dir("ec", NULL);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!acp=
i_ec_debugfs_dir)
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -ENOMEM;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >> >
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(name, "ec%u", ec_device_coun=
t);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dir =3D debugfs_create_dir(name,=
 acpi_ec_debugfs_dir);
>> >>
>> >> Here, acpi_ec_debugfs_dir (that can be an invalid pointer) is use=
d as
>> >> a parent dentry, and will be dereferenced without checks.
>> >>
>> >> I am missing something obvious, or are most of debugfs implementa=
tion
>> >> broken when debugfs is disabled ?
>>=20
>> Answer to myself, when debugfs is disabled, it's ok to give broken
>> dentry pointers to debugfs functions since they won't do anything.
>>=20
>> >> Julia, if I am right, coccinelle could help us right ? Can the to=
ol check
>> >> if the code is between #ifdef CONFIG_DEBUGS_FS ? That would help =
a lot.
>> >
>> > Unfortunately, at the moment, it can't; there is no matching on #i=
fdefs.
>> > Perhaps it could be added.
>>=20
>> Or better, something to check if a macro is defined in a particular =
contact ?
>
> Actually, Daniel Lohmann's group has been working on analyzing #ifdef=
's.  =20
> Perhaps they have a solution to this problem?  I have added them to t=
he CC=20
> list.

Thanks for bringing this thread to our attention, Julia.

We indeed do have a tool that is able to calculate the conditions under
which a line of code is activated or not, taking the constraints from
Kconfig into account. This allows us e.g. to find nested/broken ifdefs
like

#ifndef CONFIG_DEBUG_FS
=2E..
#ifdef CONFIG_DEBUG_FS
#else
#endif
=2E..
#endif

because we are taking kconfig into account, the inner CPP item can also
be some other kconfig item on which CONFIG_DEBUG_FS depends and we woul=
d
still find it.

I'm not sure yet how to turn this technique into a tool that would be
helpful to solve this particular problem. Maybe we can integrate this
somehow in coccinelle?

regards,
        Reinhard.

--=20
Gruesse/greetings,
Reinhard Tartler, KeyID 945348A4
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
